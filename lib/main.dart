import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shopingapp/consts/colors.dart';
import 'package:shopingapp/consts/styles.dart';
import 'package:shopingapp/views/splash_screen.dart';
import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    //change material app to getmaterialapp

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appname',
      theme: ThemeData(
       scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
          backgroundColor: Colors.transparent,
              elevation: 0.0
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}

