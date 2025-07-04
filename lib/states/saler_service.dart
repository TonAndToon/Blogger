import 'dart:convert';

import 'package:blogger/bodys/show_manage_seller.dart';
import 'package:blogger/bodys/show_order_seller.dart';
import 'package:blogger/bodys/show_product_seller.dart';
import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_signout.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class SalerService extends StatefulWidget {
  const SalerService({super.key});

  @override
  State<SalerService> createState() => _SalerServiceState();
}

class _SalerServiceState extends State<SalerService> {
  List<Widget> widgets = [
    ShowOrderSeller(),
    ShowManageSeller(),
    ShowProductSeller(),
  ];
  int indexWitget = 0;

  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    print('id Logined ==>> $id');
    String apiGetUserWhereId =
        '${MyContant.domain}/bloggerr/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then(
      (value) {
        print('#### value ==>> $value');
        for (var item in json.decode(value.data)) {
          setState(() {
            userModel = UserModel.fromMap(item);
            print('#### name logined = ${userModel!.name}');
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyContant.whColor,
        title: Text('ຜູ້ຂາຍ'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                buildHead(),
                menuShowOrder(),
                menuShowManage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWitget],
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage:
            NetworkImage('${MyContant.domain}${userModel?.avatar}'),
      ),
      accountName: Text(userModel == null ? 'Name ?' : userModel!.name),
      accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            MyContant.lightColor,
            MyContant.darkColor,
          ],center: Alignment(-0.7, -0.2)
        ),
      ),
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWitget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1_outlined),
      title: ShowTitle(
        title: 'Show Order',
        textStyle: MyContant().h2StyleD(),
      ),
      subtitle: ShowTitle(
        title: 'Show detail order',
        textStyle: MyContant().h3StyleD(),
      ),
    );
  }

  ListTile menuShowManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWitget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2_outlined),
      title: ShowTitle(
        title: 'Show Manage',
        textStyle: MyContant().h2StyleD(),
      ),
      subtitle: ShowTitle(
        title: 'Show detail shop',
        textStyle: MyContant().h3StyleD(),
      ),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWitget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3_outlined),
      title: ShowTitle(
        title: 'Show Product',
        textStyle: MyContant().h2StyleD(),
      ),
      subtitle: ShowTitle(
        title: 'Show detail product',
        textStyle: MyContant().h3StyleD(),
      ),
    );
  }
}
