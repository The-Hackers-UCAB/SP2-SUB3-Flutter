import '../models/covid_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  //Future<List<CovidModel>?> fetchCovidList() {
  //  return _provider.fetchCovidList();
  //}
  List<CovidModel>? fetchCovidList() {
    return _provider.fetchCovidList();
  }
}

class NetworkError extends Error {}
