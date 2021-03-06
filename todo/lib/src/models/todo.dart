import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime created;

  @HiveField(2)
  bool done = false;
}

extension TodoX on Todo {
  String get time {
    if (created == null) return '';
    return '${created.hour}:${created.minute}:${created.second}';
  }
}
