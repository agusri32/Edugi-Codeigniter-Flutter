class User {
  String id;
  String nama;
  String nik;

  User({this.id, this.nama, this.nik});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      nama: json['nama'] as String,
      nik: json['nik'] as String,
    );
  }
}
