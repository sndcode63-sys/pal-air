import 'package:airo_tech/Utils/remote_urls.dart';

class TechnicianModel {
  final String? id;
  final String? fullName;
  final String? fatherName;
  final String? email;
  final String? password;
  final String? phone;
  final DateTime? dob;
  final String? degignation;
  final String? salary;
  final String? image;
  final String? address;
  final String? isEnable;
  final DateTime? createdAt;
  final String? createdBy;

  TechnicianModel({
    this.id,
    this.fullName,
    this.fatherName,
    this.email,
    this.password,
    this.phone,
    this.dob,
    this.degignation,
    this.salary,
    this.image,
    this.address,
    this.isEnable,
    this.createdAt,
    this.createdBy,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    String image = json["image"].toString(), profileUrl = "";

    if (image.isEmpty || image == "null") {
      profileUrl = "";
    } else {
      profileUrl = "${RemoteUrls.imageUrl}/$image";
    }
    return TechnicianModel(
      id: json["id"],
      fullName: json["full_name"],
      fatherName: json["father_name"],
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
      degignation: json["degignation"],
      salary: json["salary"],
      image: profileUrl,
      address: json["address"],
      isEnable: json["isEnable"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      createdBy: json["created_by"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "father_name": fatherName,
        "email": email,
        "password": password,
        "phone": phone,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "degignation": degignation,
        "salary": salary,
        "image": image,
        "address": address,
        "isEnable": isEnable,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
      };
}

class TechnicianListModel {
  final String? id;
  final String? techName;

  TechnicianListModel({this.id, this.techName});

  factory TechnicianListModel.fromJson(Map<String, dynamic> json) =>
      TechnicianListModel(id: json["id"], techName: json["full_name"]);
}

class EmployeeAttendanceModel {
  final String? id;
  final String? empId;
  final String? checkInTime;
  final String? checkInDate;
  final String? checkOutTime;
  final String? checkOutDate;
  final String? createdAt;
  final String? createdBy;

  EmployeeAttendanceModel({
    this.id,
    this.empId,
    this.checkInTime,
    this.checkInDate,
    this.checkOutTime,
    this.checkOutDate,
    this.createdAt,
    this.createdBy,
  });

  factory EmployeeAttendanceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAttendanceModel(
        id: json["id"],
        empId: json["empId"],
        checkInTime: json["checkInTime"],
        checkInDate: json["checkInDate"],
        checkOutTime: json["checkOutTime"],
        checkOutDate: json["checkOutDate"],
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "empId": empId,
        "checkInTime": checkInTime,
        "checkInDate": checkInDate,
        "checkOutTime": checkOutTime,
        "checkOutDate": checkOutDate,
        "createdAt": createdAt,
        "createdBy": createdBy,
      };
}
