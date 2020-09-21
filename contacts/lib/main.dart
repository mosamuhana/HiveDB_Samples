import 'package:flutter/material.dart';

import 'src/hive.dart';
import 'src/pages.dart';

void main() {
  runApp(FutureBuilder(
    future: hive.init(),
    builder: (_, s) {
      if (s.connectionState != ConnectionState.done) {
        return MaterialApp(
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      }
      return MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      home: HomePage(),
    );
  }
}
