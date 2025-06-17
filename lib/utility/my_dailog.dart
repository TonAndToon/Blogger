import 'dart:io';

import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyDailog {
  Future<Null> alertLocationService(
      BuildContext context, String title, String messagebox) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(
            path: MyContant.img1,
          ),
          title: ShowTitle(
            title: title,
            textStyle: MyContant().h2StyleL(),
          ),
          subtitle: ShowTitle(
            title: messagebox,
            textStyle: MyContant().h3StyleL(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              //Navigator.pop(context);
              await Geolocator.openLocationSettings();
              exit(0);
            },
            child: Text(
              'OK',
              style: MyContant().h2StyleP(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> normalDailog(
      BuildContext context, String title, String messageboxx) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(
            path: MyContant.img4,
          ),
          title: ShowTitle(
            title: title,
            textStyle: MyContant().h2StyleP(),
          ),
          subtitle: ShowTitle(
            title: messageboxx,
            textStyle: MyContant().h3StyleP(),
          ),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OKay'),
          ),
        ],
      ),
    );
  }
}
