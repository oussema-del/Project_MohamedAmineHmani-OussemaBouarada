import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ihm/models/cart.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";

  late String? id;
  late String? name;
  late String? email;
  late List<CartItemModel>? cart;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.cart,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    id = snapshot.id;
    cart = _convertCartItems(snapshot[CART] ?? []);
  }

  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> _result = [];
    if (cartFomDb.length > 0) {
      for (var element in cartFomDb) {
        _result
            .add(CartItemModel.fromDocumentSnapshot(documentSnapshot: element));
      }
    }
    return _result;
  }

  List cartItemsToJson() => cart!.map((item) => item.toJson()).toList();
}
