// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../../Utils/common_functions.dart';
import '../../Auth/technician_model.dart';
import '../ComplainDetail/helper_models.dart';
import '../complaint_model.dart';
import 'pdf_api.dart';

class ReportPDF {
  var appLogo, todayDate, phoneIcon, emailIcon;
  var font, boldFont;
  String todate = "";
  TechnicianModel technicianModel = TechnicianModel();
  var airoTechStamp;
  var airoTechStamp2;

  getinitData() async {
    todate = CommonFunctions().returnAppDateFormat(DateTime.now());
    technicianModel = await CommonFunctions().getProfileData();
    appLogo = await imageFromAssetBundle("assets/images/app_logo.png");
    airoTechStamp = await imageFromAssetBundle("assets/images/stup.png");
    airoTechStamp2 = await imageFromAssetBundle("assets/images/stup.png");

    font = await PdfGoogleFonts.poppinsMedium();
    boldFont = await PdfGoogleFonts.poppinsBold();
  }

  Future<File?> generate(
      ComplaintModel complaintModel,
      List<String> hobbyList,
      String ctlComplainType,
      List<String> selectedHobby,
      List<ReciprocatingModel> reciprocatingList,
      List<ReciprocatingModel> screwList,
      String workDone,
      String custRemark,
      File techSignatureFile,
      File custSignatureFile,
      String custName,
      String name,
      String mobileNo,
      String runningHours,
      String loadingHours,
      String ivR,
      String ivY,
      String ivB,
      String oilTemp,
      String oilLoadPressure,
      String oilUnloadPressure,
      String nextService,
      String one,
      String two,
      String three,
      String four,
      String five,
      String six,
      String seven,
      String eight,
      String AttendBy,
      String FailedOn,
      String technicianRemark,
      String model,
      String nine,
      String ten,
      String eleven,
      String twelve,
      String equipmentSrNo,
      String filledBy,
      ) async {
    final pdf = pw.Document(pageMode: PdfPageMode.fullscreen);
    await getinitData();

    MemoryImage techImage = pw.MemoryImage(techSignatureFile.readAsBytesSync());
    MemoryImage custImage = pw.MemoryImage(custSignatureFile.readAsBytesSync());

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        buildbody(
            appLogo,
            font,
            boldFont,
            hobbyList,
            ctlComplainType,
            selectedHobby,
            reciprocatingList,
            screwList,
            workDone,
            custRemark,
            complaintModel,
            technicianModel,
            todate,
            techImage,
            custImage,
            custName,
            name,
            runningHours,
            loadingHours,
            ivR,
            ivY,
            ivB,
            oilTemp,
            oilLoadPressure,
            oilUnloadPressure,
            nextService,
            one,
            two,
            three,
            four,
            five,
            six,
            seven,
            eight,
            AttendBy,
            FailedOn,
            technicianRemark,
            model,
            nine,
            ten,
            eleven,
            twelve,
            equipmentSrNo,
            filledBy),
        pw.SizedBox(height: 300),
        nextPage(
            boldFont,
            font,
            workDone,
            custRemark,
            technicianModel,
            techImage,
            todate,
            custName,
            name,
            mobileNo,
            custImage,
            technicianRemark,
            airoTechStamp,
            airoTechStamp2)
      ],
    ));
    return PdfApi.saveDocument(
      name: 'Report.pdf',
      pdf: pdf,
    );
  }

  /// Signature with stamp overlaid on top-right corner of signature
  static pw.Widget signatureWithStamp(
      pw.ImageProvider? signatureImage,
      pw.ImageProvider? stampImage,
      ) {
    return pw.SizedBox(
      width: 160,
      height: 80,
      child: pw.Stack(
        children: [
          // Signature underneath
          if (signatureImage != null)
            pw.Positioned(
              left: 0,
              bottom: 0,
              child: pw.Image(
                signatureImage,
                width: 120,
                height: 60,
              ),
            ),
          // Stamp overlaid on top-right
          if (stampImage != null)
            pw.Positioned(
              right: 0,
              top: 0,
              child: pw.Image(
                stampImage,
                width: 70,
                height: 70,
              ),
            ),
        ],
      ),
    );
  }

  static pw.Widget buildbody(
      appLogo,
      font,
      boldFont,
      List<String> hobbyList,
      String ctlComplainType,
      List<String> selectedHobby,
      List<ReciprocatingModel> reciprocatingList,
      List<ReciprocatingModel> screwList,
      workDone,
      custRemark,
      ComplaintModel complaintModel,
      TechnicianModel technicianModel,
      todate,
      techImage,
      custImage,
      String custName,
      String name,
      String runningHours,
      String loadingHours,
      String ivR,
      String ivY,
      String ivB,
      String oilTemp,
      String loadPressure,
      String unloadPressure,
      String nextService,
      String one,
      String two,
      String three,
      String four,
      String five,
      String six,
      String seven,
      String eight,
      String AttendBy,
      String FailedOn,
      String technicianRemark,
      String model,
      String nine,
      String ten,
      String eleven,
      String twelve,
      String equipmentSrNo,
      String filledBy,
      ) {
    return pw.Container(
      decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.white,
          ),
          borderRadius: pw.BorderRadius.circular(0)),
      child: pw
          .Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
        pw.Image(appLogo, width: 120, height: 80, fit: pw.BoxFit.contain),
        pw.SizedBox(height: 4),
        pw.Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pw.Text(
                "PAL-AIR — Leader in Ventilation Technology",
                textAlign: TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 11,
                  font: boldFont,
                  color: PdfColors.red,
                ),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                "All Types of Air Compressors Sales, Service & Spare Parts Available — Elgi, Ingersoll Rand, Air Dryer Etc.",
                textAlign: TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  font: boldFont,
                  color: PdfColors.black,
                ),
              ),
              pw.Text(
                "Email: info@pal-air.com  |  Website: www.pal-air.com",
                textAlign: TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 8,
                  font: boldFont,
                  color: PdfColors.black,
                ),
              ),
            ]),
        pw.SizedBox(height: 5),
        pw.Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration:
            BoxDecoration(border: Border.all(color: PdfColors.black)),
            child: pw.Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      "SERVICE REPORT",
                      textAlign: TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 11,
                        font: boldFont,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "Company Name & Address :",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            complaintModel.companyName!,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Report No.",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          complaintModel.id!,
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                  SizedBox(height: 5),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "Person of Contacted :",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            complaintModel.contactPerson!,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Date ",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          CommonFunctions()
                              .returnAppDateFormat(complaintModel.date!),
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text(
                      "Types of Service:",
                      style: pw.TextStyle(
                        fontSize: 10,
                        font: boldFont,
                        color: PdfColors.black,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.SizedBox(
                        width: 350,
                        child: pw.Wrap(
                          children: hobbyList.map(
                                (hobby) {
                              bool isSelected = false;
                              if (selectedHobby.contains(hobby)) {
                                isSelected = true;
                              }
                              return pw.Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  child: pw.Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        pw.Checkbox(
                                            value: isSelected,
                                            name: hobby,
                                            activeColor: PdfColors.black),
                                        SizedBox(width: 5),
                                        pw.Text(
                                          hobby,
                                          style: const pw.TextStyle(
                                              color: PdfColors.black,
                                              fontSize: 9),
                                        ),
                                      ]));
                            },
                          ).toList(),
                        )),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Complain Type: ",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            ctlComplainType,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ]),
                  pw.SizedBox(height: 5),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Equipment Sr. No.",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            equipmentSrNo,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Model :",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            model,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Make :",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            complaintModel.compressorMake ?? "",
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ]),
                  pw.SizedBox(height: 2),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "Failed on:",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            FailedOn,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Filled By / Ref. By:",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            filledBy,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ]),
                  pw.SizedBox(height: 2),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "Comp Recvd On :",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            CommonFunctions()
                                .returnAppDateFormat(complaintModel.createdAt!),
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Text(
                          "Attnd By :",
                          style: pw.TextStyle(
                            fontSize: 10,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Text(
                            AttendBy,
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                      ]),
                  pw.Divider(),
                  pw.Row(children: [
                    pw.Expanded(
                      child: pw.Text(
                        "RECIPROCATING AIR COMPRESSOR",
                        textAlign: TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldFont,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Text(
                        "SCREW COMPRESSOR",
                        textAlign: TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 9,
                          font: boldFont,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 5,
                  ),
                  pw.Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.ListView.separated(
                              separatorBuilder: (context, index) {
                                return pw.SizedBox(height: 5);
                              },
                              itemBuilder: (context, index) {
                                var data = reciprocatingList[index];
                                return pw.Row(
                                  children: [
                                    pw.Checkbox(
                                        value: data.isSelected,
                                        name: data.title,
                                        activeColor: PdfColors.black),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      data.title,
                                      style: const pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 7.5),
                                    ),
                                  ],
                                );
                              },
                              itemCount: reciprocatingList.length),
                        ),
                        pw.Expanded(
                          child: pw.ListView.separated(
                              separatorBuilder: (context, index) {
                                return pw.SizedBox(height: 5);
                              },
                              itemBuilder: (context, index) {
                                var data = screwList[index];
                                return pw.Row(
                                  children: [
                                    pw.Checkbox(
                                        value: data.isSelected,
                                        name: data.title,
                                        activeColor: PdfColors.black),
                                    pw.SizedBox(width: 5),
                                    pw.Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            data.title,
                                            style: const pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 7.5),
                                          ),
                                          pw.Text(
                                            data.title == "RUNNING HOURS"
                                                ? runningHours.isEmpty
                                                ? ""
                                                : "$runningHours Hrs"
                                                : data.title == "LOADING HOURS"
                                                ? loadingHours.isEmpty
                                                ? ""
                                                : "$loadingHours Hrs"
                                                : data.title ==
                                                "INCOMING VOLTAGE"
                                                ? ivR.isEmpty &&
                                                ivY.isEmpty &&
                                                ivB.isEmpty
                                                ? ""
                                                : "R : $ivR | Y : $ivY | B : $ivB"
                                                : data.title ==
                                                "OIL TEMPERATURE"
                                                ? oilTemp.isEmpty
                                                ? ""
                                                : "$oilTemp Temp"
                                                : data.title ==
                                                "LOADING PRESSURE"
                                                ? loadPressure
                                                .isEmpty
                                                ? ""
                                                : "$loadPressure Pressure"
                                                : data.title ==
                                                "UNLOADING PRESSURE"
                                                ? unloadPressure
                                                .isEmpty
                                                ? ""
                                                : "$unloadPressure Pressure"
                                                : data.title ==
                                                "AIR FILTER CONDITION IS GOOD AND NO DUST ENTRY"
                                                ? one
                                                : data.title ==
                                                "DRYER CONDENSER CLEANING/COOLING FLUENCY"
                                                ? two
                                                : data.title == "DRYER DEW POINT"
                                                ? three
                                                : data.title == "MAINTENANCE AS PER RECOMMENDATION"
                                                ? four
                                                : data.title == "INSTALLATION AS PER RECOMMENDATION"
                                                ? five
                                                : data.title == "LAST SERVICE WORKING HOURS / SERVICES"
                                                ? six
                                                : data.title == "NEXT SERVICE WORKING HOURS / SERVICES"
                                                ? seven
                                                : data.title == "LINE CURRENT MEASURED FULL LOAD / UNLOAD"
                                                ? eight
                                                : "",
                                            style: const pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 7.5),
                                          ),
                                        ]),
                                    pw.SizedBox(width: 10),
                                  ],
                                );
                              },
                              itemCount: screwList.length),
                        ),
                      ]),
                  SizedBox(
                    height: 5,
                  ),
                  pw.Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "0 TO $nine KG : $ten MIN/SEC",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Text(
                          "OUT 0 TO $eleven KG : $twelve MIN/SEC",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                ])),
      ]),
    );
  }

  static pw.Widget nextPage(
      boldFont,
      font,
      workDone,
      custRemark,
      TechnicianModel technicianModel,
      techImage,
      todate,
      String custName,
      String name,
      String mobileNo,
      custImage,
      technicianRemark,
      airoTechStamp,
      airoTechStamp2) {
    return pw.Container(
      decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.white,
          ),
          borderRadius: pw.BorderRadius.circular(0)),
      child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.black,
                    ),
                    borderRadius: pw.BorderRadius.circular(0)),
                child: pw.Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Work Done",
                        style: pw.TextStyle(
                          fontSize: 10,
                          font: boldFont,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        workDone,
                        style: pw.TextStyle(
                          fontSize: 8,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Customer Remarks",
                        style: pw.TextStyle(
                          fontSize: 10,
                          font: boldFont,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        custRemark,
                        style: pw.TextStyle(
                          fontSize: 8,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        "Technician Remarks",
                        style: pw.TextStyle(
                          fontSize: 10,
                          font: boldFont,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        technicianRemark,
                        style: pw.TextStyle(
                          fontSize: 8,
                          font: font,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Technician side
                            pw.Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "Name : ${technicianModel.fullName}",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 20),
                                  pw.Text(
                                    "Date : $todate",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 10),
                                  pw.Row(children: [
                                    pw.Text(
                                      "Signature :",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: boldFont,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Use first stamp instance for technician
                                    signatureWithStamp(techImage, airoTechStamp)
                                  ])
                                ]),
                            // Customer side
                            pw.Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "Company Name : $custName",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    "Customer Name : $name",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    "Mobile No : $mobileNo",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    "Date : $todate",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  pw.SizedBox(height: 10),
                                  pw.Row(children: [
                                    pw.Text(
                                      "Signature :",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        font: boldFont,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    // Use second stamp instance for customer
                                    signatureWithStamp(custImage, airoTechStamp2)
                                  ])
                                ])
                          ])
                    ]))
          ]),
    );
  }
}