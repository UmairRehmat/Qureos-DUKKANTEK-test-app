import 'dart:ffi';

import 'package:flutter/material.dart';
import 'constants.dart';

class RoundButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPress;

  const RoundButton({@required this.buttonText, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPress,
        elevation: 8,
        padding: EdgeInsets.all(8.0),
        color: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(buttonText!)),
        textColor: Colors.white,
      ),
    );
  }
}

class HalfRoundButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPress;

  const HalfRoundButton({@required this.buttonText, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: MaterialButton(
        onPressed: onPress,
        elevation: 4,
        padding: EdgeInsets.all(8.0),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(5.0),
            bottomLeft: const Radius.circular(5.0),
          ),
        ),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              buttonText!,
              style: TextStyle(fontSize: 26, fontFamily: "lato-regular"),
            )),
        textColor: Colors.white,
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPress;

  const BottomButton({@required this.buttonText, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPress,
        elevation: 8,
        padding: EdgeInsets.all(12.0),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(50.0),
            bottomLeft: const Radius.circular(50.0),
          ),
        ),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              buttonText!.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        textColor: Colors.white,
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final error;
  final String? label;
  final String? hint;
  final bool? isSecure;
  final IconData? icon;
  final Function(String)? onChange;
  final TextInputType? inputType;

  const TextInput(
      {@required this.controller,
      this.error,
      this.label,
      this.hint,
      this.isSecure = false,
      this.icon,
      this.onChange,
      this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isSecure!,
      onChanged: onChange,
      keyboardType: inputType,
      style: TextStyle(fontSize: 14, height: 1),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          labelText: label,
          suffixIcon: Icon(
            icon,
            color: kSecondaryColor,
          ),
          errorText: error,
          hintText: hint,
          hintStyle: TextStyle(
            color: kPrimaryColor,
          )),
    );
  }
}

class DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 14.0),
          width: 70.0,
          height: 3.0,
          decoration: BoxDecoration(
              color: kPrimaryColorLight,
              borderRadius: BorderRadius.all(Radius.circular(1.5))),
        ),
      ],
    );
  }
}

class BottomBarButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPress;

  const BottomBarButton({this.buttonText, this.onPress});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: FlatButton(
          // color: kPrimaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: onPress,
          child: Container(
            height: 60,
            // margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(40.0),
                topRight: const Radius.circular(40.0),
              ),
            ),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon(
                //   Icons.keyboard_arrow_up,
                //   size: 20,
                //   color: Colors.white,
                // ),
                Text(
                  buttonText!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white),
                ),
              ],
            )),
          ),
        ));
  }
}
