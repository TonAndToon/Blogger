import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                    context,
                    MyContant.rounteAuthen,
                    (route) => false,
                  ),
                );
          },
          leading: Icon(
            Icons.logout_outlined,
            size: 36,
          ),
          title: ShowTitle(
            title: 'Sign Out',
            textStyle: MyContant().h2StyleD(),
          ),
          subtitle: ShowTitle(
            title: 'Sign Out and go to Authen',
            textStyle: MyContant().h3StyleD(),
          ),
        ),
      ],
    );;
  }
}