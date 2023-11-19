import 'dart:convert';

List<Wallet> walletFromJson(String str) =>
    List<Wallet>.from(json.decode(str).map((x) => Wallet.fromJson(x)));

String walletToJson(List<Wallet> payload) =>
    json.encode(List<dynamic>.from(payload.map((x) => x.toJson())));

class Wallet {
  Wallet({
    required this.walletId,
    required this.balance,
  });

  String walletId;
  double balance;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletId: json["walletId"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "balance": balance,
      };
}
