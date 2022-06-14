import 'package:myonlinedoctor/models/FilterModel.dart';

import '../models/DoctorModel.dart';
import 'ApiProvider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<DoctorModel>?> fetchDoctorList(FilterModel filtro) {
    return _provider.fetchDoctorList(filtro);
  }
}


