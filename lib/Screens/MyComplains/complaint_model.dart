class ComplaintModel {
  final String? id;
  final DateTime? date;
  final String? machineType;
  final String? compressorMake;
  final String? compressorHp;
  final String? companyName;
  final String? address;
  final String? city;
  final String? contact;
  final String? email;
  final String? contactPerson;
  final String? productDescription;
  final String? catype;
  final String? compAssignTechnician;
  final dynamic complainDate;
  final String? complainType;
  final String? compDescription;
  final String? amcDate1;
  final String? amcDate2;
  final String? amcDate3;
  final String? amcDate4;
  final String? amcDate5;
  final String? amcDate6;
  final String? amcDate7;
  final String? amcDate8;
  final String? amcDate9;
  final String? amcDate10;
  final String? amcDate11;
  final String? amcDate12;
  final String? amcDescription;
  final String? workRemark;
  final String? cash;
  final String? bill;
  final String? amt;
  final String? status;
  final String? accountPaymentStatus;
  final DateTime? createdAt;
  final String? createdBy;
  final String? modifiedBy;
  final String? modifiedAt;
  final String? assignToName;
  final String? checkIn;
  final String? checkOut;
  final String? reportType;

  ComplaintModel({
    this.id,
    this.date,
    this.machineType,
    this.compressorMake,
    this.compressorHp,
    this.companyName,
    this.address,
    this.city,
    this.contact,
    this.email,
    this.contactPerson,
    this.productDescription,
    this.catype,
    this.compAssignTechnician,
    this.complainDate,
    this.complainType,
    this.compDescription,
    this.amcDate1,
    this.amcDate2,
    this.amcDate3,
    this.amcDate4,
    this.amcDate5,
    this.amcDate6,
    this.amcDate7,
    this.amcDate8,
    this.amcDate9,
    this.amcDate10,
    this.amcDate11,
    this.amcDate12,
    this.amcDescription,
    this.workRemark,
    this.cash,
    this.bill,
    this.amt,
    this.status,
    this.accountPaymentStatus,
    this.createdAt,
    this.createdBy,
    this.modifiedBy,
    this.modifiedAt,
    this.assignToName,
    this.checkIn,
    this.checkOut,
    this.reportType,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json, String techName) =>
      ComplaintModel(
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        machineType: json["machineType"],
        compressorMake: json["compressorMake"],
        compressorHp: json["compressorHp"],
        companyName: json["companyName"],
        address: json["address"],
        city: json["city"],
        contact: json["contact"],
        email: json["email"],
        contactPerson: json["contactPerson"],
        productDescription: json["productDescription"],
        catype: json["catype"],
        compAssignTechnician: json["comp_assignTechnician"],
        complainDate: json["complainDate"],
        complainType: json["complainType"],
        compDescription: json["comp_description"],
        amcDate1: json["amc_date1"],
        amcDate2: json["amc_date2"],
        amcDate3: json["amc_date3"],
        amcDate4: json["amc_date4"],
        amcDate5: json["amc_date5"],
        amcDate6: json["amc_date6"],
        amcDate7: json["amc_date7"],
        amcDate8: json["amc_date8"],
        amcDate9: json["amc_date9"],
        amcDate10: json["amc_date10"],
        amcDate11: json["amc_date11"],
        amcDate12: json["amc_date12"],
        amcDescription: json["amc_description"],
        workRemark: json["work_remark"],
        cash: json["cash"],
        bill: json["bill"],
        amt: json["amt"],
        status: json["status"],
        accountPaymentStatus: json["account_payment_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        modifiedBy: json["modified_by"],
        modifiedAt: json["modified_at"],
        assignToName: techName,
        checkIn: json["checkIn"],
        checkOut: json["checkOut"],
        reportType: json["report_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "machineType": machineType,
        "compressorMake": compressorMake,
        "compressorHp": compressorHp,
        "companyName": companyName,
        "address": address,
        "city": city,
        "contact": contact,
        "email": email,
        "contactPerson": contactPerson,
        "productDescription": productDescription,
        "catype": catype,
        "comp_assignTechnician": compAssignTechnician,
        "complainDate": complainDate,
        "complainType": complainType,
        "comp_description": compDescription,
        "amc_date1": amcDate1,
        "amc_date2": amcDate2,
        "amc_date3": amcDate3,
        "amc_date4": amcDate4,
        "amc_date5": amcDate5,
        "amc_date6": amcDate6,
        "amc_date7": amcDate7,
        "amc_date8": amcDate8,
        "amc_date9": amcDate9,
        "amc_date10": amcDate10,
        "amc_date11": amcDate11,
        "amc_date12": amcDate12,
        "amc_description": amcDescription,
        "work_remark": workRemark,
        "cash": cash,
        "bill": bill,
        "amt": amt,
        "status": status,
        "account_payment_status": accountPaymentStatus,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "modified_by": modifiedBy,
        "modified_at": modifiedAt,
        "report_type": reportType,
      };
}
