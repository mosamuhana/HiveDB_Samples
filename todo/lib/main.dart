import 'package:flutter/material.dart';

import 'src/hive.dart';
import 'src/pages.dart';

void main() async {
  await initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      home: FuturePage(
        future: initBoxes(),
        builder: (_) => HomePage(),
      ),
    );
  }
}
