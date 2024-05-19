import 'package:uuid/uuid.dart';

const uuid = Uuid();


class Contact{
  final String id;
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber, String? id}) : id = id ?? uuid.v4();
}