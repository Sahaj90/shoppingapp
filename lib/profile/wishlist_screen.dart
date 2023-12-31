
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopingapp/Services/firestore_services.dart';
import 'package:shopingapp/consts/consts.dart';

import '../category/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getWishlist(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "Not Ordered yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data= snapshot.data!.docs;
              return Column(
                children: [Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(
                          leading: Image.network('${data[index]['p_img'][0]}',
                            // leading: Image.asset('${data[index]['img']}',
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['p_price']}"
                              .numCurrency
                              .text
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ).onTap(() {
                            firestore.collection(productCollections).doc(data[index].id).set({
                              'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                            },SetOptions(merge: true));
                          }),
                        );
                      }),
                ),],
              );
            }
          }
      ),
    );
  }
}
