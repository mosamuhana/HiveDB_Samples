import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive/index.dart';

export 'hive/contact.dart' show Contact;
export 'hive/relationship.dart' show Relationship;

const CONTACTS_BOX = "contacts";

class _HiveDB {
  bool _init = false;

  Future<void> init() async {
    if (_init) return true;

    await Hive.initFlutter();

    Hive.registerAdapter(ContactAdapter());
    Hive.registerAdapter(RelationshipAdapter());

    await Hive.openBox<Contact>(CONTACTS_BOX);

    _init = true;
  }

  Box<Contact> get contacts => Hive.box<Contact>(CONTACTS_BOX);
}

final hive = _HiveDB();

const _mapToString = <Relationship, String>{
  Relationship.Family: "Family",
  Relationship.Friend: "Friend",
};

extension RelationshipX on Relationship {
  String get asString {
    if (this == null) return null;
    return _mapToString[this];
  }
}
