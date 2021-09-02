import 'Contact.dart';

class Transaction {
  final double value;
  final Contact contact;

  Transaction(
    this.value,
    this.contact,
  );

  Transaction.fromJSON(Map<String, dynamic> json)
      : value = json['value'],
        contact = json['contact'];

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

  Map<String, dynamic> toMap() {
    return {"value": this.value, "contact": contact.toMap()};
  }
}
