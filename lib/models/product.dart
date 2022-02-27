import 'package:cloud_firestore/cloud_firestore.dart';


class ProductModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const BRAND = "brand";
  static const PRICE = "price";

  String id;
  late String image;
  late String name;
  late String brand;
  late double price;

  String get getId => id;

  set setId(String id) => this.id = id;

  get getImage => image;

  set setImage(image) => this.image = image;

  get getName => name;

  set setName(name) => this.name = name;

  get getBrand => brand;

  set setBrand(brand) => this.brand = brand;

  get getPrice => price;

  set setPrice(price) => this.price = price;
  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.brand,
      required this.price});

  factory ProductModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    return ProductModel(
      id: documentSnapshot.id,
      image: documentSnapshot[IMAGE],
      name: documentSnapshot[NAME],
      brand: documentSnapshot[BRAND],
      price: double.parse(documentSnapshot[PRICE].toString()),
    );
  }
}
