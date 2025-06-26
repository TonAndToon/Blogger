import 'dart:convert';

import 'package:blogger/models/product_model.dart';
import 'package:blogger/states/add_product.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({super.key});

  @override
  State<ShowProductSeller> createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  bool load = true;
  bool? haveData;

  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;

    String apiGetProductWhereIdSeller =
        '${MyContant.domain}/bloggerr/getProductWhereidSeller.php?isAdd=true&idSeller=$id';
    await Dio().get(apiGetProductWhereIdSeller).then(
      (value) {
        //print('value ==>> $value');

        if (value.toString() == 'null') {
          //No data
          setState(() {
            load = false;
            haveData = false;
          });
        } else {
          //Have data
          for (var item in json.decode(value.data)) {
            ProductModel model = ProductModel.fromMap(item);
            print('#### name Product ==>> ${model.name}');

            setState(() {
              load = false;
              haveData = true;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgess()
          : haveData!
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                          title: 'Have product',
                          textStyle: MyContant().h1StyleP()),
                      ShowTitle(
                          title: 'Show product soon',
                          textStyle: MyContant().h3StyleP()),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                          title: 'No Product',
                          textStyle: MyContant().h1StyleP()),
                      ShowTitle(
                          title: 'Please add product',
                          textStyle: MyContant().h3StyleP()),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyContant.primaryColor,
        foregroundColor: MyContant.whColor,
        onPressed: () => Navigator.pushNamed(
          context,
          MyContant.rounteAddProduct,
        ),
        child: Text('Add'),
      ),
    );
  }
}
