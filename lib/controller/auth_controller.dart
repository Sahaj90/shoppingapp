import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingapp/consts/consts.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;

  //text Controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({email,password,context}) async {
    UserCredential? userCredential;

    try{
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email,password,context}) async {
    UserCredential? userCredential;

    try{
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
  storeUserData({name,password,email}) async {
    DocumentReference store =  firestore.collection(userCollections).doc(currentUser!.uid);
    store.set({
      'name' : name,
      'password' : password,
      'email' : email,
      'imageUrl': '',
      'id' : currentUser!.uid,
      'cart_count': "00",
      'wishlist_count' : "00",
      'order_count' : "00"
    });
  }

  //signout method
  signOutMethod(context) async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
  
}