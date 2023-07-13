import 'package:flutter/material.dart';
import 'package:pertemuan_6/screen/home_page.dart';
import 'package:pertemuan_6/screen/login_page.dart';
import 'package:pertemuan_6/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPref.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        "home": (context) => HomePage(),
      },
    );
  }
}
