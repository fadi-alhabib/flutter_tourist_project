import 'package:flutter/material.dart';
import 'package:tourist/cache_helper.dart';
import 'package:tourist/config/app_theme.dart';
import 'package:tourist/screens/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Tourist', theme: lightTheme, home: MainPage());
  }
}
