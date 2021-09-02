import 'package:byteblank/screens/Dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBlank());
}

class ByteBlank extends StatelessWidget {
  const ByteBlank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary),
      ),
      home: Dashboard(),
    );
  }
}
