import 'dart:async';

import 'package:byteblank/components/progress.dart';
import 'package:byteblank/components/response_dialog.dart';
import 'package:byteblank/components/transaction_auth_dialog.dart';
import 'package:byteblank/models/Contact.dart';
import 'package:byteblank/models/Transaction.dart';
import 'package:byteblank/services/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _progressVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(),
                ),
                visible: _progressVisible,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text)!;
                      final transactionCreated =
                          Transaction(value, widget.contact, transactionId);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                Future.delayed(Duration(seconds: 1));
                                _save(transactionCreated, password, context,
                                    transactionId);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context, transactionId) async {
    Transaction? transaction =
        await _send(transactionCreated, password, context, transactionId);

    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('successful transaction');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction?> _send(Transaction transactionCreated, String password,
      BuildContext context, String transactionId) async {
    setState(() {
      _progressVisible = true;
    });
    final Transaction? transaction = await _webClient
        .save(transactionCreated, password)
        .catchError((onError) {
      _showFailureMessage(context, message: onError.message);
    }, test: (onError) => onError is TimeoutException).catchError((onError) {
      _showFailureMessage(context, message: onError.message);
    }, test: (onError) => onError is HttpException).catchError((onError) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _progressVisible = false;
      });
    });

    return transaction;
  }

  void _showFailureMessage(BuildContext context,
      {String message = "Unknown error!"}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
