import 'package:flutter/material.dart';
import 'package:pasien/widgets/Login/LoginUser.dart';
import 'package:pasien/widgets/DataTabel/User.dart';
import 'package:pasien/widgets/DataTabel/UserServices.dart';

class DataTabelDemo extends StatefulWidget {
  DataTabelDemo() : super();

  final String title = "Pendataan User";

  @override
  DataTabelDemoState createState() => DataTabelDemoState();
}

class DataTabelDemoState extends State<DataTabelDemo> {
  List<User> _pasiens;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _identitasController;
  TextEditingController _statusController;
  User _selectedPasien;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    super.initState();
    _pasiens = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _identitasController = TextEditingController();
    _statusController = TextEditingController();
    _getPasiens();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _createTable() {
    _showProgress('Perbarui Tabel...');
    PasienServices.createTable().then((result) {
      if ('success' == result) {
        showSnackBar(context, result);
        _getPasiens();
      }
    });
  }

  _addPasien() {
    if (_identitasController.text.trim().isEmpty ||
        _statusController.text.trim().isEmpty) {
      print("Kolom Kosong");
      return;
    }
    _showProgress('Menambahkan Data...');
    PasienServices.addPasien(_identitasController.text, _statusController.text)
        .then((result) {
      if ('success' == result) {
        _getPasiens();
      }
      _clearValues();
    });
  }

  _getPasiens() {
    _showProgress('Loading Data...');
    PasienServices.getPasiens().then((pasiens) {
      setState(() {
        _pasiens = pasiens;
      });
      _showProgress(widget.title);
      print("Length: ${pasiens.length}");
    });
  }

  _deletePasien(User user) {
    _showProgress('Hapus Data...');
    PasienServices.deletePasien(user.id).then((result) {
      if ('success' == result) {
        AlertDialog alert = AlertDialog(
            content: Text("Data Berhasil Dihapus"),);
        setState(() {
          _pasiens.remove(user);
        });
        _getPasiens();
      }
    });
  }

  _updatePasien(User user) {
    _showProgress('Perbarui Data...');
    PasienServices.updatePasien(
        user.id, _identitasController.text, _statusController.text)
        .then((result) {
      if ('success' == result) {
        _getPasiens();
        setState(() {
          _isUpdating = false;
        });
        _identitasController.text = '';
        _statusController.text = '';
      }
    });
  }

  _setValues(User user) {
    _identitasController.text = user.identitas;
    _statusController.text = user.status;
    setState(() {
      _isUpdating = true;
    });
  }

  _clearValues() {
    _identitasController.text = '';
    _statusController.text = '';
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(
            color: Colors.grey,
            width: 1.0
        ),
    );
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: myBoxDecoration(),
          padding: const EdgeInsets.all(10.0),
          child: DataTable(
            columns: [
              DataColumn(
                  label: Text("ID"),
                  numeric: false,
                  tooltip: "This is the employee id"),
              DataColumn(
                  label: Text(
                    "Identitas",
                  ),
                  numeric: false,
                  tooltip: "Ini Kolom Identitas"),
              DataColumn(
                  label: Text("Status"),
                  numeric: false,
                  tooltip: "Ini Kolom Status"),
              DataColumn(
                  label: Text("DELETE"),
                  numeric: false,
                  tooltip: "Delete"),
            ],
            rows: _pasiens
                .map(
                  (pasien) => DataRow(
                cells: [
                  DataCell(
                    Text(pasien.id),
                    onTap: () {
                      print("Tapped " + pasien.identitas);
                      _setValues(pasien);
                      _selectedPasien = pasien;
                    },
                  ),
                  DataCell(
                    Text(
                      pasien.identitas.toUpperCase(),
                    ),
                    onTap: () {
                      print("Tapped " + pasien.identitas);
                      _setValues(pasien);
                      _selectedPasien = pasien;
                    },
                  ),
                  DataCell(
                    Text(
                      pasien.status.toUpperCase(),
                    ),
                    onTap: () {
                      print("Tapped " + pasien.identitas);
                      _setValues(pasien);
                      _selectedPasien = pasien;
                    },
                  ),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deletePasien(pasien);
                      },
                    ),
                    onTap: () {
                      print("Tapped " + pasien.identitas);
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

  showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
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
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getPasiens();
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
                controller: _identitasController,
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
                controller: _statusController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  ),
                  labelText: "Status Keluarga",
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
                      _updatePasien(_selectedPasien);
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
          _addPasien();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
