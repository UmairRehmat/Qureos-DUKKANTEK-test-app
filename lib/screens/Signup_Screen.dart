import 'package:flutter/material.dart';
import 'package:testforqureos/repositories/sign_up_repository.dart';
import 'package:testforqureos/utills/app_widgets.dart';
import 'package:testforqureos/utills/common_utils.dart';
import 'package:testforqureos/utills/constants.dart';
import 'package:testforqureos/utills/transition_animation.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _passwordInvalid;
  String? _userNameInvalid;
  String? _nameInvalid;
  String? _confirmPasswordInvalid;
  Animation? animation;
  Animation? bottomAnimation;
  AnimationController? animationController;
  @override
  void initState() {
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
                          // elevation: 5.0,
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
                                      controller: _nameController,
                                      error: _nameInvalid,
                                      onChange: (text) {
                                        setState(() {
                                          _nameInvalid = null;
                                        });
                                      },
                                      label: "Name",
                                      hint: "Name",
                                      icon: Icons.person,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextInput(
                                      controller: _confirmPasswordController,
                                      error: _confirmPasswordInvalid,
                                      label: "Confirm Password",
                                      hint: "Confirm Password",
                                      onChange: (text) {
                                        setState(() {
                                          _confirmPasswordInvalid = null;
                                        });
                                      },
                                      isSecure: true,
                                      icon: Icons.lock,
                                    ),
                                  ],
                                ),
                              ),
                              HalfRoundButton(
                                onPress: _loginClick,
                                buttonText: "Register",
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          TransitionEffect(
                                              widget: const LoginScreen(),
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
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameInvalid = "Enter Name";
      });
      return;
    }
    if (_nameController.text.length < 4) {
      setState(() {
        _nameInvalid = "Enter valid Name";
      });

      return;
    }
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
    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordInvalid = "Enter confirm password";
      });
      return;
    }
    if (_confirmPasswordController.text.length < 6) {
      setState(() {
        _confirmPasswordInvalid = "Enter valid confirm password";
      });
      return;
    }
    _loginUser();
  }

  void _loginUser() async {
    CommonUtils.showLoadingDialog(context);
    var credentials = {
      'name': _nameController.text,
      'email': _userNameController.text,
      'password': _passwordController.text,
      'password_confirmation': _confirmPasswordController.text,
      // 'fcm': fcm
    };
    String message = await SignUpRepository.createUser(credentials);

    if (!message.startsWith('error')) {
      Navigator.pushAndRemoveUntil(
          context,
          TransitionEffect(
              widget: const LoginScreen(), alignment: Alignment.center),
          (route) => false);
      CommonUtils.showSimpleDialog(context, "Attention Please", message, "Ok");
    } else {
      Navigator.pop(context);
      CommonUtils.showSimpleDialog(context, "Attention Please", message, "Ok");
    }
  }
}
