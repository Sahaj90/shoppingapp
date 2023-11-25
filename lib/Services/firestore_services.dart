import 'package:shopingapp/consts/consts.dart';

class FireStoreServices{

  //get users data
  static getUser(uid){
    return firestore.collection(userCollections).where('id', isEqualTo : uid).snapshots();
  }
  
  //get products according to category
  static getProducts(category){
    return firestore.collection(productCollections).where('p_category',isEqualTo: category).snapshots();
  }

  //get cart
  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  //delete document
  static deletdeDoc(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get all chat msgs
  static getChatMsgs(docId){
    return firestore.collection(chatCollection)
        .doc(docId).collection(messageCollection)
        .orderBy('created_on',descending: false).snapshots();
  }
  
  static getAllOrders(){
    return firestore.collection(orderCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  static getWishlist(){
    return firestore.collection(productCollections).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMsgs(){
    return firestore.collection(chatCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }

  static getCounts() async{
    var res = await Future.wait([
    firestore.collection(orderCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
      return value.docs.length;
    }),
      firestore.collection(productCollections).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts(){
    return firestore.collection(productCollections).snapshots();
  }

  //getFeatured Products
  static getFeaturedProducts(){
    return firestore.collection(productCollections).where('is_featured',isEqualTo: true).get();
  }
  static searchProducts(title){
    return firestore.collection(productCollections).get();
  }

  static SubCategoryProduct(title){
    return firestore.collection(productCollections).where('p_subcat',isEqualTo: title).get();
  }
}