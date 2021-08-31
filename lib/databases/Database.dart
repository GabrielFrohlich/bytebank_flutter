import 'package:byteblank/databases/dao/contact_dao.dart';
import 'package:byteblank/models/Contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(join(await getDatabasesPath(), 'bytebank.db'),
      onCreate: (db, version) {
    db.execute(ContactDao.tableSql);
  }, version: 1);
}
