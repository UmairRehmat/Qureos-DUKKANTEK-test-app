import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:testforqureos/repositories/login_repository.dart';
import 'package:testforqureos/utills/app_widgets.dart';
import 'package:testforqureos/utills/common_utils.dart';
import 'package:testforqureos/utills/constants.dart';
import 'package:testforqureos/utills/transition_animation.dart';

import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = '/ResetPasswordScreen';
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _userNameController = TextEditingController();
  String? _userNameInvalid;
  Animation? animation;
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: const Icon(Icons.arrow_back),
            ),
            body: Transform(
              transform:
                  Matrix4.translationValues(animation?.value * width, 0.0, 0.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(18.0),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: height / 100 * 15,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kPrimaryColorLight,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Reset Password",
                                  style: kAppbarTextStyle,
                                ),
                                SizedBox(
                                  height: height / 100 * 1,
                                ),
                                const Text(
                                  "Enter your Email to rest password",
                                  style: kHeadingTextStyle,
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
                                label: "Email",
                                hint: "Email",
                                icon: Icons.person,
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
                                        widget: const LoginScreen(),
                                        alignment: Alignment.centerRight));
                              },
                              child: Text(
                                "Remember password? Login here",
                                textAlign: TextAlign.end,
                                style: kNormalTextStyle.copyWith(
                                    fontSize: 14, color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                        HalfRoundButton(
                          onPress: _loginClick,
                          buttonText: "Request Reset Password",
                        )
                      ],
                    ),
                  ),
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
        _userNameInvalid = "Enter valid UserName";
      });

      return;
    }
    _resetPassword();
  }

  void _resetPassword() async {
    // CommonUtils.changeScreenRemoveUntil(context, BottomNavigation.id);
    // return;
    CommonUtils.showLoadingDialog(context);
    var credentials = {
      'email': _userNameController.text,
    };
    String message = await UserRepository.resetPassword(credentials);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        TransitionEffect(
            widget: const LoginScreen(), alignment: Alignment.bottomCenter));
    CommonUtils.showSimpleDialog(context, "Attention Please", message, "Ok");
  }
}
