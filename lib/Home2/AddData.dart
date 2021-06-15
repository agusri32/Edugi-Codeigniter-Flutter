import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:datauser/Home2/ShowData.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  TextEditingController controllerCode = new TextEditingController();
  TextEditingController controllerName = new TextEditingController();

  void addData(){
    var url="https://restapi32.000webhostapp.com/web_login/api2/adddata.php";

    http.post(url, body: {
      "user_nik": controllerCode.text,
      "user_nama": controllerName.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("ADD DATA"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[

            new Column(
              children: <Widget>[

                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      labelText: "Kode Member"),
                ),

                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      labelText: "Nama Lengkap"),
                ),

                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),

                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text('SAVE'),
                    onPressed: () {
                      addData();
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=> new DataView()
                          )
                      );
                    },
                  ),
                ),

                /*
                new RaisedButton(
                  child: new Text("SAVE"),
                  color: Colors.blue,
                  onPressed: () {
                    addData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=> new DataView()
                      )
                    );
                  },
                )
                 */

              ],
            ),

          ],
        ),

      ),
    );

  }
}
