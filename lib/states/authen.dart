import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildImage(size),
              buildTitle(),
              buildUser(size),
              buildPassword(size),
              buildLogin(size),
              buildCreateAccount(),
            ],
          ),
        ),
      ),
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
            style: MyContant().h2StyleL(),
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
          width: size * 0.63,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: MyContant().myButtonStyle(),
            onPressed: () {},
            child: Text(
              'Login',
              style: MyContant().h2StyleWh(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: size * 0.63,
          child: TextFormField(
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
          width: size * 0.63,
          child: TextFormField(
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
