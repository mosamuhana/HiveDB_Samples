import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models.dart';
import '../hive.dart';

class TodoList extends StatelessWidget {
  final bool reversed;

  const TodoList({this.reversed});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Todo>>(
      valueListenable: todosBox.listenable(),
      builder: (_, box, __) {
        var todos = box.values.toList();

        if (todos.isEmpty) {
          return Center(
            child: Text('Noting to do... Great!'),
          );
        }

        if (reversed) todos = todos.reversed.toList();

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (_, i) => _buildTodo(todos[i]),
        );
      },
    );
  }

  Widget _buildTodo(Todo todo) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: todo.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  todo.time,
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              iconSize: 30,
              icon: Icon(todo.done ? Icons.clear : Icons.check),
              onPressed: () async {
                todo.done = !todo.done;
                await todo.save();
              },
            ),
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.delete),
              onPressed: () => todo.delete(),
            ),
          ],
        ),
      ),
    );
  }
}
