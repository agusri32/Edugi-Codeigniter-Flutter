class User {
  String id;
  String identitas;
  String status;

  User({this.id, this.identitas, this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      identitas: json['identitas'] as String,
      status: json['status'] as String,
    );
  }
}
