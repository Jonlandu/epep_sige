// sync_service.dart
import 'dart:convert';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/utils/Endpoints.dart';
import 'package:epsp_sige/utils/Queries.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SyncServiceController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final Connectivity _connectivity = Connectivity();

  Future<bool> _checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<HttpResponse> syncForm(String formData, {String? token}) async {
    return await postData(Endpoints.submitForm, formData);
  }

  Future<void> syncPendingForms({String? token}) async {
    if (!await _checkConnection()) return;

    final unsyncedForms = await _dbHelper.getUnsyncedForms();

    for (final form in unsyncedForms) {
      try {
        final formData = jsonDecode(form['form_data']);
        final response = await syncForm(formData, token: token);

        if (response.status) {
          await _dbHelper.markAsSynced(form['id']);
        } else {
          await _dbHelper.incrementSyncAttempts(form['id']);
        }
      } catch (e) {
        print('Error syncing form ${form['id']}: $e');
        await _dbHelper.incrementSyncAttempts(form['id']);
      }

      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}
