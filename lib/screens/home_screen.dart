import 'package:flutter/material.dart';
import 'package:testforqureos/providers/shared_pref_provider.dart';
import 'package:testforqureos/repositories/login_repository.dart';
import 'package:testforqureos/utills/common_utils.dart';
import 'package:testforqureos/utills/constants.dart';
import 'package:testforqureos/utills/transition_animation.dart';

import '../main.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: kAppbarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Center(
          child: Column(
            // shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Hello ${appUser?.email}",
                          style: kAppbarTextStyle,
                        ),
                      ),
                      const Text(
                        "Submission by:\n Name : Hafiz Muhammad Umair Rehmat\n Email: Umairrehmat7@gmail.com",
                        style: kAppbarTextStyle,
                      ),
                    ],
                  )),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                    color: kPrimaryColorLight,
                    width: 1.0,
                  ),
                ),
                elevation: 3,
                child: InkWell(
                  onTap: _logoutClick,
                  child: ListTile(
                    trailing: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.8),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: const Icon(
                        Icons.logout,
                        size: 28,
                        color: kSecondaryColor,
                      ),
                    ),
                    title: const Text(
                      "Logout",
                      style: kNormalTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logoutClick() async {
    CommonUtils.showLoadingDialog(context);
    var logoutResponse = await UserRepository.logoutUser();
    if (logoutResponse == "200") {
      await SharedPrefProvider.clearKey(userToken);
      Navigator.pushAndRemoveUntil(
          context,
          TransitionEffect(widget: LoginScreen(), alignment: Alignment.center),
          (route) => false);
    } else {
      Navigator.pop(context);
      CommonUtils.showSimpleDialog(
          context, "Failed", "Something went Wrong", "Ok");
    }
  }
}
