import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart' hide Response;
import '../models/covid_model.dart';

//import 'package:response/response.dart' hide Response;
class ApiProvider {
  //Future<List<DoctorModel>?> fetchCovidList() async {
  //  var client = http.Client();

//    var uri = Uri.parse('https://api.covid19api.com/summary');
  //  var response = await client.get(uri);
  //  if (response.statusCode == 200) {
  //    var json1 = response.body;
  //    return covidModelFromJson(json1);
  //  }
  //}
  List<DoctorModel>? fetchCovidList() {
    List<DoctorModel>? json = [
      DoctorModel(
          apellido: 'Gomez',
          especialidad: null,
          foto:
              'firebasestorage.googleapis.com/v0/b/myonlinedoctor-b2ee5.appspot.com/o/doctor1.jpg?alt=media',
          id: 1,
          nombre: 'Carlo',
          sexo: null)
    ];
    return json;
  }
}
