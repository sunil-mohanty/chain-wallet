import 'dart:convert';

List<Coin> coinFromJson(String str) =>
    List<Coin>.from(json.decode(str).map((x) => Coin.fromJson(x)));

String coinToJson(List<Coin> payload) =>
    json.encode(List<dynamic>.from(payload.map((x) => x.toJson())));

class Coin {
  Coin({
    required this.id,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
  });

  String id;
  String name;
  String image;
  num currentPrice;
  num priceChange24h;
  num priceChangePercentage24h;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        currentPrice: json['current_price'],
        priceChange24h: json['price_change_24h'],
        priceChangePercentage24h: json['price_change_percentage_24h'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "currentPrice": currentPrice,
        "priceChange24h": priceChange24h,
        "priceChangePercentage24h": priceChangePercentage24h,
      };
}
