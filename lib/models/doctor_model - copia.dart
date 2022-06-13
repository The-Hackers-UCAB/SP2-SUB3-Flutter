import 'dart:convert';

import 'dart:core';

List<DoctorModel> doctorModelFromJson(String str) => List<DoctorModel>.from(
    json.decode(str).map((x) => DoctorModel.fromJson(x)));

String doctorModelToJson(List<DoctorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorModel {
  DoctorModel({
    required this.id,
    required this.sexo,
    required this.nombre,
    required this.apellido,
    required this.especialidades,
    required this.foto,
  });

  int id;
  String sexo;
  String nombre;
  String apellido;
  List<Especialidad> especialidades;
  String foto;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        sexo: json["sexo"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        especialidades: List<Especialidad>.from(
            json["Especiliadad"].map((x) => Especialidad.fromJson(x))),
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sexo": sexo,
        "nombre": nombre,
        "apellido": apellido,
        "especialidades":
            List<dynamic>.from(especialidades.map((x) => x.toJson())),
        "foto": foto,
      };
}

class Especialidad {
  Especialidad({
    required this.nombre,
  });
  String nombre;
  factory Especialidad.fromJson(Map<String, dynamic> json) => Especialidad(
        nombre: json["nombre"],
      );
  Map<String, dynamic> toJson() => {
        "nombre": nombre,
      };
}
