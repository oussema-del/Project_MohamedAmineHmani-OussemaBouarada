import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ihm/constants/controllers.dart';
import 'package:ihm/screens/adress.dart';

import 'package:ihm/widgets/global_widgets/custom_text.dart';
import 'package:ihm/screens/home/widgets/product_widget.dart';
import 'package:ihm/screens/home/widgets/shopping_cart.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const CustomText(
            text: "Products",
            size: 24,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                icon: Image.asset(
                  "assets/images/cartpay.png",
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.white,
                      child: const ShoppingCartWidget(),
                    ),
                  );
                })
          ],
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              Obx(() => UserAccountsDrawerHeader(
                  currentAccountPicture:
                      Image.asset("assets/images/logowhite.png"),
                  decoration: const BoxDecoration(color: Colors.black),
                  accountName: Text(userController.userModel.value.name ?? ""),
                  accountEmail:
                      Text(userController.userModel.value.email ?? ""))),
              ListTile(
                leading: const Icon(Icons.book),
                title: const CustomText(
                  text: "Payments History",
                ),
                onTap: () async {
                  paymentsController.getPaymentHistory();
                },
              ),
              ListTile(
                onTap: () {
                  userController.signOut();
                },
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Log Out"),
              ),
              ListTile(
                onTap: () {
                  Get.to(AdressMap());
                },
                leading: const Icon(Icons.location_city_sharp),
                title: const Text("Adress"),
              ),
            ],
          ),
        ),
        body: const ProductsWidget());
  }
}
