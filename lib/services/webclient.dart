import 'dart:convert';

import 'package:byteblank/models/Contact.dart';
import 'package:byteblank/models/Transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String base_url = 'http://192.168.0.99:8081';

Future<List<Transaction>> findAll() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get(Uri.parse('$base_url/transactions'));

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> element in decodedJson) {
    transactions.add(Transaction(
        element['value'],
        Contact(element['contact']['name'], element['contact']['accountNumber'],
            id: 0)));
  }
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.toString());
    return data;
  }
}

Future<Transaction> save(Transaction transaction) async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.post(
    Uri.parse('$base_url/transactions'),
    headers: {
      'Content-Type': 'application/json',
      'password': '2000',
    },
    body: jsonEncode(
      transaction.toMap(),
    ),
  );
  Map<String, dynamic> json = jsonDecode(response.body);

  return Transaction(
      json['value'],
      Contact(json['contact']['name'], json['contact']['accountNumber'],
          id: 0));
}
