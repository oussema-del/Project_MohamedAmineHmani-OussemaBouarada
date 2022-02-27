import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";

  late String id;
  late String image;
  late String name;
  late int quantity;
  late double cost;
  late String productId;
  late double price;
  CartItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.quantity,
    required this.cost,
    required this.productId,
    required this.price,
  });

  factory CartItemModel.fromDocumentSnapshot(
      {required Map<String, dynamic> documentSnapshot}) {
    return CartItemModel(
      id: documentSnapshot[ID],
      image: documentSnapshot[IMAGE],
      name: documentSnapshot[NAME],
      quantity: documentSnapshot[QUANTITY],
      cost: double.parse(documentSnapshot[COST].toString()),
      productId: documentSnapshot[PRODUCT_ID],
      price: double.parse(documentSnapshot[PRICE].toString()),
    );
  }

  Map toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: price * quantity,
        PRICE: price
      };
}
