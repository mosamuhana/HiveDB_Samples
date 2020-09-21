import 'package:hive/hive.dart';

import 'db/colored_path.dart';

class Boxes {
  static const SKETCH = 'sketch';

  static Future<void> init() async {
    await openSketchBox();
  }

  static Future<Box<ColoredPath>> openSketchBox() => Hive.openBox<ColoredPath>(SKETCH);

  static Box<ColoredPath> get sketchBox => Hive.box<ColoredPath>(SKETCH);
}
