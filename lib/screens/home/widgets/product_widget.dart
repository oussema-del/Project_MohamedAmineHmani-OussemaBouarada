import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_list_tile/simple_list_tile.dart';

import 'package:ihm/constants/controllers.dart';
import 'package:ihm/controllers/product_controller.dart';

import '../../../widgets/global_widgets/custom_text.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProducsController>(
        init: Get.put<ProducsController>(producsController),
        builder: (ProducsController todoController) {
          return ListView.builder(
            shrinkWrap: false,
            itemCount: producsController.product.length,
            itemBuilder: (BuildContext context, int index) {
              //print(producsController.product[index].name);

              return Column(
                children: [
                  SimpleListTile(
                    onTap: () {
                      print('test');
                    },
                    title: CustomText(
                      text: producsController.product[index].name +
                          "\n" +
                          producsController.product[index].brand,
                    ),
                    subtitle: CustomText(
                      text: producsController.product[index].price.toString() +
                          " \$",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          cartController.addProductToCart(
                              producsController.product[index]);
                        }),
                    leading: Image.network(
                      producsController.product[index].image,
                      width: 140,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    tileColor: Colors.grey[300]!,
                    circleColor: Colors.grey[100]!,
                    circleDiameter: 200,
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              ); /*Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(12, 7, 0, 0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        producsController.product[index].image,
                        width: 140,
                      ),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              CustomText(
                                text: producsController.product[index].name,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              CustomText(
                                text: producsController.product[index].brand,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: producsController.product[index].price
                                    .toString(),
                                size: 20,
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                              IconButton(
                                  icon: const Icon(Icons.add_shopping_cart),
                                  onPressed: () {
                                    cartController.addProductToCart(
                                        producsController.product[index]);
                                  })
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );*/
            },
          );
        });
  }
}
