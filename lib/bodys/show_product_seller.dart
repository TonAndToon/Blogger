import 'dart:convert';

import 'package:blogger/models/product_model.dart';
//import 'package:blogger/states/add_product.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  List<ProductModel> productModels = [];

  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    if (productModels.length != 0) {
      productModels.clear();
    } else {}
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
              productModels.add(model);
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
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints),
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
        ).then(
          (value) => loadValueFromAPI(),
        ),
        child: Text('Add'),
      ),
    );
  }

  String createUrl(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> strings = result.split(',');
    String url = '${MyContant.domain}/bloggerr${strings[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9),
              width: constraints.maxWidth * 0.5 - 5,
              height: constraints.maxWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShowTitle(
                    title: productModels[index].name,
                    textStyle: MyContant().h2StyleP(),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxWidth * 0.5,
                    child: CachedNetworkImage(
                      imageUrl: createUrl(productModels[index].images),
                      placeholder: (context, url) => ShowProgess(),
                      errorWidget: (context, url, error) =>
                          ShowImage(path: MyContant.img1),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 42),
              padding: EdgeInsets.all(9),
              width: constraints.maxWidth * 0.5 - 9,
              height: constraints.maxWidth * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                    title: 'ລາຄາ: ${productModels[index].price} THB',
                    textStyle: MyContant().h3StyleD(),
                  ),
                  ShowTitle(
                    title: productModels[index].detail,
                    textStyle: MyContant().h3StyleL(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 32,
                          color: MyContant.primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print('ທ່ານກົດປູ່ມລົບຈຳນວນ = $index ຄັ້ງ');
                          confirmDialogDelete(productModels[index]);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          size: 32,
                          color: MyContant.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> confirmDialogDelete(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: CachedNetworkImage(
            imageUrl: createUrl(productModel.images),
            placeholder: (context, url) => ShowProgess(),
          ),
          title: ShowTitle(
            title: 'ທ່ານຕ້ອງການລົບ ${productModel.name}ແທ້ບໍ່?',
            textStyle: MyContant().h2StyleD(),
          ),
          subtitle: ShowTitle(
            title: productModel.detail,
            textStyle: MyContant().h3StyleL(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              print('#### Confirm Delete at id ==>> ${productModel.id}');
              String apiDeleteProducWhereId =
                  '${MyContant.domain}/bloggerr/deleteProductWhereid.php?isAdd=true&id=${productModel.id}';
              await Dio().get(apiDeleteProducWhereId).then(
                (value) {
                  Navigator.pop(context);
                  loadValueFromAPI();
                },
              );
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancle'),
          ),
        ],
      ),
    );
  }
}
