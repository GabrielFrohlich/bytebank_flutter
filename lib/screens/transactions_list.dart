import 'package:byteblank/components/centered_message.dart';
import 'package:byteblank/components/progress.dart';
import 'package:byteblank/models/Contact.dart';
import 'package:byteblank/models/Transaction.dart';
import 'package:byteblank/services/webclient.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: FutureBuilder<List<Transaction>>(
          future: findAll(),
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              switch (snapshot.connectionState) {
                // case ConnectionState.none:
                //   // TODO: Handle this case.
                //   break;
                case ConnectionState.waiting:
                  return Progress();
                // case ConnectionState.active:
                //   // TODO: Handle this case.
                //   break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    final List<Transaction> transactions = snapshot.data!;
                    if (!transactions.isNotEmpty) {
                      return CenteredMessage("No transactions found",
                          icon: Icons.warning);
                    }

                    return ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final Transaction transaction = transactions[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.monetization_on),
                              title: Text(
                                transaction.value.toString(),
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                transaction.contact.accountNumber.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return CenteredMessage("Unknown Error");
                default:
                  return CenteredMessage("Unknown Error");
              }
            } else {
              return CenteredMessage("Unknown Error");
            }
          },
        ));
  }
}
