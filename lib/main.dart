import 'package:flutter/material.dart';

import 'app.dart';
import 'data/datasources/remote/firebase/firebase_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseInitializer.initialize();

  runApp(const GSoftBizApp());
}