import 'dart:io';
import 'dart:math';

import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/utility/my_dailog.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  String avatar = '';
  File? file;
  double? lat, lng;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plaese fill name';
              } else {}
              return null;
            },
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
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plaese fill address';
              } else {}
              return null;
            },
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
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plaese fill phonenumber';
              } else {}
              return null;
            },
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
            controller: userController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plaese fill user';
              } else {}
              return null;
            },
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
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Plaese fill password';
              } else {}
              return null;
            },
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
        actions: [
          buildCreateMyAccount(),
        ],
        backgroundColor: MyContant.primaryColor,
        title: Text(
          'Create account',
          style: TextStyle(color: MyContant.whColor),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
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
        ),
      ),
    );
  }

  IconButton buildCreateMyAccount() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non choose type User');
            MyDailog().normalDailog(
                context, 'Your do not choose User', 'Plaese to choose User');
          } else {
            print('Process Insert to Database');
            uploadPictureAndInsertData();
          }
        }
      },
      icon: Icon(
        Icons.cloud_upload_outlined,
        color: MyContant.whColor,
      ),
    );
  }

  Future<Null> uploadPictureAndInsertData() async {
    String name = nameController.text;
    String address = addressController.text;
    String phone = phoneController.text;
    String user = userController.text;
    String password = passwordController.text;

    print(
        '#### name = $name, address = $address, phone = $phone, user = $user, password = $password');
    String path =
        '${MyContant.domain}/bloggerr/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then(
      (value) async {
        print('#### value ==>> $value');
        if (value.toString() == 'null') {
          print('#### User OK');

          if (file == null) {
            //No Avatar
            processInsertMySQL(
              name: name,
              type: typeUser,
              address: address,
              phone: phone,
              user: user,
              password: password,
            );
          } else {
            //Have Avatar
            print('#### process Upload Avatar');
            String apiSaveAvatar =
                '${MyContant.domain}/bloggerr/saveAvatar.php';
            int i = Random().nextInt(100000);
            String nameAvatar = 'avatar$i.jpg';
            Map<String, dynamic> map = Map();
            map['file'] =
                await MultipartFile.fromFile(file!.path, filename: nameAvatar);
            FormData data = FormData.fromMap(map);
            await Dio().post(apiSaveAvatar, data: data).then(
              (value) {
                avatar = '/bloggerr/avatar/$nameAvatar';
                processInsertMySQL(
                  name: name,
                  type: typeUser,
                  address: address,
                  phone: phone,
                  user: user,
                  password: password,
                );
              },
            );
          }
        } else {
          MyDailog()
              .normalDailog(context, 'User false ?', 'Please Change User');
        }
      },
    );
  }

  Future<Null> processInsertMySQL({
    String? name,
    String? type,
    String? address,
    String? phone,
    String? user,
    String? password,
  }) async {
    print('#### processInsertMySQL Work and avatar ==>> $avatar');
    String apiInsertUser =
        '${MyContant.domain}/bloggerr/insertUser.php?isAdd=true&name=$name&type=$type&address=$address&phone=$phone&user=$user&password=$password&avatar=$avatar&lat=$lat&lng=$lng';

    await Dio().get(apiInsertUser).then(
      (value) {
        if (value.toString() == 'true') {
          Navigator.pop(context);
        } else {
          MyDailog().normalDailog(
              context, 'Create New User False !!!', 'Please Try Again');
        }
      },
    );
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow:
              InfoWindow(title: 'You here', snippet: 'Lat = $lat, Lng = $lng'),
        ),
      ].toSet();

  Widget buildMap() => Container(
        width: double.infinity,
        height: 326,
        child: lat == null
            ? ShowProgess()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller) {},
                markers: setMarker(),
              ),
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
