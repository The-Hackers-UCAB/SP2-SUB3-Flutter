import 'package:myonlinedoctor/models/FilterModel.dart';

import '../models/DoctorModel.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<DoctorModel>?> fetchDoctorList(FilterModel filtro) {
    return _provider.fetchDoctorList(filtro);
  }
}

class NetworkError extends Error {}
