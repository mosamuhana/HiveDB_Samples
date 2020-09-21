import 'package:hive/hive.dart';

import 'relationship.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  //int id;

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  Relationship relationship;

  @HiveField(3)
  String phone;

  //@override
  //dynamic get key => id;
  int get id => key == null ? null : key as int;

  bool get valid => (name?.isNotEmpty ?? false) && (phone?.isNotEmpty ?? false) && (age ?? 0) > 0;

  Contact({
    //this.id,
    this.name,
    this.age,
    this.phone,
    this.relationship,
  });

  Contact copyWith({
    int id,
    String name,
    int age,
    String phone,
    Relationship relationship,
  }) {
    return Contact(
      //id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      phone: phone ?? this.phone,
      relationship: relationship ?? this.relationship,
    );
  }
}
