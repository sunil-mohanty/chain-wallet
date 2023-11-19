import 'dart:developer';

import 'package:http/http.dart' as http;
import 'constants.dart';
import 'block.dart';
import 'wallet.dart';
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

  Future<List<Wallet>?> login(String userName, String password) async {
    try {
      //authenticate(userName, password); // method to be implemented
      return listWallets(userName);
    } catch (e, stacktrace) {
      log(e.toString());
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<List<Wallet>?> listWallets(String? userName) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.WALLETS);

      Map<String, dynamic> requestBody = {
        'userName': userName
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
        List<Wallet> _wallets = walletFromJson(response.body);
        return _wallets;
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
