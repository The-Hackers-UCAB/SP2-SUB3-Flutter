import '../models/doctor_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<DoctorModel>?> fetchDoctorList() {
    return _provider.fetchDoctorList();
  }
}

class NetworkError extends Error {}
