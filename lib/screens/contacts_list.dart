import 'package:byteblank/databases/dao/contact_dao.dart';
import 'package:byteblank/models/Contact.dart';
import 'package:flutter/material.dart';

import 'contact_form.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _dao = ContactDao();

  final List<Contact> contacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts')),
      body: FutureBuilder<List<Contact>?>(
        initialData: [],
        builder: (context, snapshot) {
          final List<Contact> contacts =
              List.from((snapshot.data as List).cast<Contact>());
          if (!snapshot.hasError) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return _ContactItem(contacts[index]);
                    },
                    itemCount: contacts.length);
            }
          }

          return Text("Erro");
        },
        future: _dao.findAll(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactForm();
          })).then((newContact) => {setState(() {})});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(contact.name, style: TextStyle(fontSize: 24)),
      subtitle: Text(contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16)),
    ));
  }
}
