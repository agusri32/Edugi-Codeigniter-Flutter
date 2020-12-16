class Pasien {
  String id;
  String identitas;
  String status;

  Pasien({this.id, this.identitas, this.status});

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      id: json['id'] as String,
      identitas: json['identitas'] as String,
      status: json['status'] as String,
    );
  }
}
