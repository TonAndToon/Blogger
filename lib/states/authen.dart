import 'dart:convert';

import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/utility/my_dailog.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 87,
                ),
                buildImage(size),
                buildTitle(),
                buildUser(size),
                buildPassword(size),
                buildLogin(size),
                buildCreateAccount(),
                SizedBox(
                  height: 78,
                ),
                buildVersionTitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildVersionTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ShowTitle(
            title: 'version :',
            textStyle: MyContant().h3StyleD(),
          ),
        ),
        Text(
          MyContant.version,
          style: MyContant().h3StyleL(),
        ),
      ],
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ShowTitle(
            title: ' Do you have account',
            textStyle: MyContant().h3StyleD(),
          ),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyContant.rounteCreateAccount),
          child: Text(
            'Create account',
            style: MyContant().h3StyleL(),
          ),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.95,
          height: size * 0.15,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: MyContant().myButtonStyle(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                String user = userController.text;
                String password = passwordController.text;
                print('#### User = $user, Password = $password');
                checkAuthen(user: user, password: password);
              }
            },
            child: Text(
              'Login',
              style: MyContant().h2StyleWh(),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> checkAuthen({String? user, String? password}) async {
    String apiCheckAuthen =
        '${MyContant.domain}/bloggerr/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiCheckAuthen).then((value) async {
      print('#### value for API ==>> $value');
      if (value.toString() == 'null') {
        MyDailog().normalDailog(context, 'User False !!!',
            'Don have user: >> $user << in Application');
      } else {
        for (var item in json.decode(value.data)) {
          UserModel model = UserModel.fromMap(item);
          if (password == model.password) {
            //Success Authen
            String type = model.type;
            print('#### Authen Success in Type ==>> $type');

            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString('type', type);
            preferences.setString('user', model.user);

            switch (type) {
              case 'buyer':
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MyContant.rounteBuyerService,
                  (route) => false,
                );
                break;

              case 'seller':
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MyContant.rounteSalerService,
                  (route) => false,
                );
                break;

              case 'rider':
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MyContant.rounteRiderService,
                  (route) => false,
                );
                break;

              default:
            }
          } else {
            //False Authen
            MyDailog().normalDailog(
                context, 'Password !!!', 'Password False Please try Again');
          }
        }
      }
    });
  }

  

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: size * 0.95,
          child: TextFormField(
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill user in Blank';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'User:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.account_circle,
                color: MyContant.primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: size * 0.95,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Fill password in Blank';
              } else {
                return null;
              }
            },
            obscureText: statusRedEye,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        Icons.remove_red_eye,
                        color: MyContant.primaryColor,
                      )
                    : Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyContant.primaryColor,
                      ),
              ),
              labelText: 'Password:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.key,
                color: MyContant.primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyContant.appName,
          textStyle: MyContant().h1StyleP(),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: ShowImage(path: MyContant.img1),
        ),
      ],
    );
  }
}
