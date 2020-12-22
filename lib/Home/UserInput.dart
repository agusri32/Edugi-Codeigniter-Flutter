import 'package:flutter/material.dart';
import 'package:datauser/Home/UserData.dart';
import 'package:datauser/Home/UserServices.dart';

class DataInput extends StatefulWidget {
  DataInput() : super();

  final String title = "Input Data User";

  @override
  DataTabelState createState() => DataTabelState();
}

class DataTabelState extends State<DataInput> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaController;
  TextEditingController _nikController;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaController = TextEditingController();
    _nikController = TextEditingController();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _addUser() {
    if (_namaController.text.trim().isEmpty || _nikController.text.trim().isEmpty) {
      //ganti dengan warning dialog
      print("Kolom Kosong");
      return;
    }
    _showProgress('Menambahkan Data...');
    UserServices.addUser(_namaController.text, _nikController.text).then((result) {
      if ('success' == result) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataTabel())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        title: Text(_titleProgress),
        actions: <Widget>[
        ],
      ),

      body: Container(
        child: Column(
          children: <Widget>[

            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: Colors.blueAccent,
                controller: _namaController,
                style: TextStyle(color: Colors.blueAccent),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  ),
                  labelText: "Nama Lengkap",
                  labelStyle: TextStyle(color: Colors.blueAccent)
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: Colors.blueAccent,
                style: TextStyle(color: Colors.blueAccent),
                controller: _nikController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  ),
                  labelText: "Nomor NIK",
                  labelStyle: TextStyle(color: Colors.blueAccent)
                ),
              ),
            ),

            //untuk tombol form
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                    ),
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    child: Text('SAVE'),
                    onPressed: () {
                      _addUser();
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all((15.0)),
                  child: FlatButton(
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)
                    ),
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DataTabel())
                      );
                    },
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
