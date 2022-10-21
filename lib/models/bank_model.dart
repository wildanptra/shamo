class BankModel {
  late String bank;
  late String vaNumber;

  BankModel({
    required this.bank,
    required this.vaNumber,
  });

  BankModel.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    vaNumber = json['va_number'];
  }

  Map<String, dynamic> toJson() {
    return {
      'bank': bank,
      'va_number': vaNumber,
    };
  }
}
