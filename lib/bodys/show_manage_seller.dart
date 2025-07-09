import 'package:blogger/models/user_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: MyContant.whColor,
        ),
        backgroundColor: MyContant.primaryColor,
        onPressed: () => Navigator.pushNamed(
          context,
          MyContant.rounteEditProfileSeller,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ShowTitle(
                    title: 'ຊື່ຮ້ານ:',
                    textStyle: MyContant().h2StyleD(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShowTitle(
                      title: userModel!.name,
                      textStyle: MyContant().h1StyleP(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ShowTitle(
                    title: 'ທີ່ຢູ່:',
                    textStyle: MyContant().h2StyleD(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.78,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShowTitle(
                          title: userModel!.address,
                          textStyle: MyContant().h2StyleP(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ShowTitle(
                    title: 'ເບີຕິດຕໍ່: ${userModel!.phone}',
                    textStyle: MyContant().h2StyleD(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ShowTitle(
                    title: 'ຮູບພາບ:',
                    textStyle: MyContant().h2StyleD(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(),
                      width: constraints.maxWidth * 0.42,
                      child: CachedNetworkImage(
                        imageUrl: '${MyContant.domain}${userModel!.avatar}',
                        placeholder: (context, url) => ShowProgess(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ShowTitle(
                    title: 'ແຜນທີ:',
                    textStyle: MyContant().h2StyleD(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: constraints.maxWidth * 0.95,
                      height: constraints.maxWidth * 0.78,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(userModel!.lat),
                            double.parse(userModel!.lng),
                          ),
                          zoom: 15,
                        ),
                        markers: <Marker>[
                          Marker(
                            markerId: MarkerId('id'),
                            position: LatLng(
                              double.parse(userModel!.lat),
                              double.parse(userModel!.lng),
                            ),
                            infoWindow: InfoWindow(
                                title: 'ຈູດພິກັດຂອງທ່ານ',
                                snippet:
                                    'Lat = ${userModel!.lat}, Lag = ${userModel!.lng}'),
                          ),
                        ].toSet(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
