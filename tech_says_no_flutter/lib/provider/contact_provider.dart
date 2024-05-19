import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:tech_says_no/model/contact.dart';

class ContactNotifier extends StateNotifier<List<Contact>> {
  ContactNotifier() : super([]);

  Future<Database> _getDB() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE contacts(id TEXT PRIMARY KEY, name TEXT, phoneNumber TEXT)');
      },
      version: 1,
    );

    return db;
  }

  Future<void> fetchContacts() async {
    final db = await _getDB();
    final data = await db.query('contacts');
    state = data.map((e) => Contact(name: e['name'] as String, phoneNumber: e['phoneNumber'] as String, id: e['id'] as String)).toList();

    
  }

  void addContact(Contact contact) async{
    final db = await _getDB();

    db.insert('contacts', {'name': contact.name, 'phoneNumber': contact.phoneNumber, 'id': contact.id});
    state = [...state, contact];
  }

}

final contactsProvider = StateNotifierProvider<ContactNotifier, List<Contact>>((ref) => ContactNotifier());
