// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:airo_tech/Screens/Auth/technician_model.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_model.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import 'pdf_api.dart';

class SalesReportPDF {
  var appLogo, todayDate, phoneIcon, emailIcon;
  var font, boldFont;
  String todate = "";
  TechnicianModel technicianModel = TechnicianModel();
  getinitData() async {
    todate = CommonFunctions().returnAppDateFormat(DateTime.now());
    technicianModel = await CommonFunctions().getProfileData();
    // todayDate = CommonFunctions().getCurrentDate();
    appLogo = await networkImage(
        "http://airotech.webvisionsoftech.com/assets/images/logos/logo.png");

    // phoneIcon = await networkImage("${ReomteUrl.requiredImagePath}/mobile.png");
    // emailIcon = await networkImage("${ReomteUrl.requiredImagePath}/email.png");
    font = await PdfGoogleFonts.poppinsMedium();
    boldFont = await PdfGoogleFonts.poppinsBold();
  }

  Future<File?> generate(
    ComplaintModel complaintModel,
    File passedSignature,
    CroppedFile businessCard,
    String name,
    String designation,
    String organization,
    String address,
    String mobile,
    String office,
    String email,
    String existingCust,
    String whichMc,
    List bools,
    String airFlow,
    String pressure,
    String power,
    String application,
    String suggestedType,
    String compPackReq,
    String compCapMod,
    String airRecCap,
    String airDryer,
    String preFilters,
    String postFilters,
    String otherAccessory,
    String reqQuote,
    String anyOtherDetailToSend,
    String visitDate,
    String nextFollowUp,
    String deliveryReq,
    String brand,
    String screwRecip,
    String nos,
    String yearOfPurchase,
    String addComments,
    String nameOfRepresentative,
  ) async {
    final pdf = pw.Document(pageMode: PdfPageMode.fullscreen);
    await getinitData();

    MemoryImage signature = pw.MemoryImage(passedSignature.readAsBytesSync());
    MemoryImage card = pw.MemoryImage(await businessCard.readAsBytes());

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        buildbody(
          appLogo,
          font,
          boldFont,
          complaintModel,
          signature,
          card,
          name,
          designation,
          organization,
          address,
          mobile,
          office,
          email,
          existingCust,
          whichMc,
          bools,
          airFlow,
          pressure,
          power,
          application,
          suggestedType,
          compPackReq,
          compCapMod,
          airRecCap,
          airDryer,
          preFilters,
          postFilters,
          otherAccessory,
          reqQuote,
          anyOtherDetailToSend,
          visitDate,
          nextFollowUp,
          deliveryReq,
          brand,
          screwRecip,
          nos,
          yearOfPurchase,
          addComments,
          nameOfRepresentative,
        )
      ],
      // header: (context) => buildTitle(context, netImage),
    ));
    return PdfApi.saveDocument(
      name: 'Report.pdf',
      pdf: pdf,
    );
  }

  static pw.Widget buildbody(
    appLogo,
    font,
    boldFont,
    complaintModel,
    signature,
    card,
    name,
    designation,
    organization,
    address,
    mobile,
    office,
    email,
    existingCust,
    whichMc,
    bools,
    airFlow,
    pressure,
    power,
    application,
    suggestedType,
    compPackReq,
    compCapMod,
    airRecCap,
    airDryer,
    preFilters,
    postFilters,
    otherAccessory,
    reqQuote,
    anyOtherDetailToSend,
    visitDate,
    nextFollowUp,
    deliveryReq,
    brand,
    screwRecip,
    nos,
    yearOfPurchase,
    addComments,
    nameOfRepresentative,
  ) {
    return pw.Container(
      decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.white,
          ),
          borderRadius: pw.BorderRadius.circular(0)),
      child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Image(appLogo, width: 170),
            pw.SizedBox(height: 5),
            pw.Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration:
                    BoxDecoration(border: Border.all(color: PdfColors.black)),
                child: pw.Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "INQUIRY FORM",
                          textAlign: TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Expanded(
                          child: pw.Column(children: [
                            pw.Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    "Name :",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      font: boldFont,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Text(
                                      name,
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                        font: font,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  )
                                ]),
                            SizedBox(height: 2),
                            pw.Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    "Designation :",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      font: boldFont,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Text(
                                      designation,
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                        font: font,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 2),
                            pw.Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    "Organization :",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      font: boldFont,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Text(
                                      organization,
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                        font: font,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 2),
                            pw.Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    "Address :",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      font: boldFont,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Text(
                                      address,
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                        font: font,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(height: 2),
                            pw.Row(children: [
                              pw.Expanded(
                                child: pw.Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        "Mobile :",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          font: boldFont,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      pw.Text(
                                        mobile,
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(width: 10),
                              pw.Expanded(
                                child: pw.Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        "Office :",
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          font: boldFont,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      pw.Text(
                                        office,
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ]),
                              )
                            ]),
                            SizedBox(height: 2),
                            pw.Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    "Email :",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      font: boldFont,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Text(
                                      email,
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                        font: font,
                                        color: PdfColors.black,
                                      ),
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                        pw.Image(card, height: 100, width: 100)
                      ]),
                      SizedBox(height: 5),
                      pw.Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            pw.Expanded(
                                child: pw.Row(children: [
                              pw.Text(
                                "1) Existing Customer :",
                                style: pw.TextStyle(
                                  fontSize: 9,
                                  font: boldFont,
                                  color: PdfColors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              pw.Text(
                                existingCust,
                                style: pw.TextStyle(
                                  fontSize: 9,
                                  font: font,
                                  color: PdfColors.black,
                                ),
                              ),
                            ])),
                            pw.Expanded(
                                child: pw.Row(children: [
                              pw.Text(
                                "Which M/c :",
                                style: pw.TextStyle(
                                  fontSize: 9,
                                  font: boldFont,
                                  color: PdfColors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              pw.Text(
                                whichMc,
                                style: pw.TextStyle(
                                  fontSize: 9,
                                  font: font,
                                  color: PdfColors.black,
                                ),
                              ),
                            ]))
                          ]),
                      SizedBox(height: 5),
                      pw.Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "2) Product Interested",
                              style: pw.TextStyle(
                                fontSize: 9,
                                font: boldFont,
                                color: PdfColors.black,
                              ),
                            ),
                            SizedBox(height: 2),
                            pw.Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: pw.Column(children: [
                                  pw.Row(children: [
                                    pw.SizedBox(
                                      width: 150,
                                      child: pw.Text(
                                        "A) Screw Air Compressor :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "Vibrant Series",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[0],
                                          name: "Vibrant Series",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "IPM Series",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[1],
                                          name: "IPM Series",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "Tankmounted Vibent/iPM",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[2],
                                          name: "Tankmounted Vibent/iPM",
                                          activeColor: PdfColors.black),
                                    ),
                                  ]),
                                  SizedBox(height: 8),
                                  pw.Row(children: [
                                    pw.SizedBox(
                                      width: 150,
                                      child: pw.Text(
                                        "B) Reciprocating Air Compressor :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "Lubricated",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[3],
                                          name: "Lubricated",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "Non Lubricated",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[4],
                                          name: "Non Lubricated",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "Hign Pressure",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[5],
                                          name: "Hign Pressure",
                                          activeColor: PdfColors.black),
                                    ),
                                  ]),
                                  SizedBox(height: 8),
                                  pw.Row(children: [
                                    pw.SizedBox(
                                      width: 150,
                                      child: pw.Text(
                                        "C) Vaccum Pump :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "Air Receiver",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[6],
                                          name: "Air Receiver",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "Refrigrate Air Dryer",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[7],
                                          name: "Refrigrate Air Dryer",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "Filters",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[8],
                                          name: "Filters",
                                          activeColor: PdfColors.black),
                                    ),
                                  ]),
                                  SizedBox(height: 8),
                                  pw.Row(children: [
                                    pw.SizedBox(
                                      width: 150,
                                      child: pw.Text(
                                        "D) Panuumatic Tools :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "Pipe Line",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[9],
                                          name: "Pipe Line",
                                          activeColor: PdfColors.black),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "Auto Drain Valves",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.SizedBox(
                                      height: 13,
                                      width: 13,
                                      child: pw.Checkbox(
                                          value: bools[10],
                                          name: "Auto Drain Valves",
                                          activeColor: PdfColors.black),
                                    ),
                                  ]),
                                ]))
                          ]),
                      SizedBox(height: 5),
                      pw.Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "3) Specification Of Compressors :",
                              style: pw.TextStyle(
                                fontSize: 9,
                                font: boldFont,
                                color: PdfColors.black,
                              ),
                            ),
                            SizedBox(height: 2),
                            pw.Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: pw.Row(children: [
                                  pw.Text(
                                    "a) Air Flow :",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  pw.Text(
                                    "$airFlow CFM/liter/min/m3",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Text(
                                    "b) Pressure :",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  pw.Text(
                                    "$pressure Psig/bar/kg/cm",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  pw.Text(
                                    "c) Power :",
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  pw.Text(
                                    "$power KW/HP",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      font: font,
                                      color: PdfColors.black,
                                    ),
                                  ),
                                ]))
                          ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Expanded(
                            child: Row(children: [
                          pw.Text(
                            "4) Application :",
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: boldFont,
                              color: PdfColors.black,
                            ),
                          ),
                          SizedBox(width: 5),
                          pw.Text(
                            "$application",
                            style: pw.TextStyle(
                              fontSize: 8,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ])),
                        SizedBox(width: 10),
                        pw.Expanded(
                            child: Row(children: [
                          pw.Text(
                            "5) Suggested Type :",
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: boldFont,
                              color: PdfColors.black,
                            ),
                          ),
                          SizedBox(width: 5),
                          pw.Text(
                            "$suggestedType",
                            style: pw.TextStyle(
                              fontSize: 8,
                              font: font,
                              color: PdfColors.black,
                            ),
                          ),
                        ]))
                      ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Text(
                          "6) Comressor Package Requirement : Yes / No : ",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        pw.Text(
                          "$compPackReq",
                          style: pw.TextStyle(
                            fontSize: 8,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: 5),
                      pw.Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "7) If Require Package,Fill Following Details :",
                              style: pw.TextStyle(
                                fontSize: 9,
                                font: boldFont,
                                color: PdfColors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            pw.Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: pw.Column(children: [
                                  pw.Row(children: [
                                    pw.Text(
                                      "a) Compressor Capacity/Model :",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      compCapMod,
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "a) Air Receiver Capacity :",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "$airRecCap Liters",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "c) Air Dryer :",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "$airDryer CFM",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                  ]),
                                  SizedBox(height: 8),
                                  pw.Row(children: [
                                    pw.Text(
                                      "d) Pre Filters :",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "$preFilters CFM",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Text(
                                      "e) Post Filters :",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                      "$postFilters CFM",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                  ]),
                                  SizedBox(height: 8),
                                  pw.Row(children: [
                                    pw.Text(
                                      "f) Other accessory if Any :",
                                      style: const pw.TextStyle(
                                          color: PdfColors.black, fontSize: 8),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Expanded(
                                      child: pw.Text(
                                        otherAccessory,
                                        style: const pw.TextStyle(
                                            color: PdfColors.black,
                                            fontSize: 8),
                                      ),
                                    )
                                  ])
                                ]))
                          ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Text(
                          "8) Require Quotation : Yes / No :",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        pw.Text(
                          reqQuote,
                          style: pw.TextStyle(
                            fontSize: 8,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Text(
                          "9) Any Other Detail Require To Send",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        pw.Text(
                          anyOtherDetailToSend,
                          style: pw.TextStyle(
                            fontSize: 8,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Expanded(
                          child: pw.Row(children: [
                            pw.Text(
                              "10) Visited Date :",
                              style: pw.TextStyle(
                                fontSize: 9,
                                font: boldFont,
                                color: PdfColors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            pw.Text(
                              visitDate,
                              style: pw.TextStyle(
                                fontSize: 8,
                                font: font,
                                color: PdfColors.black,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(width: 10),
                        pw.Expanded(
                          child: pw.Row(children: [
                            pw.Text(
                              "11) Next Follow UP Require :",
                              style: pw.TextStyle(
                                fontSize: 9,
                                font: boldFont,
                                color: PdfColors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            pw.Text(
                              nextFollowUp,
                              style: pw.TextStyle(
                                fontSize: 8,
                                font: font,
                                color: PdfColors.black,
                              ),
                            ),
                          ]),
                        )
                      ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Text(
                          "12) Delivery Require :",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        pw.Text(
                          deliveryReq,
                          style: pw.TextStyle(
                            fontSize: 8,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: 5),
                      pw.Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "13) Existing Use By Customers :",
                              style: pw.TextStyle(
                                fontSize: 9,
                                font: boldFont,
                                color: PdfColors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            pw.Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: pw.Column(children: [
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Row(children: [
                                      pw.Text(
                                        "Brand :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: boldFont,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      pw.Text(
                                        "$brand Type",
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ])),
                                    SizedBox(width: 5),
                                    pw.Expanded(
                                        child: pw.Row(children: [
                                      pw.Text(
                                        "Scrow / Recip :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: boldFont,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      pw.Text(
                                        "$screwRecip Qty.",
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ])),
                                  ]),
                                  SizedBox(height: 3),
                                  pw.Row(children: [
                                    pw.Expanded(
                                        child: pw.Row(children: [
                                      pw.Text(
                                        "Nos. :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: boldFont,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      pw.Text(
                                        nos,
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ])),
                                    SizedBox(width: 5),
                                    pw.Expanded(
                                        child: pw.Row(children: [
                                      pw.Text(
                                        "Year Of Purchase :",
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          font: boldFont,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      pw.Text(
                                        yearOfPurchase,
                                        style: pw.TextStyle(
                                          fontSize: 8,
                                          font: font,
                                          color: PdfColors.black,
                                        ),
                                      ),
                                    ])),
                                  ]),
                                ]))
                          ]),
                      SizedBox(height: 5),
                      pw.Row(children: [
                        pw.Text(
                          "14) Additional Comments :",
                          style: pw.TextStyle(
                            fontSize: 9,
                            font: boldFont,
                            color: PdfColors.black,
                          ),
                        ),
                        SizedBox(width: 5),
                        pw.Text(
                          addComments,
                          style: pw.TextStyle(
                            fontSize: 8,
                            font: font,
                            color: PdfColors.black,
                          ),
                        ),
                      ]),
                      SizedBox(height: 5),
                      pw.Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(
                                child: pw.Row(children: [
                              pw.Text(
                                "Name Of Representative :",
                                style: pw.TextStyle(
                                  fontSize: 9,
                                  font: boldFont,
                                  color: PdfColors.black,
                                ),
                              ),
                              SizedBox(width: 5),
                              pw.Text(
                                nameOfRepresentative,
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  font: font,
                                  color: PdfColors.black,
                                ),
                              ),
                            ])),
                            pw.Column(children: [
                              pw.Image(signature, height: 50, width: 50),
                              SizedBox(height: 5),
                              pw.Text(
                                CommonFunctions()
                                    .returnAppDateFormat(DateTime.now()),
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  font: font,
                                  color: PdfColors.black,
                                ),
                              ),
                            ])
                          ]),
                    ])),
          ]),
    );
  }
}
