import 'package:flutter/material.dart';
import 'package:pasien/widgets/DataTabel/PasienData.dart';
import 'package:pasien/widgets/Login/LoginUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        brightness: Brightness.light,
      ),
     darkTheme: ThemeData(
       brightness: Brightness.dark,
     ),
     debugShowCheckedModeBanner: false,
      home: LoginUser(),
    );
  }
}
