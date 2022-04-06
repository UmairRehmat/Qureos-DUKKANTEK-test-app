import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

class CommonUtils {
  static showProgressBar() {
    return Column(
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  static Future<bool> internetAvailable() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
      return false;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  static showSimpleDialog(
      BuildContext context, String title, String content, String action) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  action,
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  static showLoadingDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              Fluttertoast.showToast(
                  msg: "Please wait its loading...",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: kPrimaryColor,
                  textColor: Colors.white,
                  fontSize: 12.0);
              return false;
            },
            child: SimpleDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              children: [
                Center(
                  child: Container(
                      height: 50, width: 50, child: CircularProgressIndicator()
                      // SpinKitCubeGrid(
                      //   size: 50.0,
                      //   color: Colors.white,
                      //   // controller: AnimationController( duration: const Duration(milliseconds: 1200)),
                      // ),
                      ),
                ),
              ],
            ),
          );
        });
  }

  //
  static changeScreenRemoveUntil(BuildContext context, String page) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(page, (dynamic route) => false);
  static navigate(BuildContext context, String page) =>
      Navigator.of(context).pushNamed(page);

  //
  static raisedButton(String buttonText, Function onPressedFunction) {
    return ButtonTheme(
      height: 50,
      minWidth: double.infinity,
      child: RaisedButton(
        onPressed: onPressedFunction(),
        child: Text(buttonText),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
      ),
    );
  }

  //
  static flatButton(String buttonText, Function onPressedFunction) {
    return ButtonTheme(
      height: 50,
      minWidth: double.infinity,
      child: FlatButton(
        onPressed: onPressedFunction(),
        child: Text(buttonText),
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
      ),
    );
  }

  static showToast(String message, {Color color = kPrimaryColor}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
