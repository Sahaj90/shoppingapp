import 'package:flutter/material.dart';
import 'package:shopingapp/cart/cart_screen.dart';
import 'package:shopingapp/category/category_screen.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:get/get.dart';
import 'package:shopingapp/home_screen/home_screen.dart';
import 'package:shopingapp/profile/profile_screen.dart';
import 'package:shopingapp/widgets/exit_dialog.dart';

import '../controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async{
        showDialog(
            barrierDismissible: false,
            context: context, builder: (context)=> exitDialog(context));
        return false;
      },
      child: Scaffold(

        body: Column(
          children: [
            Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value))),
          ],
        ),
        bottomNavigationBar: Obx(()=>
            BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: Colors.red,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: navbarItem,
              onTap: (value){
                controller.currentNavIndex.value = value;
              },
            ),
        ),
      ),
    );
  }
}
