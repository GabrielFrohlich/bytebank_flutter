import 'Contact.dart';

class Transaction {
  final double value;
  final Contact contact;
  final String id;

  Transaction(this.value, this.contact, this.id);

  Transaction.fromJSON(Map<String, dynamic> json)
      : value = json['value'],
        contact = json['contact'],
        id = json['id'];

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact, id: $id}';
  }

  Map<String, dynamic> toMap() {
    return {"value": this.value, "contact": contact.toMap(), "id": this.id};
  }
}
