import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nbu_currency_api_project/utils/constants.dart';
import 'package:nbu_currency_api_project/utils/icons.dart';
import 'package:nbu_currency_api_project/view_model_layer/nbu_model.dart';
import 'package:nbu_currency_api_project/view_model_layer/users_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[600],
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Valyutalar"),
            Text(
              "Markaziy bank bo'yicha",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
        elevation: 0,
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
          return Stack(
            children: [
              const Positioned(
                  bottom: 10,
                  left: 100,
                  right: 100,
                  child: Text(
                    "by Hayotbek...",
                    textAlign: TextAlign.center,
                  )),
              Container(
                height: MediaQuery.sizeOf(context).height,
                padding: const EdgeInsets.all(5),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    nbuModel.nbuData!.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.teal[700],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              offset: const Offset(0, 10),
                              blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nbuModel.nbuData![index].code,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Text(
                                  nbuModel.nbuData![index].title,
                                  style: TextStyle(
                                      color: Colors.grey[300], fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Sotib olish: ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      "${nbuModel.nbuData![index].nbuBuyPrice} sum",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Sotish: ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      "${nbuModel.nbuData![index].nbuCellPrice} sum",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Provider.of<UserViewModel>(context, listen: false).getUserDataInit();

          Navigator.pushNamed(context, usersScreen);
        },
        child: const Icon(Icons.group),
      ),
    );
  }
}
