import 'package:flutter/material.dart';

import '../hive.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  ContactCard({
    Key key,
    this.contact,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onDelete,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${contact.name?.toString() ?? ''}"),
                    _hbox5,
                    Text("${contact.phone?.toString() ?? ''}"),
                    _hbox5,
                    Text("Age: ${contact.age?.toString() ?? ''}"),
                    _hbox5,
                    Text("Relationship: ${contact.relationship?.asString ?? ''}"),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _hbox5 = SizedBox(height: 5);
}
