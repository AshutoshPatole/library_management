import 'package:flutter/material.dart';
import 'package:library_managment_system/Screens/barcode_home.dart';
import 'package:library_managment_system/Screens/login_screen.dart';
import 'package:library_managment_system/service/bar_result.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:library_managment_system/service/login_service.dart';
import 'package:provider/provider.dart';

void main() => {runApp(MyApp())};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BarCodeResultService()),
        ChangeNotifierProvider(
          create: (context) => Books(),
        ),
        ChangeNotifierProvider(create: (context) => LoginService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
