import 'package:flutter/material.dart';
import 'package:tech_says_no/model/contact.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({super.key, required this.contact});

  final Contact contact;

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(255, 214, 214, 214)),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color:  Color.fromARGB(200, 214, 214, 214),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.contact.name, style: const TextStyle(fontSize: 20)),
            Text(widget.contact.phoneNumber, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
