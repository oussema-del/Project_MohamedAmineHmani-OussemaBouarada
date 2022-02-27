import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ihm/constants/controllers.dart';


import 'package:ihm/widgets/global_widgets/custom_text.dart';
import 'package:ihm/widgets/global_widgets/custom_button2.dart';

import 'cart_widget.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userController.userModel.value.cart!.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    userController.userModel.value.cart!
                        .map((cartItem) => CartItemWidget(
                              cartItem: cartItem,
                            ))
                        .toList()[index],
                  ]);
                })),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                child: Obx(
                  () => AuthButton(
                      text:
                          "Pay (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})",
                      onTap: () async {
                        await paymentsController.createPaymentMethod();
                      }),
                )))
      ],
    );
  }
}
