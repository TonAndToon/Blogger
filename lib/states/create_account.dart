import 'package:blogger/utility/my_contant.dart';
import 'package:blogger/widgets/show_title.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Name:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.fingerprint,
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
        ),
      ],
    );
  }

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,margin: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Address:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.home,
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
        ),
      ],
    );
  }

  Row buildPhonenumber(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Phonenumber:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.phone,
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
        ),
      ],
    );
  }

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.63,margin: EdgeInsets.symmetric(vertical: 15),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email:',
              labelStyle: MyContant().h3StyleP(),
              prefixIcon: Icon(
                Icons.mail,
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyContant.primaryColor,
        title: Text(
          'Create account',
          style: TextStyle(color: MyContant.whColor),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          buildTitle('Information :'),
          buildName(size),
          buildTitle('Type User :'),
          buildRadioBuyer(size),
          buildRadioSeller(size),
          buildRadioRider(size),
          buildTitle('Basic information :'),
          buildAddress(size),
          buildPhonenumber(size),
          buildEmail(size),
        ],
      ),
    );
  }

  Row buildRadioBuyer(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size*0.63,
          child: RadioListTile(
                value: 'buyer',
                groupValue: typeUser,
                onChanged: (value) {
                  setState(() {
                    typeUser = value as String;
                  });
                },
                title: ShowTitle(
                  title: '(Buyyer)',
                  textStyle: MyContant().h3StyleP(),
                ),
              ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size*0.63,
          child: RadioListTile(
                value: 'seller',
                groupValue: typeUser,
                onChanged: (value) {setState(() {
                    typeUser = value as String;
                  });},
                title: ShowTitle(
                  title: '(Seller)',
                  textStyle: MyContant().h3StyleP(),
                ),
              ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size*0.63,
          child: RadioListTile(
                value: 'rider',
                groupValue: typeUser,
                onChanged: (value) {setState(() {
                    typeUser = value as String;
                  });},
                title: ShowTitle(
                  title: '(Rider)',
                  textStyle: MyContant().h3StyleP(),
                ),
              ),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ShowTitle(
        title: title,
        textStyle: MyContant().h2StyleP(),
      ),
    );
  }
}
