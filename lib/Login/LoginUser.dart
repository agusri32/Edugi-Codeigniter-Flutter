import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datauser/Home2/ShowData.dart';

class LoginUser extends StatefulWidget{
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State{
  bool visible = true;
  bool _secureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  showHide(){
    setState(() {
      _secureText = !_secureText;
    });
  }

  Future userLogin() async{

    setState(() {
      visible = true ;
    });

    String email = emailController.text;
    String password = passwordController.text;

    var url = 'http://10.0.2.2:88/web_restapi/api1/login.php';
    var data = {'email': email, 'password' : password};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if(message == 'Berhasil Login' && email != '' && password != '')
    {

      setState(() {
        visible = false;
      });

      //saat berhasil login
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DataView())
      );

    }else{

      setState(() {
        visible = false;
      });

      //notifikasi saat gagal login
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          body: Container(decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [const Color(0xFFCA436B),const Color(0xFFCA436B)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp),),
            child: Center(
              child: SafeArea(
                top: true,
                bottom: true,
                left: true,
                right: true,
                minimum: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                    child: Center(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            new Container(
                              child: new Image.asset(
                                "assets/login.png",
                                height: 150.0,
                                width: 200.0,
                              ),
                            ),

                            Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text('LOGIN ADMIN',
                                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white)
                                )
                            ),

                            Divider(),

                            Container(
                                width: 280,
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  cursorColor: Colors.white,
                                  controller: emailController,
                                  autocorrect: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white,
                                              width: 2.0)
                                      ),

                                      icon: Icon(Icons.email, color: Colors.white,), labelText:'Email', labelStyle: TextStyle(color: Colors.white)
                                  ),
                                )
                            ),

                            Container(
                                width: 280,
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: passwordController,
                                  autocorrect: true,
                                  obscureText: _secureText,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white,
                                              width: 2.0)
                                      ),
                                    icon: Icon(Icons.vpn_key, color: Colors.white,), labelText:'Password',
                                      suffixIcon: IconButton(
                                        onPressed: showHide,
                                        icon: Icon(_secureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                      ),
                                      labelStyle: TextStyle(color: Colors.white)

                                  ),
                                )
                            ),

                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)
                              ),
                              onPressed: userLogin,
                              color: Colors.blue,
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                              child: Text('Masuk'),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ))
    );
  }
}