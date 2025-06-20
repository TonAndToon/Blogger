import 'dart:io';

import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_image.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  List<File?> files = [];
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyContant.whColor,
        title: Text('Add product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildProductName(constraints),
                    buildProductPirce(constraints),
                    buildProductDetail(constraints),
                    buildImage(constraints),
                    addProductButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row addProductButton(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Container(
            width: constraints.maxWidth * 0.95,
            height: constraints.maxWidth * 0.15,
            child: ElevatedButton(
              style: MyContant().myButtonStyle(),
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              child: Text(
                'Add product',
                style: MyContant().h2StyleWh(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
        files[index] = file;

      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print('Click from index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyContant.img1),
          title: ShowTitle(
            title: 'Source Image ${index + 1} ?',
            textStyle: MyContant().h2StyleP(),
          ),
          subtitle: ShowTitle(
            title: 'Please Tab on Camara or Gallery',
            textStyle: MyContant().h3StyleP(),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.camera, index);
                },
                child: Text('Camara'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.69,
          height: constraints.maxWidth * 0.69,
          child: file == null ? Image.asset(MyContant.iconphotolb) : Image.file(file!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 42,
              height: 42,
              child: InkWell(
                onTap: () => chooseSourceImageDialog(0),
                child: Image.asset(
                  MyContant.iconphotolb,
                ),
              ),
            ),
            Container(
              width: 42,
              height: 42,
              child: InkWell(
                onTap: () => chooseSourceImageDialog(1),
                child: Image.asset(
                  MyContant.iconphotolb,
                ),
              ),
            ),
            Container(
              width: 42,
              height: 42,
              child: InkWell(
                onTap: () => chooseSourceImageDialog(2),
                child: Image.asset(
                  MyContant.iconphotolb,
                ),
              ),
            ),
            Container(
              width: 42,
              height: 42,
              child: InkWell(
                onTap: () => chooseSourceImageDialog(3),
                child: Image.asset(
                  MyContant.iconphotolb,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.95,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill name Blank';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Name product:',
          labelStyle: MyContant().h3StyleP(),
          prefixIcon: Icon(
            Icons.production_quantity_limits_sharp,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyContant.redColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductPirce(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.95,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill price Blank';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Price product:',
          labelStyle: MyContant().h3StyleP(),
          prefixIcon: Icon(
            Icons.price_change_outlined,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyContant.redColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.95,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Fill product Blank';
          } else {
            return null;
          }
        },
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Detail product:',
          hintStyle: MyContant().h3StyleP(),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 78),
            child: Icon(
              Icons.library_books_outlined,
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: MyContant.redColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
