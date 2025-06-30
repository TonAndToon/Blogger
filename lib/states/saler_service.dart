import 'package:blogger/bodys/show_manage_seller.dart';
import 'package:blogger/bodys/show_order_seller.dart';
import 'package:blogger/bodys/show_product_seller.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_signout.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: MyContant.whColor,
        title: Text('ຜູ້ຂາຍ'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: null,
                  accountEmail: null,
                  decoration: BoxDecoration(color: MyContant.primaryColor),
                ),
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
