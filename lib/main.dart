import 'package:epsp_sige/apps/MonApplication.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // IMPORTANT : Init FFI d'abord
  sqfliteFfiInit();
  //
  // Utiliser la bonne fabrique pour sqflite_common_ffi
  databaseFactory = databaseFactoryFfi;

  //
  await GetStorage.init();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    print(details.stack);
    return Scaffold(
      body: Center(
        child: Text("Erreur inattendue"),
      ),
    );
  };

  runApp(MonApplication());
}
