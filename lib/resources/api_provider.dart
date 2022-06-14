import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myonlinedoctor/models/FilterModel.dart';

import '../models/doctor_model.dart';

class ApiProvider {

  Future<List<DoctorModel>?> fetchDoctorList(FilterModel filtro) async {

    var client = http.Client();
    var url = 'https://myonlinedoctor.herokuapp.com/doctor/';
    
    if (filtro.valor != ''){
      url  = url  + filtro.campo +"/" + filtro.valor;
    }
   
    var uri = Uri.parse(url);
    
    var response = await client.get(uri);
   
    if (response.statusCode == 200) {
      var json1;
      json1 = response.body;
      // json1 = FakeData().doctorList();
      print(json1);
      return doctorModelFromJson(json1);
    }
    
    return null;
  }
}

class FakeData {
  doctorList() {
    var data = [
      {
        "especialidades": [
          "Clinica Medica"
        ],
        "id": 1,
        "sexo": "M",
        "nombre": "James",
        "apellido": "Iturbide",
        "foto": "firebasestorage.googleapis.com/v0/b/myonlinedoctor-b2ee5.appspot.com/o/doctor1.jpg?alt=media"
      },
      {
        "especialidades": [
          "Medicina General Y De Familia"
        ],
        "id": 2,
        "sexo": "M",
        "nombre": "Sage",
        "apellido": "Wieser",
        "foto": "firebasestorage.googleapis.com/v0/b/myonlinedoctor-b2ee5.appspot.com/o/doctor2.jpg?alt=media"
      }
    ];
    return data;
  }
}