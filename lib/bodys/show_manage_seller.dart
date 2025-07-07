import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowManageSeller extends StatefulWidget {
  final UserModel userModel;
  const ShowManageSeller({super.key, required this.userModel});

  @override
  State<ShowManageSeller> createState() => _ShowManageSellerState();
}

class _ShowManageSellerState extends State<ShowManageSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowTitle(
            title: 'ຊື່ຮ້ານ:',
            textStyle: MyContant().h2StyleD(),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTitle(
                title: userModel!.name,
                textStyle: MyContant().h1StyleP(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
