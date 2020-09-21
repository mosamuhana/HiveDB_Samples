import 'package:flutter/material.dart';

import '../hive.dart';
//import '../_models.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  const ContactPage({Key key, this.contact}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final formKey = GlobalKey<FormState>();
  Contact contact;

  //bool get valid => (name != null && name.isNotEmpty) && (phone != null && phone.isNotEmpty) && (age != null && age > 0);
  bool get valid => formKey.currentState?.validate() ?? false;

  @override
  void initState() {
    var c = widget.contact;
    contact = c == null ? Contact() : c;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              TextFormField(
                autofocus: true,
                initialValue: "${contact.name?.toString() ?? ''}",
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (v) => setState(() => contact.name = v),
                validator: (v) => v.length > 0 ? null : 'Enter name',
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: "${contact.age?.toString() ?? ''}",
                  maxLength: 3,
                  maxLengthEnforced: true,
                  decoration: const InputDecoration(labelText: "Age"),
                  onChanged: (v) => setState(() => contact.age = int.tryParse(v) ?? 0),
                  validator: (v) {
                    var n = int.tryParse(v) ?? 0;
                    if (n > 0) return null;
                    return 'Invalid age';
                  }),
              TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: "${contact.phone?.toString() ?? ''}",
                decoration: const InputDecoration(labelText: "Phone"),
                onChanged: (v) => setState(() => contact.phone = v),
                validator: (v) => v.length > 0 ? null : 'Enter phone',
              ),
              DropdownButtonFormField<Relationship>(
                items: Relationship.values.map((Relationship value) {
                  return DropdownMenuItem<Relationship>(
                    value: value,
                    child: Text(value.asString),
                  );
                }).toList(),
                value: contact.relationship,
                hint: Text("Relationship"),
                onChanged: (v) => setState(() => contact.relationship = v),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("Submit"),
                    color: Colors.blue,
                    onPressed: !valid ? null : _onSubmit,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (!valid) return;

    if (contact.id == null) {
      await hive.contacts.add(contact);
    } else {
      await hive.contacts.put(contact.id, contact);
    }

    Navigator.of(context).pop();
  }
}
