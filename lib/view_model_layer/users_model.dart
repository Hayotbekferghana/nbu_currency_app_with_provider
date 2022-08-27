import 'package:flutter/material.dart';
import 'package:nbu_currency_api_project/data_layer/models/user_data.dart';
import 'package:nbu_currency_api_project/data_layer/repositories/user_repository.dart';
import '../data_layer/db/cached_user_model/cached_user_model.dart';

class UsersModel extends ChangeNotifier {
  UsersModel({required this.userRepository});

  final UserRepository userRepository;
  UserData? userData;
  bool isLoading = false;
  List<CachedUser> cachedUsers = [];

  void getCachedUser() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    cachedUsers = await userRepository.getAllCachedUsers();
    isLoading = false;
    notifyListeners();
  }

  void getUserDataInit() async {
    userData = await userRepository.getUserData();
    if (!(cachedUsers.map((e) => e.userName).toList().contains(userData!.name))) {
      await userRepository.insertCachedUserFromApi(userData!);
    }
    // await userRepository.insertCachedUserFromApi(userData!);
    cachedUsers = await userRepository.getAllCachedUsers();
    notifyListeners();
  }

  void getUsersData() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    userData = await userRepository.getUserData();
    await userRepository.insertCachedUserFromApi(userData!);
    cachedUsers = await userRepository.getAllCachedUsers();
    isLoading = false;
    notifyListeners();
  }

  void deleteAllCachedUsers() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    await userRepository.deleteAllCachedUsers();
    userData = await userRepository.getUserData();
    await userRepository.insertCachedUserFromApi(userData!);
    cachedUsers = await userRepository.getAllCachedUsers();
    isLoading = false;
    notifyListeners();
  }

  void insertCachedUser(CachedUser cachedUser) async {
    isLoading = true;
    notifyListeners();
    userData = await userRepository.getUserData();
    await Future.delayed(const Duration(milliseconds: 500));
    await userRepository.insertCachedUser(cachedUser);
    cachedUsers = await userRepository.getAllCachedUsers();
    isLoading = false;
    notifyListeners();
  }
}
