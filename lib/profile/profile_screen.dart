import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingapp/Services/firestore_services.dart';
import 'package:shopingapp/auth_screen/login_screen.dart';
import 'package:shopingapp/category/loading_indicator.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/consts/lists.dart';
import 'package:shopingapp/controller/auth_controller.dart';
import 'package:shopingapp/controller/profile_controller.dart';
import 'package:shopingapp/profile/edit_profile.dart';
import 'package:shopingapp/profile/my_order.dart';
import 'package:shopingapp/profile/wishlist_screen.dart';
import 'package:shopingapp/views/chat/messeging_screen.dart';
import 'package:shopingapp/widgets/bg_wid.dart';
import 'package:get/get.dart';
import 'Components/detail_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot ) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
            child: Column(
              children: [
                //edit profile button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit, color: whiteColor))
                      .onTap(() {
                    controller.nameController.text = data['name'];

                    Get.to(() => EditProfileScreen(data: data));
                  }),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(
                              PF1,
                              width: 70,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              width: 70,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          "${data['email']}".text.white.make(),
                        ],
                      )),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                          color: whiteColor,
                        )),
                        onPressed: () async {
                          await Get.put(AuthController())
                              .signOutMethod(context);
                          Get.offAll(() => const LoginScreen());
                        },
                        child: "logout".text.fontFamily(semibold).white.make(),
                      )
                    ],
                  ),
                ),

                20.heightBox,
                FutureBuilder(
                    future: FireStoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else {
                        var countData = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "your cart",
                                width: context.screenWidth / 3.5),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "your whishlist",
                                width: context.screenWidth / 3.5),
                            detailsCard(
                                count: countData[2].toString(),
                                title: "your orders",
                                width: context.screenWidth / 3.5),
                          ],
                        );
                      }
                    }),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     detailsCard(count: data['cart_count'],title: "your cart", width: context.screenWidth/3.5),
                //     detailsCard(count: data['wishlist_count'],title: "your whishlist", width: context.screenWidth/3.5),
                //     detailsCard(count:data['order_count'],title: "your orders", width: context.screenWidth/3.5),
                //
                //   ],
                // ),

                // button section
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(color: lightGrey);
                  },
                  itemCount: profilebtnList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const OrderScreen());
                            break;
                          case 1:
                            Get.to(() => const WishlistScreen());
                            break;
                          case 2:
                            Get.to(() => const MessagesScreen());
                            break;
                        }
                      },
                      leading: Image.asset(
                        profilebtnicon[index],
                        width: 22,
                      ),
                      title: profilebtnList[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                    );
                  },
                )
                    .box
                    .white
                    .rounded
                    .margin(const EdgeInsets.all(12))
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ],
            ),
          );
        }
      },
    )));
  }
}
