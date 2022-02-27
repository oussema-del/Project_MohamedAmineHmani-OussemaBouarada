// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ihm/constants/fire_base_constants.dart';
import 'package:ihm/models/product.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  final RxList<ProductModel> products = RxList<ProductModel>([]);
  List<ProductModel> get product => products.value;
  String collection = "products";

  @override
  void onReady() {
    super.onReady();

    products.bindStream(productsStream());
  }

  static Stream<List<ProductModel>> productsStream() {
    return firebaseFirestore
        .collection("products")
        .snapshots()
        .map((QuerySnapshot query) {
      List<ProductModel> products = [];
      for (var todo in query.docs) {
        final productModel =
            ProductModel.fromDocumentSnapshot(documentSnapshot: todo);
        products.add(productModel);
      }
      return products;
    });
  }
}
