import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models.dart';

const BOX_SETTINGS = 'settings';
const BOX_TODOS = 'todos';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
}

Future<void> initBoxes() async {
  //await Future.delayed(Duration(seconds: 3));
  await Future.wait([
    Hive.openBox(BOX_SETTINGS),
    Hive.openBox<Todo>(BOX_TODOS),
  ]);
}

Box get settingsBox => Hive.box(BOX_SETTINGS);
Box<Todo> get todosBox => Hive.box<Todo>(BOX_TODOS);
