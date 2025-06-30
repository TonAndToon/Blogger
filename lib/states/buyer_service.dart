//import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_signout.dart';
import 'package:flutter/material.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({super.key});

  @override
  State<BuyerService> createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: MyContant.whColor,
        title: Text('ຜູ້ຊື້'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
