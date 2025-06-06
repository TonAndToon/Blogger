import 'dart:io';

import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/utility/my_dailog.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  File? file;
  double? lat, lng;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();

    if (locationService) {
      print('Service Location open');

      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDailog().alertLocationService(
              context, 'Do not search location', 'Please to search location');
        } else {
          // Find LatLng
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDailog().alertLocationService(
              context, 'Do not search location', 'Please to search location');
        } else {
          // Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location close');
      MyDailog().alertLocationService(
          context, 'Location Service close?', 'Please open location service');
    }
  }

  Future<Null> findLatLng() async {
    print('findLatLng ==>> work');

    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;

      print('lat = $lat, lng = $lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.fingerprint,
                color: MyContant.primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Address :',
              hintStyle: MyContant().h3StyleP(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 52),
                child: Icon(
                  Icons.home,
                  color: MyContant.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhonenumber(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Phone :',
              hintStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.phone,
                color: MyContant.primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'User :',
              hintStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.account_circle,
                color: MyContant.primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Password :',
              hintStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.key,
                color: MyContant.primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: MyContant.lightColor,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyContant.primaryColor,
        title: Text(
          'Create account',
          style: TextStyle(color: MyContant.whColor),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            buildTitle('Information :'),
            buildName(size),
            buildTitle('Type User :'),
            buildRadioBuyer(size),
            buildRadioSeller(size),
            buildRadioRider(size),
            buildTitle('Basic information :'),
            buildAddress(size),
            buildPhonenumber(size),
            buildUser(size),
            buildPassword(size),
            buildTitle('Photo'),
            buildSubTitle(),
            buildAvatar(size),
            buildTitle('Location map'),
            buildMap(),
          ],
        ),
      ),
    );
  }

  Widget buildMap() => Container(
        width: double.infinity,
        height: 200,
        child: lat == null ? ShowProgess() : Text('Lat = $lat, Lng = $lng'),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            color: MyContant.primaryColor,
            size: 36,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: file == null
              ? ShowImage(path: MyContant.avatar)
              : Image.file(file!),
          height: size * 0.46,
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            color: MyContant.primaryColor,
            size: 36,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
      title:
          'Please show photo for create new account, If you dont show photo show image default! ',
      textStyle: MyContant().h3StyleP(),
    );
  }

  Row buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: '(Buyyer)',
              textStyle: MyContant().h3StyleP(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: '(Seller)',
              textStyle: MyContant().h3StyleP(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: '(Rider)',
              textStyle: MyContant().h3StyleP(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ShowTitle(
        title: title,
        textStyle: MyContant().h2StyleP(),
      ),
    );
  }
}
