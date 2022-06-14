
import 'dart:convert';

import '../DoctorModel.dart';

List<DoctorModel> doctorModelFromJson(String str) {
  return List<DoctorModel>.from(json.decode(str).map((x) {
    return DoctorModel.fromJson(x);
  }));
}