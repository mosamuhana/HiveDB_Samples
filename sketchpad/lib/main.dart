import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'db/colored_path.dart';
import 'db/colored_path_adapter.dart';
import 'drawing_screen.dart';

void main() async {
  if (!kIsWeb) {
    //var dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter();
  }

  //Hive.registerAdapter(ColoredPathAdapter());
  Hive.registerAdapter<ColoredPath>(ColoredPathAdapter());

  //await Hive.deleteFromDisk();
  //await Hive.openBox<ColoredPath>(HiveBoxNames.sketchpad);

  await Boxes.init();

  runApp(DrawApp());
}

class DrawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Sketchpad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      home: FutureBuilder<Box<ColoredPath>>(
        future: Boxes.openSketchBox(),
        builder: (BuildContext context, AsyncSnapshot<Box<ColoredPath>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print(snapshot.error);
              return Scaffold(
                body: Center(
                  child: Text('Something went wrong :/'),
                ),
              );
            } else {
              return DrawingScreen();
            }
          } else {
            return Scaffold(
              body: Center(
                child: Text('Opening Hive...'),
              ),
            );
          }
        },
      ),
    );
  }
}
