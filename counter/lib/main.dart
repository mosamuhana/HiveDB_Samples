import 'package:flutter/material.dart';

import 'pages/home.page.dart';
import 'hive.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //fontFamily: 'OpenSans',
      ),
      home: FutureBuilder(
        future: hive.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print(snapshot.error);
              return Scaffold(
                body: Center(
                  child: Text('Something went wrong :/'),
                ),
              );
            } else {
              return HomePage();
            }
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading...'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
