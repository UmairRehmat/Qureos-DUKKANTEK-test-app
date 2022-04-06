import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const userToken = "userToken";
const kAppbarTextStyle = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w900,
    fontFamily: 'lato-regular',
    fontStyle: FontStyle.italic,
    color: kSecondaryColor);
const kAppbarTextStyleLogged = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w900,
    fontFamily: 'lato-regular',
    letterSpacing: 1.5,
    fontStyle: FontStyle.italic,
    color: Colors.white);
const kMediumTextStyle = TextStyle(fontSize: 18.0, color: Colors.black);
const kMediumBoldTextStyle =
    TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w700);
final kInnerHeading = TextStyle(
    fontFamily: 'lato-regular',
    fontSize: 16.0,
    color: kPrimaryColor,
    fontWeight: FontWeight.w600);
const kNormalTextStyle = TextStyle(fontSize: 16.0, color: Colors.black);
const kSmallTextStyle = TextStyle(fontSize: 14.0, color: Colors.black);
const kSmallBoldTextStyle =
    TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold);
const kNormalButtonTextStyle = TextStyle(fontSize: 14.0);
enum DeliveryConstants { NewAssigned, Accepted, Rejected, PickedUp, Delivered }
const kHeadingTextStyle = TextStyle(fontSize: 16.0, color: Colors.black);
const Color kSecondaryColor = Color(0xFF131312);
const Color kPrimaryColor = Color(0xffee882d);
const Color kPrimaryColorLight = Color(0xffe59f64);
const Color kBackgroundColor = Color(0xFFFFFFFF);
