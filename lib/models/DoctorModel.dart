import 'dart:convert';
import 'dart:core';


class DoctorModel {
  DoctorModel({
    required this.especialidades,
    required this.id,
    required this.sexo,
    required this.nombre,
    required this.apellido,
    required this.foto,
  });

  List<String> especialidades;
  int id;
  String sexo;
  String nombre;
  String apellido;
  String foto;

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      especialidades: List<String>.from(json["especialidades"].map((x) => x)),
      id: json["id"],
      sexo: json["sexo"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      foto: json["foto"],
    );
  }  

}


