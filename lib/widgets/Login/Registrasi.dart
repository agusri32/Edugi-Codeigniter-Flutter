import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pasien/widgets/Login/LoginUser.dart';

class RegistrasiUser extends StatefulWidget{
  RegistrasiUserState createState() => RegistrasiUserState();
}

class RegistrasiUserState extends State{

  bool visible = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async{

    setState(() {
      visible = true ;
    });

    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    var url = 'http://10.0.2.2/web_login/registrasi.php';
    var data = {'name': name, 'email': email, 'password' : password};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('REGISTRASI',
                            style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)
                        )),
                    new Container(
                      child: new Image.asset(
                        "assets/user.png",
                        height: 150.0,
                        width: 200.0,
                      ),
                    ),

                    Container(
                        width: 280,
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: nameController,
                          autocorrect: true,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(const Radius.circular(12))
                              ),
                              icon: Icon(Icons.perm_identity),
                              hintText: 'Masukan Nama'),
                        ),
                    ),

                    Container(
                        width: 280,
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: emailController,
                          autocorrect: true,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(const Radius.circular(12))
                              ), icon: Icon(Icons.mail),
                              hintText: 'Masukan Email'),
                        )
                    ),

                    Container(
                        width: 280,
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: passwordController,
                          autocorrect: true,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(const Radius.circular(12))
                              ), icon: Icon(Icons.vpn_key),
                              hintText: 'Masukan Password'),
                        )
                    ),

                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                      ),
                      onPressed: userRegistration,
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text('Daftar'),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)
                      ),
                      color: Colors.purpleAccent,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text('Cancel'),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUser())
                        );
                      },
                    ),

                    Visibility(
                        visible: visible,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: CircularProgressIndicator()
                        )
                    ),

                  ],
                ),
              )),
        ));
  }

}