class InstallationModel {
  final String? id;
  final String? piNo;
  final DateTime? date;
  final String? model;
  final String? clientName;
  final String? hp;
  final String? mobile;
  final String? dispatchLocation;
  final String? checkedPersonName;
  final String? supervisorSign;
  final String? remark;
  final String? createdAt;
  final String? assignTechnician;
  final String? installationPerson;
  final String? status;
  final String? date1;
  final String? date2;
  final String? date3;
  final String? date4;
  final String? date5;
  final String? date6;
  final String? date7;
  final String? date8;
  final String? date9;
  final String? date10;
  final String? date11;
  final String? date12;
  final String? createdBy;
  final String? fullName;

  InstallationModel({
    this.id,
    this.piNo,
    this.date,
    this.model,
    this.clientName,
    this.hp,
    this.mobile,
    this.dispatchLocation,
    this.checkedPersonName,
    this.supervisorSign,
    this.remark,
    this.createdAt,
    this.assignTechnician,
    this.installationPerson,
    this.status,
    this.date1,
    this.date2,
    this.date3,
    this.date4,
    this.date5,
    this.date6,
    this.date7,
    this.date8,
    this.date9,
    this.date10,
    this.date11,
    this.date12,
    this.createdBy,
    this.fullName,
  });

  factory InstallationModel.fromJson(Map<String, dynamic> json) =>
      InstallationModel(
        id: json["id"],
        piNo: json["pi_no"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        model: json["model"],
        clientName: json["client_name"],
        hp: json["hp"],
        mobile: json["mobile"],
        dispatchLocation: json["dispatch_location"],
        checkedPersonName: json["checked_person_name"],
        supervisorSign: json["supervisor_sign"],
        remark: json["remark"],
        createdAt: json["created_at"],
        assignTechnician: json["assign_technician"],
        installationPerson: json["installation_person"],
        status: json["status"],
        date1: json["date1"],
        date2: json["date2"],
        date3: json["date3"],
        date4: json["date4"],
        date5: json["date5"],
        date6: json["date6"],
        date7: json["date7"],
        date8: json["date8"],
        date9: json["date9"],
        date10: json["date10"],
        date11: json["date11"],
        date12: json["date12"],
        createdBy: json["created_by"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pi_no": piNo,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "model": model,
        "client_name": clientName,
        "hp": hp,
        "mobile": mobile,
        "dispatch_location": dispatchLocation,
        "checked_person_name": checkedPersonName,
        "supervisor_sign": supervisorSign,
        "remark": remark,
        "created_at": createdAt,
        "assign_technician": assignTechnician,
        "installation_person": installationPerson,
        "status": status,
        "date1": date1,
        "date2": date2,
        "date3": date3,
        "date4": date4,
        "date5": date5,
        "date6": date6,
        "date7": date7,
        "date8": date8,
        "date9": date9,
        "date10": date10,
        "date11": date11,
        "date12": date12,
        "created_by": createdBy,
        "full_name": fullName,
      };
}
