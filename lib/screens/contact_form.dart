import 'package:byteblank/databases/dao/contact_dao.dart';
import 'package:byteblank/models/Contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Contact")),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Full Name"),
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.name,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: TextField(
                      controller: _accountController,
                      decoration: InputDecoration(labelText: "Account Number"),
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () {
                            final String name = _nameController.text;
                            final int? accountNumber =
                                int.tryParse(_accountController.text);

                            if (accountNumber != null) {
                              final Contact newContact =
                                  Contact(name, accountNumber);
                              debugPrint(newContact.toString());
                              _dao
                                  .save(newContact)!
                                  .then((id) => Navigator.pop(context));
                            }
                          },
                          child: Text("Create")),
                    ))
              ],
            )));
    ;
  }
}
