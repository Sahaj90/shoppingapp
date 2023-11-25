import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingapp/Services/firestore_services.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/profile/orders_details.dart';

import '../category/loading_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Not Ordered yet!".text.color(darkFontGrey).makeCentered();
          } else {

            var data = snapshot.data!.docs;
            
            return ListView.builder(
                itemCount: data.length,
              itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                    title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(semibold).make(),
                    trailing: IconButton(
                      onPressed: (){

                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: darkFontGrey,
                      ),
                    ),
                  );
              },
            );
          }
        }
      ),
    );
  }
}
