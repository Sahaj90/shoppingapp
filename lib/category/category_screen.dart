import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/controller/product_controller.dart';
import 'package:shopingapp/widgets/bg_wid.dart';

import '../consts/lists.dart';
import 'categoty_details.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).white.make() ,
        ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,mainAxisExtent: 200,crossAxisSpacing: 8), itemBuilder: (context,index){
          return Column(
            children: [
              Image.asset(categoriesImages[index],
              height: 140,
                width: 200,
                fit: BoxFit.cover,
              ),
              10.heightBox,
              categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
            ],
          ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
            controller.getSubCategories(categoriesList[index]);
            Get.to(()=> CategoryDetails(title: categoriesList[index]));});
        }),
      ),
      ),
    );
  }
}
