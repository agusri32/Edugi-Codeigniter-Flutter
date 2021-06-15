import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:datauser/Home2/ShowData.dart';

class EditData extends StatefulWidget {

  final List list;
  final int index;

  EditData({this.list,this.index});

  @override
  _EditDataState createState() => _EditDataState();

}

class _EditDataState extends State<EditData> {

  TextEditingController controllerCode;
  TextEditingController controllerName;

  void editData(){
    var url="https://restapi32.000webhostapp.com/web_login/api2/editdata.php";

    http.post(url,body: {
      "user_id": widget.list[widget.index]['user_id'],
      "user_nik": controllerCode.text,
      "user_nama": controllerName.text,
    });
  }

  @override
  void initState(){
    controllerCode = new TextEditingController(text: widget.list[widget.index]['user_nik']);
    controllerName = new TextEditingController(text: widget.list[widget.index]['user_nama']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("EDIT DATA"),
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
                    child: Text('UPDATE'),
                    onPressed: () {
                      editData();
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
                  child: new Text("UPDATE"),
                  color: Colors.blue,
                  onPressed: () {
                    editData();
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