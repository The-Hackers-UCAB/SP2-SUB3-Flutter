import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/doctor_model.dart';

class ApiProvider {
  Future<List<DoctorModel>?> fetchDoctorList() async {
    var client = http.Client();

    var uri =
        Uri.parse('https://myonlinedoctor.herokuapp.com/doctor/especialidad');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json1 = response.body;
      return doctorModelFromJson(json1);
    }
  }
}
