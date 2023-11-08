import 'dart:developer';

import 'package:http/http.dart' as http;
import 'constants.dart';
import 'block.dart';

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
}
