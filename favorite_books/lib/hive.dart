import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

export 'package:hive/hive.dart';
export 'package:hive_flutter/hive_flutter.dart';

const _favoritesBoxName = 'favorite_books';

class _Hive {
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_favoritesBoxName);
  }

  Box<String> get favoriteBooks => Hive.box(_favoritesBoxName);
}

final hive = _Hive();
