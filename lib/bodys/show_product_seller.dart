import 'package:blogger/states/add_product.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:flutter/material.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({super.key});

  @override
  State<ShowProductSeller> createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is show Product'),
      floatingActionButton: FloatingActionButton(backgroundColor: MyContant.primaryColor,foregroundColor: MyContant.whColor,
        onPressed: () => Navigator.pushNamed(
          context,
          MyContant.rounteAddProduct,
        ),
        child: Text('Add'),
      ),
    );
  }
}
