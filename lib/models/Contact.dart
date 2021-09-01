class Contact {
  int? id;
  final String name;
  final int accountNumber;

  Contact(this.name, this.accountNumber, {this.id});

  @override
  toString() {
    return 'Contact{name: $name, accNumber: $accountNumber}';
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> contactMap = Map();
    contactMap['id'] = this.id;
    contactMap['name'] = this.name;
    contactMap['account_number'] = this.accountNumber;
    contactMap['accountNumber'] = this.accountNumber;

    return contactMap;
  }
}
