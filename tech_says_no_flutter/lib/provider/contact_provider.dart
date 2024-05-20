import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:tech_says_no/model/contact.dart';
import 'package:http/http.dart' as http;
import 'package:tech_says_no/shared_prefs.dart';

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
    state = data
        .map((e) => Contact(
            name: e['name'] as String,
            phoneNumber: e['phoneNumber'] as String,
            id: e['id'] as String))
        .toList();
  }

  void addContact(Contact contact) async {
    final db = await _getDB();

    db.insert('contacts', {
      'name': contact.name,
      'phoneNumber': contact.phoneNumber,
      'id': contact.id
    });
    state = [...state, contact];

    String email =
        await SharedPreferencesService.instance.getString('email') ?? '';
    await http.post(
      Uri.parse('http://192.168.0.19:5000/add_contact'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'contact_phone': contact.phoneNumber,
        'contact_name': contact.name,
      }),
    );
  }

  void deleteContact(String id) async {
    final db = await _getDB();
    db.delete('contacts', where: 'id = ?', whereArgs: [id]);
    state = state.where((element) => element.id != id).toList();
  }
}

final contactsProvider = StateNotifierProvider<ContactNotifier, List<Contact>>(
    (ref) => ContactNotifier());
