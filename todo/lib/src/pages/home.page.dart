import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets.dart';
import '../models.dart';
import '../hive.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: settingsBox.listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => NewTodoDialog(),
          );
        },
      ),
    );
  }

  Widget _buildWithBox(BuildContext context, Box settings, Widget child) {
    var reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hive To-Do',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(
                reversed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 32,
              ),
              onPressed: () {
                settings.put('reversed', !reversed);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          kIsWeb ? 'Refresh this tab to test persistence.' : 'Restart the app to test persistence.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: TodoList(reversed: reversed),
        ),
        /*
        Expanded(
          child: ValueListenableBuilder<Box<Todo>>(
            valueListenable: todosBox.listenable(),
            builder: (context, box, _) {
              var todos = box.values.toList();
              if (reversed) {
                todos = todos.reversed.toList();
              }
              return TodoList(todos);
            },
          ),
        ),
        */
      ],
    );
  }
}
