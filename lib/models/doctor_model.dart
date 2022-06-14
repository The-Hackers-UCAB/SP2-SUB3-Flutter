import 'dart:convert';
import 'dart:core';

List<DoctorModel> doctorModelFromJson(String str) => List<DoctorModel>.from(
    json.decode(str).map((x) => DoctorModel.fromJson(x)));

String doctorModelToJson(List<DoctorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        especialidades: List<String>.from(json["especialidades"].map((x) => x)),
        id: json["id"],
        sexo: json["sexo"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "especialidades": List<dynamic>.from(especialidades.map((x) => x)),
        "id": id,
        "sexo": sexo,
        "nombre": nombre,
        "apellido": apellido,
        "foto": foto,
      };
}
