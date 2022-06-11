import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart' hide Response;
import '../models/covid_model.dart';

//import 'package:response/response.dart' hide Response;
class ApiProvider {
  Future<CovidModel?> fetchCovidList() async {
    var client = http.Client();

    var uri = Uri.parse('https://api.covid19api.com/summary');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json1 = response.body;
      return covidModelFromJson(json1);
    }
  }
}
