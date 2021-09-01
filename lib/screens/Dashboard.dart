import 'package:byteblank/components/menu_botao.dart';
import 'package:byteblank/models/Contact.dart';
import 'package:byteblank/screens/contacts_list.dart';
import 'package:byteblank/screens/transactions_list.dart';
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
          SingleChildScrollView(
            child: Row(
              children: [
                BotaoMenu(
                  "Contacts",
                  Icons.people,
                  onClick: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return ContactList();
                    }));
                  },
                ),
                BotaoMenu(
                  "Transaction Feed",
                  Icons.file_present,
                  onClick: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return TransactionsList();
                    }));
                  },
                ),
              ],
            ),
            scrollDirection: Axis.horizontal,
          )
        ],
      ),
    );
  }
}
