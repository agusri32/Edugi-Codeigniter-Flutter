import 'package:flutter/material.dart';
import 'package:datauser/Home1/User.dart';
import 'package:datauser/Home1/UserData.dart';
import 'package:datauser/Home1/UserServices.dart';

class DataForm extends StatefulWidget {
  TextEditingController namaController, nikController;
  DataForm(this.namaController, this.nikController) : super();

  final String title = "EDIT DATA";

  @override
  DataTabelState createState() => DataTabelState(namaController, nikController);
}

class DataTabelState extends State<DataForm> {
  List<User> _users;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaController;
  TextEditingController _nikController;
  User _selectedUser;
  String _titleProgress;

  TextEditingController namaController, nikController;
  DataTabelState(this.namaController, this.nikController);

  @override
  void initState() {
    super.initState();
    _users = [];
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

  _updateUser(User user) {
    _showProgress('Perbarui Data...');
    UserServices.updateUser(user.user_id, _namaController.text, _nikController.text).then((result) {
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
                controller: namaController,
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
                controller: nikController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  ),
                  labelText: "Kode Member",
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
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    child: Text('UPDATE'),
                    onPressed: () {
                      _updateUser(_selectedUser);
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
