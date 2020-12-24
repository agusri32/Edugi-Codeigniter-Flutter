import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:datauser/Home2/EditData.dart';
import 'package:datauser/Home2/ShowData.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    var url="http://10.0.2.2:88/web_restapi/api2/deleteData.php";

    http.post(url, body: {
      'user_id': widget.list[widget.index]['user_id']
    });
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      //content: new Text("Yakin ingin menghapus data '${widget.list[widget.index]['user_nama']}' ?"),
      content: new Text("Apakah Anda yakin akan menghapus data ini?"),
      actions: <Widget>[

        new RaisedButton(
          child: new Text("YES"),
          color: Colors.blue,
          onPressed: (){
            deleteData();
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new DataView()
              )
            );
          },
        ),

        new RaisedButton(
          child: new Text("CANCEL"),
          color: Colors.red,
          onPressed: ()=>Navigator.pop(context),
        ),

      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        title: new Text("DETAIL DATA"),
        backgroundColor: Colors.green,
      ),

      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(widget.list[widget.index]['user_nama'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                ),
                new Text("Kode Member : ${widget.list[widget.index]['user_nik']}",
                  style: new TextStyle(fontSize: 18.0,color:Colors.grey),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        child: Text('EDIT'),
                        onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                            //pindah ke halalaman edit data
                            builder: (BuildContext context) => new EditData(
                              list: widget.list,
                              index: widget.index,
                            )
                          ),
                        ),
                      ),
                    ),

                    /*
                    new RaisedButton(
                      child: new Text("EDIT"),
                      color: Colors.blue,
                      onPressed: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                          //pindah ke halalaman edit data
                          builder: (BuildContext context) => new EditData(
                              list: widget.list,
                              index: widget.index,
                          )
                        ),
                      ),
                    ),
                    */

                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                        ),
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        child: Text('DELETE'),
                        onPressed: () => confirm(),
                      ),
                    ),

                    /*
                    new RaisedButton(
                      child: new Text("DELETE"),
                      color: Colors.red,
                      onPressed: () => confirm(),
                    ),
                     */

                  ],
                ),

              ],
            ),
          ),
        ),

      ),
    );

  }
}
