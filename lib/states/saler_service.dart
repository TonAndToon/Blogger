import 'dart:convert';

import 'package:blogger/bodys/show_manage_seller.dart';
import 'package:blogger/bodys/show_order_seller.dart';
import 'package:blogger/bodys/show_product_seller.dart';
import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_progess.dart';
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
  List<Widget> widgets = [];
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
    await Dio().get(apiGetUserWhereId).then((value) {
      print('#### value ==>> $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          print('#### name logined = ${userModel!.name}');

          widgets.add(ShowOrderSeller(userModel: userModel!));
          widgets.add(ShowManageSeller(userModel: userModel!));
          widgets.add(ShowProductSeller(userModel: userModel!));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyContant.whColor,
        title: Text('ຜູ້ຂາຍ',style: TextStyle(fontFamily: 'NotoSansLao')),
      ),
      drawer: Drawer(
        width: 326,
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
      body: widgets.length == 0 ? ShowProgess() : widgets[indexWitget],
      //   body: widgets.isNotEmpty && indexWitget < widgets.length
      // ? widgets[indexWitget]
      // : Center(child: Text('No widget to display')),
    );
  }

  UserAccountsDrawerHeader buildHead() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage:
            NetworkImage('${MyContant.domain}${userModel?.avatar}'),
      ),
      accountName: Text(userModel == null ? 'Name ?' : userModel!.name,style: MyContant().h2StyleWh(),),
      accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type,style: MyContant().h3StyleWh(),),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            MyContant.greyColor,
            MyContant.primaryColor,
          ],
          center: Alignment(1.9, -0.7),
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
        title: 'ການສັ່ງຊື້',
        textStyle: MyContant().h2StyleD(),
      ),
      subtitle: ShowTitle(
        title: 'ລາຍລະອຽດການສັ່ງຊື້',
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
        title: 'ຈັດການໜ້າຮ້ານ',
        textStyle: MyContant().h2StyleD(),
      ),
      subtitle: ShowTitle(
        title: 'ລາຍລະອຽດຈັດການໜ້າຮ້ານ',
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
        title: 'ຈັດການສີນຄ້າ',
        textStyle: MyContant().h2StyleD(),
      ),
      subtitle: ShowTitle(
        title: 'ລາຍລະອຽດການຈັດການສີນຄ້າ',
        textStyle: MyContant().h3StyleD(),
      ),
    );
  }
}
