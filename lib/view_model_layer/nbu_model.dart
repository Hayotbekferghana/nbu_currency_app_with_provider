import 'package:flutter/material.dart';
import 'package:nbu_currency_api_project/data_layer/models/nbu_data.dart';
import 'package:nbu_currency_api_project/data_layer/repositories/nbu_repository.dart';

class NbuModel extends ChangeNotifier {
   NbuModel({required this.nbuRepository});
  final NbuRepository nbuRepository;
  List<NbuData>? nbuData;
  bool isLoading = false;

  void getAllData() async {
    await Future.delayed(const Duration(seconds: 2));
    nbuData = await nbuRepository.getCurrencyData();
    notifyListeners();
  }

  /// this function will run when refreshButton on homeScreen isClicked
  void fetchAllData()async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    nbuData = await nbuRepository.getCurrencyData();
    isLoading = false;
    notifyListeners();
  }
}
