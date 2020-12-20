import 'package:flutter/material.dart';
import 'package:datauser/widgets/Login/LoginUser.dart';
import 'package:datauser/widgets/DataTabel/User.dart';
import 'package:datauser/widgets/DataTabel/UserServices.dart';

class DataTabel extends StatefulWidget {
  DataTabel() : super();

  final String title = "Pendataan User";

  @override
  DataTabelState createState() => DataTabelState();
}

class DataTabelState extends State<DataTabel> {
  List<User> _users;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _namaController;
  TextEditingController _nikController;
  User _selectedUser;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _namaController = TextEditingController();
    _nikController = TextEditingController();
    _getUsers();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _getUsers() {
    _showProgress('Loading Data...');
    UserServices.getUsers().then((users) {
      setState(() {
        _users = users;
      });
      _showProgress(widget.title);
      print("Length: ${users.length}");
    });
  }

  _addUser() {
    if (_namaController.text.trim().isEmpty || _nikController.text.trim().isEmpty) {
      print("Kolom Kosong");
      return;
    }
    _showProgress('Menambahkan Data...');
    UserServices.addUser(_namaController.text, _nikController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers();
      }
      _clearValues();
    });
  }

  _updateUser(User user) {
    _showProgress('Perbarui Data...');
    UserServices.updateUser(
        user.user_id, _namaController.text, _nikController.text)
        .then((result) {
      if ('success' == result) {
        _getUsers();
        setState(() {
          _isUpdating = false;
        });
        _namaController.text = '';
        _nikController.text = '';
      }
    });
  }

  _deleteUser(User user) {
    _showProgress('Hapus Data...');
    UserServices.deleteUser(user.user_id).then((result) {
      if ('success' == result) {
        AlertDialog alert = AlertDialog(
          content: Text("Data Berhasil Dihapus"),);
        setState(() {
          _users.remove(user);
        });
        _getUsers();
      }
    });
  }

  _setValues(User user) {
    _namaController.text = user.user_nama;
    _nikController.text = user.user_nik;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _namaController.text = '';
    _nikController.text = '';
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text("ID"),
                  numeric: false),
              DataColumn(
                  label: Text("NAMA LENGKAP"),
                  numeric: false),
              DataColumn(
                  label: Text("NOMOR NIK"),
                  numeric: false),
              DataColumn(
                  label: Text("OPTION"),
                  numeric: false),
            ],
            rows: _users
                .map(
                  (user) => DataRow(
                cells: [

                  DataCell(
                    Text(user.user_id),
                    onTap: () {
                      print("Tapped " + user.user_nama);
                      _setValues(user);
                      _selectedUser = user;
                    },
                  ),

                  DataCell(
                    Text(
                      user.user_nama.toUpperCase(),
                    ),
                    onTap: () {
                      print("Tapped " + user.user_nama);
                      _setValues(user);
                      _selectedUser = user;
                    },
                  ),

                  DataCell(
                    Text(
                      user.user_nik.toUpperCase(),
                    ),
                    onTap: () {
                      print("Tapped " + user.user_nama);
                      _setValues(user);
                      _selectedUser = user;
                    },
                  ),

                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteUser(user);
                      },
                    ),
                    onTap: () {
                      print("Tapped " + user.user_nama);
                    },
                  ),

                ],
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
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
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getUsers();
            },
          ),
        ],
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

            Container(
              width: 350,
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton(
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  textColor: Colors.white,
                  child: Text("Log Out"),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginUser())
                    );
                  },
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: Center(
                child: Text(
                  'DATA USER',
                  style: new TextStyle(
                    //decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double,
                    fontSize: 30.0,
                    color: Colors.deepPurpleAccent
                  ),
                ),
              ),
            ),
            _isUpdating
                ? Row(
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
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                  ),
                ),

              ],
            )
                : Container(),
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          _addUser();
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
