import 'package:byteblank/models/Contact.dart';
import 'package:byteblank/screens/contacts_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset('images/bytebank_logo.png'),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ContactList();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: 150,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 24,
                            ),
                            Text("Contacts",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))
                          ],
                        ),
                      )),
                ))
          ],
        ));
  }
}
