import 'package:flutter/material.dart';

class MyContant {
  //General
  static String appName = 'LDB Blogger';
  static String version = ' 20250605.V1.0.1';

  //Route
  static String rounteAuthen = '/authen';
  static String rounteCreateAccount = '/createAccount';
  static String rounteBuyerService = '/buyerService';
  static String rounteSalerService = '/salerService';
  static String rounteRiderService = '/riderService';

  //Images
  static String img1 = 'assets/images/ATM1.webp';
  static String img2 = 'assets/images/ATM2.webp';
  static String img3 = 'assets/images/ATM3.webp';
  static String img4 = 'assets/images/ATM4.webp';
  static String avatar = 'assets/images/account_avatar_user_icon.webp';

  //Colors
  static Color primaryColor = Color(0xff1E88E5);
  static Color lightColor = Color(0xff64b4f6);
  static Color darkColor = Color(0xff1146a0);
  static Color whColor = Color(0xffFFFFFF);

  //Text style
  //Primary color
  TextStyle h1StyleP() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: MyContant.primaryColor,
      );
  TextStyle h2StyleP() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: MyContant.primaryColor,
      );
  TextStyle h3StyleP() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: MyContant.primaryColor,
      );

  //Light color
  TextStyle h1StyleL() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: MyContant.lightColor,
      );
  TextStyle h2StyleL() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: MyContant.lightColor,
      );
  TextStyle h3StyleL() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: MyContant.lightColor,
      );

  //Dark color
  TextStyle h1StyleD() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: MyContant.darkColor,
      );
  TextStyle h2StyleD() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: MyContant.darkColor,
      );
  TextStyle h3StyleD() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: MyContant.darkColor,
      );

  //Write color
  TextStyle h1StyleWh() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: MyContant.whColor,
      );
  TextStyle h2StyleWh() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: MyContant.whColor,
      );
  TextStyle h3StyleWh() => TextStyle(
        fontFamily: 'NotoSanLaos',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: MyContant.whColor,
      );

  //Button style
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: MyContant.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
}
