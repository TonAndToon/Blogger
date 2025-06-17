import 'package:blogger/states/authen.dart';
import 'package:blogger/states/buyer_service.dart';
import 'package:blogger/states/create_account.dart';
import 'package:blogger/states/rider_service.dart';
import 'package:blogger/states/saler_service.dart';
import 'package:blogger/utility/my_contant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/salerService': (BuildContext context) => SalerService(),
  '/riderService': (BuildContext context) => RiderService(),
};

String? initalRounte;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('#### type ==>> $type');
  if (type?.isEmpty ?? true) {
    initalRounte = MyContant.rounteAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'buyer':
        initalRounte = MyContant.rounteBuyerService;
        runApp(MyApp());
        break;
      case 'seller':
        initalRounte = MyContant.rounteSalerService;
        runApp(MyApp());
        break;
      case 'rider':
        initalRounte = MyContant.rounteRiderService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyContant.appName,
      routes: map,
      initialRoute: initalRounte,
    );
  }
}
