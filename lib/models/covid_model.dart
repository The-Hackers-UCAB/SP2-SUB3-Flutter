import 'dart:convert';

List<CovidModel> covidModelFromJson(String str) =>
    List<CovidModel>.from(json.decode(str).map((x) => CovidModel.fromJson(x)));

String covidModelToJson(List<CovidModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CovidModel {
  CovidModel({
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

  factory CovidModel.fromJson(Map<String, dynamic> json) => CovidModel(
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
