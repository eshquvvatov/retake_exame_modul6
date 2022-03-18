import 'package:flutter/material.dart';
import 'package:retake_exame_modul6/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:retake_exame_modul6/service/hive_service.dart';
void main()async {
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
