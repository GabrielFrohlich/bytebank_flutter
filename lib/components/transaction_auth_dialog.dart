import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;
  TransactionAuthDialog({required this.onConfirm});
  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("authenticate"),
      content: TextField(
        obscureText: true,
        controller: _passwordController,
        keyboardType: TextInputType.number,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            print("Teste2");
            Navigator.pop(context);
          },
          child: Text("Confirm"),
        ),
        TextButton(
          child: Text("Cancelar"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
