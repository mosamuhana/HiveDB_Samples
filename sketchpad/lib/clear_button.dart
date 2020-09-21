import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'constants.dart';
import 'db/colored_path.dart';

class ClearButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Boxes.sketchBox.listenable(),
      builder: (BuildContext context, Box<ColoredPath> box, Widget child) {
        return IconButton(
          icon: Icon(Icons.delete),
          onPressed: box.length == 0 ? null : () => box.clear(),
        );
      },
    );
  }
}
