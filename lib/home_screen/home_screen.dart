import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingapp/Services/firestore_services.dart';
import 'package:shopingapp/category/loading_indicator.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:get/get.dart';
import 'package:shopingapp/home_screen/components/featured_button.dart';
import 'package:shopingapp/home_screen/search_screen.dart';
import 'package:shopingapp/widgets/home_button.dart';

import '../category/item_details.dart';
import '../consts/lists.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration:  InputDecoration(
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap(() {
                 if(controller.searchController.text.isNotEmptyAndNotNull){
                   Get.to(()=> SearchScreen(title: controller.searchController.text,));
                 }

                }),
                fillColor: whiteColor,
                filled: true,
                hintText: searchanything,
                hintStyle:const TextStyle(color: textfieldGrey),
              ),
            ).box.outerShadowSm.make(),
          ),
          10.heightBox,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true, // highlight
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todayDeal : flashsale,
                            )),
                  ),

                  10.heightBox,
                  //second swiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true, // highlight
                      itemCount: secondslidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondslidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topcate
                                    : index == 1
                                        ? brand
                                        : topSellers,
                              ))),

                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featurecate.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButton(
                                      icon: featuredImg1[index],
                                      title: featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      icon: featuredImg2[index],
                                      title: featuredTitles2[index]),
                                ],
                              )).toList(),
                    ),
                  ),
                  20.heightBox,

                  //featured Product

                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: redColor,
                      // borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text.white
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FireStoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Image.asset(
                                                //   imgP1,
                                                //   width: 150,
                                                //   fit: BoxFit.cover,
                                                // ),
                                          Image.network(
                                            featuredData[index]['p_img'][0],
                                            width: 130,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                                10.heightBox,
                                                "${featuredData[index]['p_name']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                // "₹600"
                                      "₹${featuredData[index]['p_price']}"
                                                    .text
                                                    .color(Colors.red)
                                                    .fontFamily(bold)
                                                    .size(16)
                                                    .make(),
                                              ],
                                            )
                                                .box
                                                .white
                                                .roundedSM
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make().onTap(() {
                                          Get.to(() => ItemDetails(
                                            title:
                                            "${featuredData[index]['p_name']}",
                                            data: featuredData[index],
                                          ));
                                        })),
                                  );
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  10.heightBox,
                  // 3rd Swiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true, // highlight
                      itemCount: secondslidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondslidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  //all product section
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: allProducts.text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .size(18)
                        .make(),
                  ),
                  20.heightBox,
                  StreamBuilder(
                      stream: FireStoreServices.allProducts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Image.asset(
                                    //   imgP5,
                                    //   width: 200,
                                    //   height: 200,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    Image.network(
                                      allproductsdata[index]['p_img'][0],
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "₹${allproductsdata[index]['p_price']}"
                                        .text
                                        .color(Colors.red)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                    10.heightBox,
                                  ],
                                )
                                    .box
                                    .white
                                    .rounded
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(8))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              });
                        }
                      })
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
