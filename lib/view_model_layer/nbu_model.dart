import 'package:flutter/material.dart';
import 'package:nbu_currency_api_project/data_layer/models/nbu_data.dart';
import 'package:nbu_currency_api_project/data_layer/repositories/nbu_repository.dart';

class NbuModel extends ChangeNotifier {
  NbuModel({required this.nbuRepository}) {
    getAllData();
  }
  final NbuRepository nbuRepository;
  List<NbuData>? nbuData;
  bool isLoading = false;

  void getAllData() async {
    await Future.delayed(const Duration(seconds: 2));
    await nbuRepository
        .getCurrencyData()
        .then((value) => nbuData = value
            .where((value) =>
                value.nbuBuyPrice.isNotEmpty && value.nbuCellPrice.isNotEmpty)
            .toList())
        .onError((error, stackTrace) => throw error ?? "Ma'lumot topilmadi! ");

    nbuData!.sort((a, b) => a.title.compareTo(b.title));

    notifyListeners();
  }

  /// this function will run when refreshButton on homeScreen isClicked
  void fetchAllData() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    await nbuRepository
        .getCurrencyData()
        .then((value) => nbuData = value
            .where((value) =>
                value.nbuBuyPrice.isNotEmpty && value.nbuCellPrice.isNotEmpty)
            .toList())
        .onError((error, stackTrace) => throw error ?? "Ma'lumot topilmadi! ");

    nbuData!.sort((a, b) => a.title.compareTo(b.title));
    isLoading = false;
    notifyListeners();
  }
}
