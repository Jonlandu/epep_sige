import 'dart:convert';
import 'dart:io';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class FormService {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final String apiUrl = 'https://votre-api.com/endpoint';

  Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> syncFormsWithApi() async {
    if (!await hasInternetConnection()) return;

    final unsyncedForms = await dbHelper.getUnsyncedForms();

    for (final form in unsyncedForms) {
      try {
        final formData = jsonDecode(form['form_data']);
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(formData),
        ).timeout(const Duration(seconds: 30));

        if (response.statusCode == 200) {
          await dbHelper.markAsSynced(form['id']);
        } else {
          await dbHelper.incrementSyncAttempts(form['id']);
        }
      } catch (e) {
        print('Error syncing form ${form['id']}: $e');
        await dbHelper.incrementSyncAttempts(form['id']);
      }

      // Petite pause entre les envois
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}