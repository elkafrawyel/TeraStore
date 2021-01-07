import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'MyApp.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // Get.testMode = true;
  runApp(MyApp());

  //print responses
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print(event.message);
  });
}
