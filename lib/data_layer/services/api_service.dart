import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as h;

import '../models/nbu_data.dart';
import '../models/user_data.dart';

class ApiService{

   Future<List<NbuData>> getCurrencyData()async {
    try{
      Response response =await  h.get(Uri.parse("https://nbu.uz/uz/exchange-rates/json/"));
      if (response.statusCode == 200) {
        List<NbuData> data = (jsonDecode(response.body) as List)
            .map((e) => NbuData.fromJson(e))
            .toList();
        return data;
      } else {
        throw Exception();
      }
    } catch(e){
      print(e);
      throw Exception(e);
    }
  }

   Future<UserData> getUserData() async {
     try {
       Response response =
       await h.get(Uri.parse("https://api.agify.io/?name=bella"));
       if (response.statusCode == 200) {
         UserData userData = UserData.fromJson(jsonDecode(response.body));
         debugPrint(userData.name);
         return userData;
       } else {
         throw Exception();
       }
     } catch (e) {
       print(e.toString());
       throw Exception(e);
     }
   }
}