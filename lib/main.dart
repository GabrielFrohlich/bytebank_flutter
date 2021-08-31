import 'package:byteblank/databases/Database.dart';
import 'package:flutter/material.dart';
import 'models/Contact.dart';
import 'screens/Dashboard.dart';

void main() {
  runApp(ByteBlank());
  //save(Contact('João Gabriel', 2, id: 19));
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
                textTheme: ButtonTextTheme.primary)),
        home: Dashboard());
  }
}
