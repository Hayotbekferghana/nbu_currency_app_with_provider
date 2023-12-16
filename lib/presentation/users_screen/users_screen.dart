import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nbu_currency_api_project/data_layer/db/cached_user_model/cached_user_model.dart';
import 'package:nbu_currency_api_project/view_model_layer/users_model.dart';
import 'package:provider/provider.dart';
import '../../utils/icons.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController countController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Users"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.black.withAlpha(90),
                        child: SizedBox(
                          width: 200,
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 170,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 190,
                                      height: 50,
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          labelText: "Enter name",
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 190,
                                      height: 50,
                                      child: TextField(
                                        controller: ageController,
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          labelText: "Enter age",
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 190,
                                      height: 50,
                                      child: TextField(
                                        controller: countController,
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                          ),
                                          labelText: "Enter count",
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (nameController.text.isNotEmpty &&
                                      ageController.text.isNotEmpty &&
                                      countController.text.isNotEmpty) {
                                    Navigator.of(context).pop();
                                    context
                                        .read<UserViewModel>()
                                        .insertCachedUser(
                                          CachedUser(
                                            age: int.parse(ageController.text),
                                            userName: nameController.text,
                                            count:
                                                int.parse(countController.text),
                                          ),
                                        );
                                    nameController.clear();
                                    ageController.clear();
                                    countController.clear();
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            alignment: Alignment.topCenter,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            backgroundColor:
                                                Colors.black.withOpacity(0.7),
                                            title: const Center(
                                              child: Text(
                                                "Ma'lumotlarni kiriting!",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                },
                                child: const Text("Save"),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.person_add)),
          IconButton(
              onPressed: () {
                context.read<UserViewModel>().deleteAllCachedUsers();
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: Consumer<UserViewModel>(
          builder: (BuildContext context, userModel, Widget? child) {
        if (userModel.userData == null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Center(
              child: Lottie.asset(loading),
            ),
          );
        } else if (userModel.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        } else {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: List.generate(
              userModel.cachedUsers.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(2, 3), blurRadius: 5)
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
                          userModel.cachedUsers[index].userName,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Age:  ${userModel.cachedUsers[index].age.toString()}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    Text(
                      "Count:  ${userModel.cachedUsers[index].count.toString()}",
                      style: const TextStyle(color: Colors.green),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
