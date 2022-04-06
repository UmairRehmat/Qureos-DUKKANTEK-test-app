import 'package:flutter/material.dart';
import 'package:testforqureos/models/User.dart';
import 'package:testforqureos/providers/shared_pref_provider.dart';
import 'package:testforqureos/repositories/login_repository.dart';
import 'package:testforqureos/screens/reset_password_screen.dart';
import 'package:testforqureos/utills/app_widgets.dart';
import 'package:testforqureos/utills/common_utils.dart';
import 'package:testforqureos/utills/constants.dart';
import 'package:testforqureos/utills/transition_animation.dart';

import '../main.dart';
import 'Signup_Screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _passwordInvalid;
  String? _userNameInvalid;
  Animation? animation;
  Animation? bottomAnimation;
  AnimationController? animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
    );
    bottomAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
    );
    animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(
                          bottomAnimation?.value * width, 0.0, 0.0),
                      child: const Image(
                        height: 120,
                        width: 120,
                        image: AssetImage('assets/main_logo.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "DUKKANTEK Test App",
                      textAlign: TextAlign.center,
                      style: kMediumBoldTextStyle.copyWith(
                          color: kSecondaryColor, fontSize: 26.0),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(
                          animation?.value * height, 0.0, 0.0),
                      child: Center(
                        child: Card(
                          margin: const EdgeInsets.all(18.0),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  minHeight: 60,
                                ),
                                height: height / 100 * 8,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: kPrimaryColorLight,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        "Login Here",
                                        style: kAppbarTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextInput(
                                      controller: _userNameController,
                                      error: _userNameInvalid,
                                      onChange: (text) {
                                        setState(() {
                                          _userNameInvalid = null;
                                        });
                                      },
                                      label: "Username/Email",
                                      hint: "Username/Email",
                                      icon: Icons.email,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextInput(
                                      controller: _passwordController,
                                      error: _passwordInvalid,
                                      label: "Password",
                                      hint: "Password",
                                      onChange: (text) {
                                        setState(() {
                                          _passwordInvalid = null;
                                        });
                                      },
                                      isSecure: true,
                                      icon: Icons.lock,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          TransitionEffect(
                                              widget: ResetPasswordScreen(),
                                              alignment:
                                                  Alignment.centerRight));
                                    },
                                    child: Text(
                                      "Forget Password? Reset here",
                                      textAlign: TextAlign.end,
                                      style: kNormalTextStyle.copyWith(
                                          fontSize: 14,
                                          color: Colors.red.shade700),
                                    ),
                                  ),
                                ],
                              ),
                              HalfRoundButton(
                                onPress: _loginClick,
                                buttonText: "Login",
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          TransitionEffect(
                                              widget: SignUpScreen(),
                                              alignment:
                                                  Alignment.centerRight));
                                    },
                                    child: Text(
                                      "Didn't have a account? Register here",
                                      textAlign: TextAlign.center,
                                      style: kNormalTextStyle.copyWith(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _loginClick() {
    // openMap(0.0, 0.0);
    FocusScope.of(context).requestFocus(FocusNode());
    if (_userNameController.text.isEmpty) {
      setState(() {
        _userNameInvalid = "Enter Email";
      });
      return;
    }
    if (_userNameController.text.length < 4) {
      setState(() {
        _userNameInvalid = "Enter valid UserName/Email";
      });

      return;
    }
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordInvalid = "Enter password";
      });
      return;
    }
    if (_passwordController.text.length < 6) {
      setState(() {
        _passwordInvalid = "Enter valid password";
      });
      return;
    }
    _loginUser();
  }

  void _loginUser() async {
    // CommonUtils.changeScreenRemoveUntil(context, BottomNavigation.id);
    // return;
    CommonUtils.showLoadingDialog(context);
    var credentials = {
      'email': _userNameController.text,
      'password': _passwordController.text,
      'latitude': 34.84443,
      'longitude': 4.498444,
      // 'fcm': fcm
    };
    UserResponse userResponse = await UserRepository.loginUser(credentials);
    if (userResponse.success!) {
      if (userResponse.user != null) {
        appUser = userResponse.user;
        dataList = userResponse.extraData;
        SharedPrefProvider.setString(userToken, userResponse.token);
        Navigator.pushAndRemoveUntil(
            context,
            TransitionEffect(
                widget: const HomeScreen(), alignment: Alignment.center),
            (route) => false);
        // CommonUtils.showSimpleDialog(
        //     context, "Login success", "${userResponse.message}", "Ok");
      }
      return;
    }
    Navigator.pop(context);
    CommonUtils.showSimpleDialog(
        context, "Login Failed", "error ${userResponse.message}", "Ok");
  }
}
