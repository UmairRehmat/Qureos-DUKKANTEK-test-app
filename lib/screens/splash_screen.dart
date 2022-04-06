import 'package:flutter/material.dart';
import 'package:testforqureos/models/User.dart';
import 'package:testforqureos/providers/shared_pref_provider.dart';
import 'package:testforqureos/repositories/login_repository.dart';
import 'package:testforqureos/utills/constants.dart';
import 'package:testforqureos/utills/transition_animation.dart';
import '../main.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation? animation;
  AnimationController? animationController;

  @override
  void initState() {
    // TODO: implement initState
    moveToNextScreen();
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
    );
    animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: (width / 2) * animation?.value,
                child: Image.asset("assets/main_logo.png"),
              ),
            ),
          );
        });
  }

  void moveToNextScreen() async {
    String? token = await SharedPrefProvider.getString(userToken);
    if (token != null) {
      UserResponse userResponse = await UserRepository.loginUser(token);
      if (userResponse.success!) {
        if (userResponse.user != null) {
          appUser = userResponse.user;
          dataList = userResponse.extraData;
          SharedPrefProvider.setString(userToken, userResponse.token);
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pushAndRemoveUntil(
                context,
                TransitionEffect(
                    widget: const HomeScreen(),
                    alignment: Alignment.centerLeft,
                    durationAnimation: 650),
                (route) => false);
          });
          // CommonUtils.showSimpleDialog(
          //     context, "Login success", "${userResponse.message}", "Ok");
        }
        return;
      }
      SharedPrefProvider.clearKey(userToken);
      // return;
    }
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          TransitionEffect(
              widget: const LoginScreen(),
              alignment: Alignment.centerLeft,
              durationAnimation: 650),
          (route) => false);
    });
  }
}
