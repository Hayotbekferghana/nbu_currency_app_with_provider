import 'package:flutter/material.dart';
import 'package:nbu_currency_api_project/data_layer/repositories/nbu_repository.dart';
import 'package:nbu_currency_api_project/data_layer/repositories/user_repository.dart';
import 'package:nbu_currency_api_project/data_layer/services/api_service.dart';
import 'package:nbu_currency_api_project/presentation/router/router.dart';
import 'package:nbu_currency_api_project/utils/constants.dart';
import 'package:nbu_currency_api_project/view_model_layer/nbu_model.dart';
import 'package:nbu_currency_api_project/view_model_layer/users_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (BuildContext context) =>
              NbuModel(nbuRepository: NbuRepository(apiService: ApiService()))),
      ChangeNotifierProvider(
        create: (BuildContext ctx) => UserViewModel(
          userRepository: UserRepository(
            apiService: ApiService(),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.onGenerate,
    );
  }
}
