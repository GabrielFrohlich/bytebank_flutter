class Contact {
  int? id;
  final String name;
  final int accountNumber;

  Contact(this.name, this.accountNumber, {this.id});

  Contact.fromJSON(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'],
        accountNumber = json['accountNumber'];

  @override
  toString() {
    return 'Contact{name: $name, accNumber: $accountNumber}';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> contactMap = Map();
    contactMap['id'] = this.id;
    contactMap['name'] = this.name;
    contactMap['accountNumber'] = this.accountNumber;

    return contactMap;
  }
}
