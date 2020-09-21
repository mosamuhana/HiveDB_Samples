import 'package:flutter/material.dart';

import 'clear_button.dart';
import 'color_list.dart';
import 'db/colored_path.dart';
import 'drawing_area.dart';
import 'sketch_paint.dart';
import 'undo_button.dart';

class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SketchPaint(),
                DrawingArea(selectedColorIndex),
                Positioned(
                  top: 25,
                  left: 10,
                  child: Text('powered by Hive', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ColorList(
                        index: selectedColorIndex,
                        colors: ColoredPath.colors,
                        onChange: (i) => setState(() => selectedColorIndex = i),
                      ),
                    ),
                    ClearButton(),
                    UndoButton(),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
