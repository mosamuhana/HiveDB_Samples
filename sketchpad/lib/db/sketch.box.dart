import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'colored_path.dart';
import 'colored_path_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SketchBox {
  static const name = 'sketch';

  static Future<void> register() async {
    Hive.registerAdapter<ColoredPath>(ColoredPathAdapter());
  }

  static Future<Box<ColoredPath>> open() async {
    return await Hive.openBox<ColoredPath>(name);
  }

  static Box<ColoredPath> get box {
    return Hive.box<ColoredPath>(name);
  }

  static ValueListenable<Box<ColoredPath>> listenable({List<dynamic> keys}) {
    return box.listenable(keys: keys);
  }
}
