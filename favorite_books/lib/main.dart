import 'package:flutter/material.dart';

import 'hive.dart';
import 'home.page.dart';

void main() async {
  await hive.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Books with Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home2Page(),
    );
  }
}
