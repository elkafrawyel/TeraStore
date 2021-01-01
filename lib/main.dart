import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'MyApp.dart';
import 'helper/PreferenceUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PreferenceUtils.init();
  await GetStorage.init();
  runApp(MyApp());
}
