import 'dart:convert';

List<Block> blockFromJson(String str) =>
    List<Block>.from(json.decode(str).map((x) => Block.fromJson(x)));

String blockToJson(List<Block> payload) =>
    json.encode(List<dynamic>.from(payload.map((x) => x.toJson())));

class Block {
  Block({
    required this.timestamp,
    required this.lastHash,
    required this.hash,
    required this.data,
    required this.noance,
    required this.difficulty,
  });

  String timestamp;
  String lastHash;
  String hash;
  String data;
  int noance;
  int difficulty;

  factory Block.fromJson(Map<String, dynamic> json) => Block(
        timestamp: json["timestamp"],
        lastHash: json["lastHash"],
        hash: json["hash"],
        data: json["data"],
        noance: json["noance"],
        difficulty: json["difficulty"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "lastHash": lastHash,
        "hash": hash,
        "data": data,
        "noance": noance,
        "difficulty": difficulty,
      };
}
