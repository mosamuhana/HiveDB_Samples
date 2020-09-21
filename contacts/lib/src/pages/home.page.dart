import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../dialogs.dart';
import '../pages.dart';
import '../hive.dart';
import '../widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts App with Hive')),
      body: ValueListenableBuilder<Box<Contact>>(
        valueListenable: hive.contacts.listenable(),
        builder: (context, box, _) {
          //final contacts = ContactService.instance.getAll();
          final contacts = hive.contacts.values.toList();
          if (contacts.isEmpty) {
            return Center(child: Text("No contacts"));
          }

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              //Contact contact = box.getAt(index);
              Contact contact = contacts[index];
              return ContactCard(
                contact: contact,
                onDelete: () async {
                  final ok = await showDeleteDialog(context, "Do you want to delete ${contact.name}?");
                  if (ok) {
                    //await box.deleteAt(index);
                    //await ContactService.instance.remove(contact.id);
                    await hive.contacts.delete(contact.id);
                  }
                },
                onTap: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ContactPage()),
            ),
          );
        },
      ),
    );
  }

  final _hbox5 = SizedBox(height: 5);
}
