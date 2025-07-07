import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_signout.dart';
import 'package:flutter/material.dart';

class RiderService extends StatefulWidget {
  const RiderService({super.key});

  @override
  State<RiderService> createState() => _RiderServiceState();
}

class _RiderServiceState extends State<RiderService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: MyContant.whColor,
        title: Text('ຜູ້ສົ່ງ',style: TextStyle(fontFamily: 'NotoSansLao',),),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
