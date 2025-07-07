import 'dart:io';
import 'dart:math';

import 'package:blogger/models/product_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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
  bool statusImage = false; //false => not change image

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
        title: Text('ແກ້ໄຂສີນຄ້າ',style: TextStyle(fontFamily: 'NotoSansLao'),),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      width: constraints.maxWidth * 0.9,
      height: constraints.maxWidth * 0.15,
      child: ElevatedButton.icon(
        style: MyContant().myButtonStyle(),
        onPressed: () => processEdit(),
        label: Text(
          'ແກ້ໄຂສີນຄ້າ',
          style: TextStyle(color: MyContant.whColor, fontSize: 18,fontFamily: 'NotoSansLao'),
        ),
        icon: Icon(
          Icons.edit,
          color: MyContant.whColor,
        ),
      ),
    );
  }

  Future<Null> chooseImage(int index, ImageSource source) async {
    try {
      var result = await ImagePicker()
          .pickImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        files[index] = File(result!.path);
        statusImage = true;
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
          child: TextFormField(style: TextStyle(fontFamily: 'NotoSansLao'),
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
              labelStyle: MyContant().h3StyleP(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
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
                  width: 2,
                ),
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
          child: TextFormField(style: TextStyle(fontFamily: 'NotoSansLao'),
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
              labelStyle: MyContant().h3StyleP(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
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
                  width: 2,
                ),
              ),
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
          child: TextFormField(style: TextStyle(fontFamily: 'NotoSansLao'),
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
              labelStyle: MyContant().h3StyleP(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
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
                  width: 2,
                ),
              ),
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

  Future processEdit() async {
    if (formKey.currentState!.validate()) {
      String name = nameController.text;
      String price = priceController.text;
      String detail = detailController.text;
      String id = productModel!.id;
      String images;

      if (statusImage) {
        //upload image and refresh array pathImages
        int index = 0;
        for (var item in files) {
          if (item != null) {
            int i = Random().nextInt(100000);
            String nameImage = 'productEdit$i.jpg';
            String apiUploadImage =
                '${MyContant.domain}/bloggerr/saveProduct.php';

            Map<String, dynamic> map = {};
            map['file'] =
                await MultipartFile.fromFile(item.path, filename: nameImage);
            FormData formData = FormData.fromMap(map);
            await Dio().post(apiUploadImage, data: formData).then((value) {
              pathImages[index] = '/product/$nameImage';
            });
          }
          index++;
        }

        images = pathImages.toString();
        Navigator.pop(context);
      } else {
        images = pathImages.toString();
        Navigator.pop(context);
      }

      print('#### statusImage = $statusImage');
      print('#### id = $id, name = $name, price = $price, detail = $detail');
      print('#### images = $images');

      String apiEditProduct =
          '${MyContant.domain}/bloggerr/editProductWhereid.php?isAdd=true&id=$id&name=$name&price=$price&detail=$detail&images=$images';
      await Dio().get(apiEditProduct).then((value) {
        if (mounted) {
    Navigator.pop(context);
  }
      });
    }
  }
}
