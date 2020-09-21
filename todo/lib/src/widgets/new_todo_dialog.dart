import 'package:flutter/material.dart';

import '../models.dart';
import '../hive.dart';

class NewTodoDialog extends StatefulWidget {
  @override
  _NewTodoDialogState createState() => _NewTodoDialogState();

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => NewTodoDialog(),
    );
  }
}

class _NewTodoDialogState extends State<NewTodoDialog> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create To-Do Entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter a task',
            ),
            controller: controller,
          ),
          SizedBox(height: 10),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add'),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              var todo = Todo()
                ..name = controller.text
                ..created = DateTime.now();
              todosBox.add(todo);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
