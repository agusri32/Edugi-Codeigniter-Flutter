import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:datauser/Home2/DetailData.dart';
import 'package:datauser/Home2/AddData.dart';

class DataView extends StatefulWidget {
  DataView() : super();

  final String title = "View Data User";

  @override
  DataViewState createState() => DataViewState();
}

class DataViewState extends State<DataView> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2:88/web_crud/getdata.php");
    //final response = await http.get("https://api.yourdomain.com/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MY STORE"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context)=> new AddData(),
          )
        ),
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
              title: new Text(list[i]['item_name']),
              leading: new Icon(Icons.widgets),
              subtitle: new Text("Stock : ${list[i]['stock']}"),
            )),
          ),
        );
      },
    );
  }
}
