import 'dart:convert';

import 'package:byteblank/models/Contact.dart';
import 'package:byteblank/models/Transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(Uri.parse('$base_url/transactions'));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return _toTransactions(decodedJson);
  }

  List<Transaction> _toTransactions(List<dynamic> decodedJson) {
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> element in decodedJson) {
      transactions.add(
        Transaction(
            element['value'],
            Contact(
                element['contact']['name'], element['contact']['accountNumber'],
                id: 0),
            element['id']),
      );
    }

    return transactions;
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final Response response = await client.post(
      Uri.parse('$base_url/transactions'),
      headers: {
        'Content-Type': 'application/json',
        'password': password,
      },
      body: jsonEncode(
        transaction.toMap(),
      ),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return Transaction(
          json['value'],
          Contact(json['contact']['name'], json['contact']['accountNumber'],
              id: 0),
          json['id']);
    }

    throw HttpException(response.statusCode);
  }
}

class HttpException implements Exception {
  String? message;

  HttpException(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      this.message = _statusCodeResponses[statusCode]!;
    } else {
      this.message = "Unknown Error";
    }
  }

  static final Map<int, String> _statusCodeResponses = {
    400: "there was an error submitting transaction",
    401: "Auth error",
    409: "transaction exists"
  };
}
