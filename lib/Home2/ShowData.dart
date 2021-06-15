import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:datauser/Home2/DetailData.dart';
import 'package:datauser/Home2/AddData.dart';
import 'package:datauser/Login/LoginUser.dart';

class DataView extends StatefulWidget {
  DataView() : super();

  @override
  DataViewState createState() => DataViewState();
}

class DataViewState extends State<DataView> {
  Future<List> getData() async {
    final response = await http.get(
        "https://restapi32.000webhostapp.com/web_login/api2/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("VIEW DATA"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new DataView()));
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginUser()));
            },
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddData(),
        )),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
                child: new ListTile(
              title: new Text(list[i]['user_nama']),
              subtitle: new Text("Kode Member : ${list[i]['user_nik']}"),
            )),
          ),
        );
      },
    );
  }
}
