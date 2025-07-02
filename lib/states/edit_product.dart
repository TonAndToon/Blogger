import 'dart:io';

import 'package:blogger/models/product_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  const EditProduct({super.key, required this.productModel});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ProductModel? productModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  List<String> pathImages = [];
  List<File?> files = [];

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productModel = widget.productModel;
    //print('#### image from mySQL ==>> ${productModel!.images}');
    convertStringToArray();
    nameController.text = productModel!.name;
    priceController.text = productModel!.price;
    detailController.text = productModel!.detail;
  }

  void convertStringToArray() {
    String string = productModel!.images;
    //print('#### Ofer Cut string ==>> $string');
    string = string.substring(1, string.length - 1);
    //print('#### Befor Cut string ==>> $string');
    List<String> strings = string.split(',');
    for (var item in strings) {
      pathImages.add(
        item.trim(),
      );
      files.add(null);
    }
    print('#### pathImages ==>> $pathImages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyContant.primaryColor,
        foregroundColor: MyContant.whColor,
        title: Text('ແກ້ໄຂສີນຄ້າ'),
        actions: [
          IconButton(
            onPressed: () => processEdit(),
            icon: Icon(Icons.edit),
            tooltip: 'ແກ້ໄຂສີນຄ້າ',
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(
                FocusNode(),
              ),
              behavior: HitTestBehavior.opaque,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle('ຂໍ້ມູນສີນຄ້າ:'),
                    buildName(constraints),
                    buildPrice(constraints),
                    buildDetail(constraints),
                    buildTitle('ຮູບສີນຄ້າ:'),
                    buildImage(constraints, 0),
                    buildImage(constraints, 1),
                    buildImage(constraints, 2),
                    buildImage(constraints, 3),
                    buildEditProduct(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildEditProduct(BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: constraints.maxWidth,
      child: ElevatedButton.icon(
        onPressed: () => processEdit(),
        label: Text('ແກ້ໄຂສີນຄ້າ'),
        icon: Icon(Icons.edit),
      ),
    );
  }

  Future<Null> chooseImage(int index, ImageSource source) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        files[index] = File(result!.path);
      });
    } catch (e) {}
  }

  Container buildImage(BoxConstraints constraints, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: MyContant.primaryColor),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => chooseImage(index, ImageSource.camera),
            icon: Icon(
              Icons.add_a_photo,
              color: MyContant.primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: constraints.maxWidth * 0.4,
            child: files[index] == null
                ? CachedNetworkImage(
                    imageUrl:
                        '${MyContant.domain}/bloggerr/${pathImages[index]}',
                    placeholder: (context, url) => ShowProgess(),
                  )
                : Image.file(files[index]!),
          ),
          IconButton(
            onPressed: () => chooseImage(index, ImageSource.gallery),
            icon: Icon(
              Icons.add_photo_alternate,
              color: MyContant.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Row buildName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.78,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'ກະລຸນາປ້ອນຊື່ສີນຄ້າ';
              } else {
                return null;
              }
            },
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'ຊື່ສີນຄ້າ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPrice(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: constraints.maxWidth * 0.78,
          child: TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'ກະລຸນາປ້ອນລາຄາສີນຄ້າ';
              } else {
                return null;
              }
            },
            controller: priceController,
            decoration: InputDecoration(
              labelText: 'ລາຄາ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildDetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.78,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'ກະລຸນາປ້ອນລາຍລະອຽດສີນຄ້າ';
              } else {
                return null;
              }
            },
            controller: detailController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'ລາຍລະອຽດ',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitle(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: ShowTitle(
            title: title,
            textStyle: MyContant().h2StyleP(),
          ),
        ),
      ],
    );
  }

  processEdit() {
    if (formKey.currentState!.validate()) {
      String name = nameController.text;
      String price = priceController.text;
      String detail = detailController.text;
      print('#### name = $name, price = $price, detail = $detail');
    }
  }
}
