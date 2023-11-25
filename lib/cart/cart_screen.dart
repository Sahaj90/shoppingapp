import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingapp/Services/firestore_services.dart';
import 'package:shopingapp/cart/shipping_screen.dart';
import 'package:shopingapp/category/loading_indicator.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/controller/cart_controller.dart';
import 'package:shopingapp/widgets/new_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
            color: redColor,
            onpress: (){
              Get.to(()=> const ShippingDetails());
            },
            textColor: whiteColor,
            title: "Proceed to shipping",
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network('${data[index]['img']}'),
                                  // leading: Image.asset('${data[index]['img']}',
                                  //   width: 90,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  title: "${data[index]['title']} (x${data[index]['qty']})"
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                                  subtitle: "₹${data[index]['tprice']}"

                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FireStoreServices.deletdeDoc(data[index].id);
                                  }),
                                );
                              })),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(()=> "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .width(context.screenWidth - 40)
                          .color(lightGrey)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //   width: context.screenWidth - 40,
                      //   child: ourButton(
                      //     color: redColor,
                      //     onpress: () {},
                      //     textColor: whiteColor,
                      //     title: "Proceed to shipping",
                      //   ),
                      // )
                    ],
                  ),
                );
              }
            }));
  }
}
