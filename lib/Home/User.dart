class User {
  String user_id;
  String user_nik;
  String user_nama;

  User({this.user_id, this.user_nama, this.user_nik});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json['user_id'] as String,
      user_nik: json['user_nik'] as String,
      user_nama: json['user_nama'] as String,
    );
  }
}
