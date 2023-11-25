import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopingapp/auth_screen/login_screen.dart';
import 'package:shopingapp/consts/consts.dart';
import 'package:shopingapp/widgets/applogo_wid.dart';

import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      // Get.to(()=>LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(() => const LoginScreen());
        }else{
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body:Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft ,
                child: Image.asset(icSplashBg,width: 300)),
          20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //splash ui completed
          ]
        ),
      ),
    );
  }
}
