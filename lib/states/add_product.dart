import 'package:blogger/utility/my_contant.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
            child: Column(
              children: [
                buildProductName(constraints),
                buildProductPirce(constraints),
                buildProductDetail(constraints),
                Image.asset(MyContant.iconphotolb),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.78,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
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
        ),
      ),
    );
  }

  Widget buildProductPirce(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.78,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
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
        ),
      ),
    );
  }

  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.78,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
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
        ),
      ),
    );
  }
}
