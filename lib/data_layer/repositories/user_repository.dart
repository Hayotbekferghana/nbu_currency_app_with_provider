import 'package:nbu_currency_api_project/data_layer/db/local_db.dart';

import '../db/cached_user_model/cached_user_model.dart';
import '../models/user_data.dart';
import '../services/api_service.dart';

class UserRepository {
  UserRepository({required this.apiService});
  ApiService apiService;
  Future<UserData> getUserData() => apiService.getUserData();

   Future<CachedUser> insertCachedUser(CachedUser cachedUser) => LocalDatabase.insertCachedUser(cachedUser);

   Future<CachedUser> insertCachedUserFromApi(UserData userData) =>LocalDatabase.insertCachedUserFromApi(userData);


   Future<List<CachedUser>> getAllCachedUsers() =>LocalDatabase.getAllCachedUsers();

   Future<int> deleteCachedUserById(int id) =>LocalDatabase.deleteCachedUserById(id);

   Future<int> updateCachedUser(CachedUser cachedUser) =>LocalDatabase.updateCachedUser(cachedUser);

   Future<int> deleteAllCachedUsers() =>LocalDatabase.deleteAllCachedUsers();

}