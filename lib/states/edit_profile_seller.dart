import 'dart:convert';
import 'dart:math';

import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_progess.dart';
//import 'package:blogger/widgets/show_image.dart';
//import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng? latLng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    Position? position = await findPosition();
    if (position != null) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
        print('lat = ${latLng!.latitude}');
      });
    }
  }

  Future<Position?> findPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }
    return position;
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
          setState(() {
            userModel = UserModel.fromMap(item);
            nameController.text = userModel!.name;
            addressController.text = userModel!.address;
            phoneController.text = userModel!.phone;
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
            buildTitle('ຮູບພາບ:'),
            buildAvatar(constraints),
            buildTitle('ແຜ່ນທີ:'),
            buildMap(constraints),
          ],
        ),
      ),
    );
  }

  Row buildMap(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyContant.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(vertical: 15),
          width: constraints.maxWidth * 0.9,
          height: constraints.maxWidth * 0.9,
          child: latLng == null
              ? ShowProgess()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: latLng!,
                    zoom: 18,
                  ),
                  onMapCreated: (controller) {},
                  markers: <Marker>[
                    Marker(
                      markerId: MarkerId('id'),
                      position: latLng!,
                      infoWindow: InfoWindow(
                          title: 'ຈຸດພິກັດຂອງທ່ານ',
                          snippet:
                              'lat = ${latLng!.latitude}, lng = ${latLng!.longitude}'),
                    ),
                  ].toSet(),
                ),
        ),
      ],
    );
  }

  Row buildAvatar(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: MyContant.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_a_photo,
                  color: MyContant.primaryColor,
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.6,
                height: constraints.maxWidth * 0.6,
                child: userModel == null
                    ? ShowProgess()
                    : Padding(
                        padding: EdgeInsets.all(8.0),
                        child: userModel?.avatar == null
                            ? ShowImage(path: MyContant.avatar)
                            : CachedNetworkImage(
                                imageUrl:
                                    '${MyContant.domain}${userModel!.avatar}',
                                placeholder: (context, url) => ShowProgess(),
                              ),
                      ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_photo_alternate,
                  color: MyContant.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: constraints.maxWidth * 0.87,
          child: TextField(
            style: TextStyle(fontFamily: 'NotoSansLao'),
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'ຊື່ແລະນາມສະກຸນ',
              labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 2,
                ),
              ),
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
        Container(
          margin: EdgeInsets.only(top: 15),
          width: constraints.maxWidth * 0.87,
          child: TextField(
            style: TextStyle(fontFamily: 'NotoSansLao'),
            maxLines: 4,
            controller: addressController,
            decoration: InputDecoration(
              labelText: 'ທີ່ຢູ່',
              labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 2,
                ),
              ),
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
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: constraints.maxWidth * 0.87,
          child: TextField(
            style: TextStyle(fontFamily: 'NotoSansLao'),
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'ເບີຕີດຕໍ່',
              labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 2,
                ),
              ),
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
