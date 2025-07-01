import 'package:blogger/models/product_model.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_progess.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle('ຂໍ້ມູນສີນຄ້າ:'),
              buildName(constraints),
              buildPrice(constraints),
              buildDetail(constraints),
              buildTitle('ຮູບສີນຄ້າ:'),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_a_photo,
                      color: MyContant.primaryColor,
                    ),
                  ),
                  Container(width: constraints.maxWidth*0.4,
                    child: CachedNetworkImage(
                      imageUrl: '${MyContant.domain}/bloggerr/${pathImages[0]}',
                      placeholder: (context, url) => ShowProgess(),
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
            ],
          ),
        ),
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
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'ຊື່ສີນຄ້າ',
              border: OutlineInputBorder(),
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
}
