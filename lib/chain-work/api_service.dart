import 'dart:developer';

import 'package:http/http.dart' as http;
import 'constants.dart';
import 'block.dart';
import 'dart:convert';

class ApiService {
  Future<List<Block>?> getBlocks() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.blocks);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        List<Block> _blocks = blockFromJson(response.body);
        return _blocks;
      }
    } catch (e, stacktrace) {
      log(e.toString());
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<List<Block>?> login() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
      var response = await http.post(url);
      if (response.statusCode == 200) {
        print(response.body);
        List<Block> _blocks = blockFromJson(response.body);
        return _blocks;
      }
    } catch (e, stacktrace) {
      log(e.toString());
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<List<Block>?> listWallet() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.login);
      var response = await http.post(url);
      if (response.statusCode == 200) {
        print(response.body);
        List<Block> _blocks = blockFromJson(response.body);
        return _blocks;
      }
    } catch (e, stacktrace) {
      log(e.toString());
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<List<Block>?> walletDeatils(String walletId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.WALLET_DETAILS);

      // Create a Map to represent your request body
      Map<String, dynamic> requestBody = {
        'walletId': walletId
        // Add other key-value pairs as needed
      };

      var response = await http.post(
        url,
        body: jsonEncode(requestBody), // Convert the Map to a JSON string
        headers: {
          'Content-Type': 'application/json'
        }, // Specify the content type
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<Block> _blocks = blockFromJson(response.body);
        return _blocks;
      }
    } catch (e, stacktrace) {
      log(e.toString());
      print(e.toString());
      print(stacktrace);
    }
  }
}
