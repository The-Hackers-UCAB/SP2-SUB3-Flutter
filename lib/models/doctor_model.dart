import 'dart:convert';

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
    required this.especialidad,
    required this.foto,
  });

  int id;
  Sexo? sexo;
  String nombre;
  String apellido;
  Especialidad? especialidad;
  String foto;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json["id"],
        sexo: sexoValues.map[json["sexo"]],
        nombre: json["nombre"],
        apellido: json["apellido"],
        especialidad: especialidadValues.map[json["especialidad"]],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sexo": sexoValues.reverse?[sexo],
        "nombre": nombre,
        "apellido": apellido,
        "especialidad": especialidadValues.reverse?[especialidad],
        "foto": foto,
      };
}

enum Especialidad { CARDIOLOGIA, RADIOLOGIA, ODONTOLOGIA, OTORINOLOGIA }

final especialidadValues = EnumValues({
  "Cardiologia": Especialidad.CARDIOLOGIA,
  "Odontologia": Especialidad.ODONTOLOGIA,
  "Otorinologia": Especialidad.OTORINOLOGIA,
  "Radiologia": Especialidad.RADIOLOGIA
});

enum Sexo { M, F }

final sexoValues = EnumValues({"F": Sexo.F, "M": Sexo.M});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
