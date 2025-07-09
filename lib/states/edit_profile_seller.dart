import 'dart:convert';

import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileSeller extends StatefulWidget {
  const EditProfileSeller({super.key});

  @override
  State<EditProfileSeller> createState() => _EditProfileSellerState();
}

class _EditProfileSellerState extends State<EditProfileSeller> {
  UserModel? userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user')!;

    String apiGetUser =
        '${MyContant.domain}/bloggerr/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(apiGetUser).then(
      (value) {
        print('value from API ==>> $value');
        for (var item in json.decode(value.data)) {
          userModel = UserModel.fromMap(item);
          nameController.text = userModel!.name;
          addressController.text = userModel!.address;
          phoneController.text = userModel!.phone;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: MyContant.whColor,
          title: Text(
            'ແກ້ໄຂໂປຣຟາຍຜູ້ຂາຍ',
            style: TextStyle(fontFamily: 'NotoSansLao'),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => ListView(
            padding: EdgeInsets.all(15),
            children: [
              buildTitle('ຂໍ້ມູນ:'),
              buildName(constraints),
              buildAddress(constraints),
              buildPhone(constraints),
            ],
          ),
        ));
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: EdgeInsets.only(top: 15),
                  width: constraints.maxWidth * 0.87,
                  child: TextField(controller: nameController,
                    decoration: InputDecoration(labelText: 'ຊື່ແລະນາມສະກຸນ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            );
  }
  Row buildAddress(BoxConstraints constraints) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: EdgeInsets.only(top: 15),
                  width: constraints.maxWidth * 0.87,
                  child: TextField(controller: addressController,
                    decoration: InputDecoration(labelText: 'ທີ່ຢູ່',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            );
  }
  Row buildPhone(BoxConstraints constraints) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(margin: EdgeInsets.only(top: 15),
                  width: constraints.maxWidth * 0.87,
                  child: TextField(controller: phoneController,
                    decoration: InputDecoration(labelText: 'ເບີຕີດຕໍ່',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            );
  }

  ShowTitle buildTitle(String title) {
    return ShowTitle(
      title: title,
      textStyle: MyContant().h2StyleD(),
    );
  }
}
