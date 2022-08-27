import 'package:nbu_currency_api_project/data_layer/services/api_service.dart';

import '../models/nbu_data.dart';

class NbuRepository {
  NbuRepository({required this.apiService});
  ApiService apiService;
  Future<List<NbuData>> getCurrencyData() => apiService.getCurrencyData();
}
