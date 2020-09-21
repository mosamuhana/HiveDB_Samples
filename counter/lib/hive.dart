import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

const _COUNTER = 'myBox';

class _HiveBoxes {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<int>(_COUNTER);
  }

  Box<int> get counter => Hive.box<int>(_COUNTER);
}

final hive = _HiveBoxes();

class HiveCounter {
  static const KEY_COUNTER = 'counter';

  static int get counter => hive.counter.get(KEY_COUNTER, defaultValue: 0);

  static set counter(int value) => hive.counter.put(KEY_COUNTER, value);
}
