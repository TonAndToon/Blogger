import 'package:flutter/material.dart';

class MyContant {
  //General
  static String appName = 'LDB Blogger';
  static String version = ' 20250605.V1.0.1';
  static String domain = 'https://7e3f-202-136-243-67.ngrok-free.app';

  //Route
  static String rounteAuthen = '/authen';
  static String rounteCreateAccount = '/createAccount';
  static String rounteBuyerService = '/buyerService';
  static String rounteSalerService = '/salerService';
  static String rounteRiderService = '/riderService';
  static String rounteAddProduct = '/addProduct';

  //Images
  static String img1 = 'assets/images/ATM1.webp';
  static String img2 = 'assets/images/ATM2.webp';
  static String img3 = 'assets/images/ATM3.webp';
  static String img4 = 'assets/images/ATM4.webp';
  static String avatar = 'assets/images/account_avatar_user_icon.webp';
  static String iconphotolb = 'assets/images/icon_img_ligth_blue.webp';
  static String iconphotodb = 'assets/images/icon_img_dark_blue.webp';

  //Colors
  static Color primaryColor = Color(0xff1E88E5);
  static Color lightColor = Color(0xff64b4f6);
  static Color darkColor = Color(0xff1146a0);
  static Color whColor = Color(0xffFFFFFF);
  static Color redColor = Colors.red;

  static Map<int, Color> mapMaterialColor = {
  50:Color.fromRGBO(30, 136, 229, 0.1),
  100:Color.fromRGBO(30, 136, 229, 0.2),
  200:Color.fromRGBO(30, 136, 229, 0.3),
  300:Color.fromRGBO(30, 136, 229, 0.4),
  400:Color.fromRGBO(30, 136, 229, 0.5),
  500:Color.fromRGBO(30, 136, 229, 0.6),
  600:Color.fromRGBO(30, 136, 229, 0.7),
  700:Color.fromRGBO(30, 136, 229, 0.8),
  800:Color.fromRGBO(30, 136, 229, 0.9),
  900:Color.fromRGBO(30, 136, 229, 1.0),
  };

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
