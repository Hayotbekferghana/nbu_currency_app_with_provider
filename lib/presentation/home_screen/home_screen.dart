import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nbu_currency_api_project/presentation/users_screen/users_screen.dart';
import 'package:nbu_currency_api_project/view_model_layer/nbu_model.dart';
import 'package:provider/provider.dart';

import '../../utils/icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("NBU Currency App"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              context.read<NbuModel>().fetchAllData();
            },
            icon: const Icon(
              Icons.restart_alt_sharp,
            ),
          ),
        ],
      ),
      body: Consumer<NbuModel>(
          builder: (BuildContext context, nbuModel, Widget? child) {
        context.read<NbuModel>().getAllData();
        if (nbuModel.nbuData == null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Center(
              child: Lottie.asset(loading),
            ),
          );
        } else if (nbuModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: List.generate(
              nbuModel.nbuData!.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        offset: const Offset(2, 2),
                        blurRadius: 5)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nbuModel.nbuData![index].code,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          nbuModel.nbuData![index].title,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    Text(
                      nbuModel.nbuData![index].cbPrice,
                      style: const TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const UsersScreen(),
            ),
          );
        },
        child: const Icon(Icons.group),
      ),
    );
  }
}
