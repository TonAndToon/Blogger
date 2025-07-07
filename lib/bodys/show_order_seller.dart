import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:flutter/material.dart';

class ShowOrderSeller extends StatefulWidget {
  const ShowOrderSeller({super.key, required UserModel userModel});

  @override
  State<ShowOrderSeller> createState() => _ShowOrderSellerState();
}

class _ShowOrderSellerState extends State<ShowOrderSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('ໜ້າລາຍການສັ່ງຊື້:',style: MyContant().h3StyleD(),),
    );
  }
}
