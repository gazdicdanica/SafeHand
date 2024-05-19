import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_says_no/model/contact.dart';
import 'package:tech_says_no/widgets/contact.dart';
import 'package:tech_says_no/provider/contact_provider.dart';

class AddContact extends ConsumerStatefulWidget {
  const AddContact({super.key});

  @override
  ConsumerState<AddContact> createState() => _AddContactState();
}

class _AddContactState extends ConsumerState<AddContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late Future<void> _contactsFuture;
  // List<Contact> contacts = List<Contact>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _contactsFuture = ref.read(contactsProvider.notifier).fetchContacts();
  }

  void _showAddContactModal() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full name',
                    hintText: 'Enter contacts full name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    hintText: 'Enter your phone number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final String name = _nameController.text;
                      final String phone = _phoneController.text;
                      if (name.isNotEmpty && phone.isNotEmpty) {
                        setState(() {
                          ref.read(contactsProvider.notifier).addContact(
                              Contact(name: name, phoneNumber: phone));
                        });
                        _nameController.clear();
                        _phoneController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 15)),
                      elevation: MaterialStateProperty.all(5),
                    ),
                    child: const Text(
                      'Save contact',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(contactsProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactModal,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              const Text(
                'My Contacts',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                    future: _contactsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if(contacts.isEmpty){
                        return const Center(child: Text('No contacts added yet!'));

                      }
                      return ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          return ContactWidget(contact: contacts[index]);
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
