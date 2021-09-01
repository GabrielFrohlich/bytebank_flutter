import 'package:byteblank/models/Contact.dart';
import 'package:sqflite/sqflite.dart';

import '../Database.dart';

class ContactDao {
  static const String tableSql =
      'CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY,'
      '$_name TEXT,'
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'accountNumber';

  Future<int>? save(Contact contact) async {
    final Database db = await getDatabase();

    return db.insert(_tableName, contact.toMap());
  }

  Future<List<Contact>?> findAll() async {
    final Database db = await getDatabase();
    return this.toList(await db.query('contacts'));
  }

  toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> map in result) {
      final Contact contact = Contact(
        map['name'],
        map['accountNumber'],
        id: map['id'],
      );

      contacts.add(contact);
    }
    return contacts;
  }
}
