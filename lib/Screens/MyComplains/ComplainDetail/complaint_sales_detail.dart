import 'dart:developer' as dev;
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:airo_tech/Screens/MyComplains/CreateReport/sales_report.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_model.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:airo_tech/Utils/upload_images_helper.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:airo_tech/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../Widgets/common_button_loader.dart';
import 'complaint_sales_detail_provider.dart';

class ComplaintSalesDetailScreen extends StatefulWidget {
  final ComplaintModel complaintModel;
  const ComplaintSalesDetailScreen({super.key, required this.complaintModel});

  @override
  State<ComplaintSalesDetailScreen> createState() =>
      _ComplaintSalesDetailScreenState();
}

class _ComplaintSalesDetailScreenState
    extends State<ComplaintSalesDetailScreen> {
  CroppedFile? document;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var signatureMemory;
  File? signatureFile;

  bool colorChange = false;

  final SignatureController _controller = SignatureController(
      penStrokeWidth: 2,
      penColor: blackColor,
      exportBackgroundColor: Colors.white);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
          Provider.of<ComplaintSalesDetailProvider>(context, listen: false);
      provider.initData();
    });
    super.initState();
  }

  Future<bool> onBackPressed() async {
    showAlertDialouge();

    return Future.value(false);
  }

  void showAlertDialouge() {
    showDialog(
        barrierColor: Colors.white.withOpacity(0.1),
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12)),

              title: const Text(
                'Are you sure you want to close the tab ??',
                textAlign: TextAlign.center,
              ),
              // content: const Text('FilerBackDrop'),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(color: whiteColor),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                        child: Text(
                          'Yes',
                          style: GoogleFonts.poppins(color: whiteColor),
                        ))
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var watch = context.watch<ComplaintSalesDetailProvider>();
    var read = context.read<ComplaintSalesDetailProvider>();
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: WillPopScope(
            onWillPop: onBackPressed,
            child: Scaffold(
                appBar: commonAppBar(
                  context: context,
                  heading: "Sales Report",
                  onPressed: () {
                    showAlertDialouge();
                  },
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Column(children: [
                      StepperTextField(
                        controllerValue: watch.ctlName,
                        inputType: TextInputType.name,
                        hintValue: 'Name',
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StepperTextField(
                        controllerValue: watch.ctlDesignation,
                        inputType: TextInputType.text,
                        hintValue: 'Designation',
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StepperTextField(
                        controllerValue: watch.ctlOrganization,
                        inputType: TextInputType.text,
                        hintValue: 'Organization',
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StepperTextField(
                        controllerValue: watch.ctlAddress,
                        inputType: TextInputType.streetAddress,
                        hintValue: 'Address',
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: StepperTextField(
                              controllerValue: watch.ctlMobile,
                              inputType: TextInputType.phone,
                              mLength: 10,
                              hintValue: 'Mobile',
                              validate: (val) {
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: StepperTextField(
                              controllerValue: watch.ctlOfficeNo,
                              inputType: TextInputType.phone,
                              mLength: 10,
                              hintValue: 'Office No',
                              validate: (val) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StepperTextField(
                        controllerValue: watch.ctlEmail,
                        inputType: TextInputType.emailAddress,
                        hintValue: 'Email',
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      UploadBusinessHelper(
                        uploadImage: () {
                          CommonFunctions().showPopUp(
                              context: context,
                              screenHeight: size.height,
                              screenWidth: size.width,
                              onCameraClick: () async {
                                Navigator.pop(context);
                                setState(() {
                                  colorChange = true;
                                });
                                await CommonFunctions()
                                    .pickAndCropImage(from: "camera")
                                    .then((value) {
                                  setState(() {
                                    colorChange = false;

                                    if (value != null) {
                                      document = value;
                                    }
                                  });
                                });
                              },
                              onGalleryClick: () async {
                                Navigator.pop(context);
                                setState(() {
                                  colorChange = true;
                                });
                                await CommonFunctions()
                                    .pickAndCropImage(from: "gallery")
                                    .then((value) {
                                  setState(() {
                                    colorChange = false;

                                    if (value != null) {
                                      document = value;
                                    }
                                  });
                                });
                              });
                        },
                        removeImage: () {
                          document = null;
                          setState(() {});
                        },
                        passedfile: document,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<ComplaintSalesDetailProvider>(
                          builder: (context, provider, child) {
                        return Row(
                          children: [
                            Text(
                              "Existing Customer",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Radio(
                              value: 'yes',
                              groupValue: provider.selection,
                              fillColor: WidgetStateProperty.all(primaryColor),
                              onChanged: (value) {
                                provider.changeSelection(value);
                              },
                            ),
                            Text(
                              'Yes',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500),
                            ),
                            Radio(
                              value: 'no',
                              groupValue: provider.selection,
                              fillColor: WidgetStateProperty.all(primaryColor),
                              onChanged: (value) {
                                provider.changeSelection(value);
                              },
                            ),
                            Text(
                              'No',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      }),
                      Row(
                        children: [
                          Text(
                            "Which M/C :",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: StepperTextField(
                              controllerValue: watch.mcController,
                              inputType: TextInputType.number,
                              hintValue: '',
                              validate: (val) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Consumer<ComplaintSalesDetailProvider>(
                              builder: (context, provider, child) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Product Interested :",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Screw Sir Compressor :",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      activeColor: primaryColor,
                                      visualDensity: VisualDensity.compact,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Vibrant Series',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[0],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(0, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'iPM Series',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[1],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(1, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Tankmounted Vibent/iPM',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[2],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(2, value!);
                                      },
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Reciprocating Air Compressor :",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      activeColor: primaryColor,
                                      visualDensity: VisualDensity.compact,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Lubricated',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[3],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(3, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Non Lubricated',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[4],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(4, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Hign Pressure',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[5],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(5, value!);
                                      },
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Vaccum Pump :",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      activeColor: primaryColor,
                                      visualDensity: VisualDensity.compact,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Air Receiver',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[6],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(6, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Refrigrate Air Dryer',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[7],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(7, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Filters',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[8],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(8, value!);
                                      },
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Panuumatic Tools :",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CheckboxListTile(
                                      activeColor: primaryColor,
                                      visualDensity: VisualDensity.compact,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        'Pipe Line',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[9],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(9, value!);
                                      },
                                    ),
                                    CheckboxListTile(
                                      visualDensity: VisualDensity.compact,
                                      activeColor: primaryColor,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      dense: true,
                                      title: Text(
                                        "Auto Drain Valves",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      value: provider.checkBoxValues[10],
                                      onChanged: (bool? value) {
                                        provider.changeProductIndex(10, value!);
                                      },
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Specification Of Compressors :",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlAirFlow,
                                      inputType: TextInputType.text,
                                      hintValue: 'Air Flow',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "CFM/liter/min/m3",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlPressure,
                                      inputType: TextInputType.text,
                                      hintValue: 'Pressure',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Psig/bar/kg/cm",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlPower,
                                      inputType: TextInputType.text,
                                      hintValue: 'Power',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "KW/HP",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: borderColor)),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              child: Column(children: [
                                Text(
                                  "Application :",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(
                                  color: blackColor,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                StepperTextField(
                                  controllerValue: watch.ctlApplication,
                                  inputType: TextInputType.text,
                                  hintValue: 'Application',
                                  validate: (val) {
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                StepperTextField(
                                  controllerValue: watch.ctlSuggestedType,
                                  inputType: TextInputType.text,
                                  hintValue: 'Suggested Type',
                                  validate: (val) {
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Compressor Package Requirement :",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Consumer<ComplaintSalesDetailProvider>(
                                        builder: (context, provider, child) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Radio(
                                            value: 'yes',
                                            groupValue: provider.compPackReq,
                                            fillColor: WidgetStateProperty.all(
                                                primaryColor),
                                            onChanged: (value) {
                                              provider.changeCompPackReq(value);
                                            },
                                          ),
                                          Text(
                                            'Yes',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Radio(
                                            value: 'no',
                                            groupValue: provider.compPackReq,
                                            fillColor: WidgetStateProperty.all(
                                                primaryColor),
                                            onChanged: (value) {
                                              provider.changeCompPackReq(value);
                                            },
                                          ),
                                          Text(
                                            'No',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "If Require Pachage, Fill Following Details:",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlCompCapModel,
                                      inputType: TextInputType.text,
                                      hintValue: 'Compressor Capacity/Model',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlAirRecCap,
                                      inputType: TextInputType.text,
                                      hintValue: 'Air Receiver Capacity',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Liters",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlAirDryer,
                                      inputType: TextInputType.text,
                                      hintValue: 'Air Dryer',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "CFM",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlPreFilters,
                                      inputType: TextInputType.text,
                                      hintValue: 'Pre Filters',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "CFM",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlPostFilters,
                                      inputType: TextInputType.text,
                                      hintValue: 'Post Filters',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "CFM",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlOtherAccessory,
                                      inputType: TextInputType.text,
                                      hintValue: 'Other accessory',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Require Quotation :",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<ComplaintSalesDetailProvider>(
                                            builder:
                                                (context, provider, child) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Radio(
                                                value: 'yes',
                                                groupValue: provider.reqQuote,
                                                fillColor:
                                                    WidgetStateProperty.all(
                                                        primaryColor),
                                                onChanged: (value) {
                                                  provider
                                                      .changeReqQoute(value);
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Radio(
                                                value: 'no',
                                                groupValue: provider.reqQuote,
                                                fillColor:
                                                    WidgetStateProperty.all(
                                                        primaryColor),
                                                onChanged: (value) {
                                                  provider
                                                      .changeReqQoute(value);
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlCompCapModel,
                                      inputType: TextInputType.text,
                                      hintValue:
                                          'Any Other Detail Require To Send',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    StepperTextField(
                                      controllerValue: watch.ctlVisitDate,
                                      inputType: TextInputType.text,
                                      rOnly: true,
                                      hintValue: 'Visit Date',
                                      onTap: () => read.geVisitDate(context),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlNextFollowUp,
                                      inputType: TextInputType.text,
                                      hintValue: 'Next Follow UP Require',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlDeliveryReq,
                                      inputType: TextInputType.text,
                                      hintValue: 'Delivery Require',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: borderColor)),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Existing Use By Customers :",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(
                                      color: blackColor,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlBrand,
                                      inputType: TextInputType.text,
                                      hintValue: 'Brand',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Type",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlScrewRecip,
                                      inputType: TextInputType.number,
                                      hintValue: 'Scrow/Recip',
                                      suf: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Qty",
                                              style: GoogleFonts.poppins(),
                                            )
                                          ],
                                        ),
                                      ),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlNos,
                                      inputType: TextInputType.text,
                                      hintValue: 'Nos.',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlYearOfPurchase,
                                      inputType: TextInputType.text,
                                      rOnly: true,
                                      hintValue: 'Year Of Purchase',
                                      onTap: () => read.getYear(context),
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue: watch.ctlAddComments,
                                      inputType: TextInputType.text,
                                      hintValue: 'Additional Comments',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StepperTextField(
                                      controllerValue:
                                          watch.ctlNameOfRepresentative,
                                      inputType: TextInputType.text,
                                      hintValue: 'Name Of Representative',
                                      validate: (val) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    signatureMemory != null
                                        ? const SizedBox(
                                            height: 10,
                                          )
                                        : const SizedBox(),
                                    signatureMemory != null
                                        ? SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: signatureMemory,
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Date",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: blackColor),
                                        ),
                                        Text(
                                          " :",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: blackColor),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          CommonFunctions().returnAppDateFormat(
                                              DateTime.now()),
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w500,
                                              color: blackColor),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: blackColor,
                                        ),
                                        onPressed: () {
                                          CommonFunctions.hideKeyboard(context);
                                          _uploadSignatureEnginer(context);
                                        },
                                        child: Text(
                                          "Upload Signature",
                                          style: GoogleFonts.poppins(
                                              color: whiteColor),
                                        )),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 25)),
                              onPressed: watch.isLoading
                                  ? null
                                  : () async {
                                      dev.log(
                                        'Submit Report tapped (sales)',
                                        name: 'SubmitReport',
                                      );
                                      final isValid =
                                          _formKey.currentState!.validate();

                                      if (!isValid) {
                                        dev.log(
                                          'Form validation failed (sales)',
                                          name: 'SubmitReport',
                                        );
                                        return;
                                      }

                                      if (signatureFile != null &&
                                          document != null) {
                                        dev.log(
                                          'Generating sales PDF… id=${widget.complaintModel.id}',
                                          name: 'SubmitReport',
                                        );
                                        final pdfFile =
                                            await SalesReportPDF().generate(
                                          widget.complaintModel,
                                          signatureFile!,
                                          document!,
                                          watch.ctlName.text,
                                          watch.ctlDesignation.text,
                                          watch.ctlOrganization.text,
                                          watch.ctlAddress.text,
                                          watch.ctlMobile.text,
                                          watch.ctlOfficeNo.text,
                                          watch.ctlEmail.text,
                                          watch.selection ?? "",
                                          watch.mcController.text,
                                          watch.checkBoxValues,
                                          watch.ctlAirFlow.text,
                                          watch.ctlPressure.text,
                                          watch.ctlPower.text,
                                          watch.ctlApplication.text,
                                          watch.ctlSuggestedType.text,
                                          watch.compPackReq ?? "",
                                          watch.ctlCompCapModel.text,
                                          watch.ctlAirRecCap.text,
                                          watch.ctlAirDryer.text,
                                          watch.ctlPreFilters.text,
                                          watch.ctlPostFilters.text,
                                          watch.ctlOtherAccessory.text,
                                          watch.reqQuote ?? "",
                                          watch.ctlAnyOtherDetailToSend.text,
                                          watch.ctlVisitDate.text,
                                          watch.ctlNextFollowUp.text,
                                          watch.ctlDeliveryReq.text,
                                          watch.ctlBrand.text,
                                          watch.ctlScrewRecip.text,
                                          watch.ctlNos.text,
                                          watch.ctlYearOfPurchase.text,
                                          watch.ctlAddComments.text,
                                          watch.ctlNameOfRepresentative.text,
                                        );

                                        dev.log(
                                          'Sales PDF ready: ${pdfFile?.path ?? '(null file)'}',
                                          name: 'SubmitReport',
                                        );
                                        if (pdfFile == null) {
                                          dev.log(
                                            'Abort: PDF was null',
                                            name: 'SubmitReport',
                                          );
                                          return;
                                        }
                                        await read.updateComlain(
                                            context,
                                            pdfFile,
                                            widget.complaintModel,
                                            "Other");

                                        // Navigator.pushNamed(
                                        //     context, RouteNames.pdfViewerPage,
                                        //     arguments: {"file": pdfFile});
                                      } else {
                                        dev.log(
                                          'Blocked (sales): sig=${signatureFile != null} doc=${document != null}',
                                          name: 'SubmitReport',
                                        );
                                        if (signatureFile == null) {
                                          CommonFunctions.showErrorSnackbar(
                                              "Upload Signature.");
                                        } else if (document == null) {
                                          CommonFunctions.showErrorSnackbar(
                                              "Upload Business Card.");
                                        }
                                      }
                                    },
                              child: watch.isLoading
                                  ? const CommonButtonLoader(
                                      indicatorColor: whiteColor)
                                  : Text(
                                      "Submit Report",
                                      style: GoogleFonts.poppins(
                                          color: whiteColor),
                                    )),
                        ],
                      )
                    ]),
                  )),
                ))));
  }

  Future _uploadSignatureEnginer(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          _controller.clear();

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStates) {
            return Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 20),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 50,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Draw signature here",
                    style: GoogleFonts.poppins(
                        color: blackColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: Stack(
                      children: [
                        Signature(
                          backgroundColor: grey200,
                          controller: _controller,
                        ),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                _controller.clear();
                              },
                              child: Container(
                                height: 25,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(color: borderColor),
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                  child: Text(
                                    "Clear",
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            foregroundColor: whiteColor,
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          Future<File> writeToFile(ByteData data) async {
                            //   final buffer = data.buffer;
                            Directory tempDir = await getTemporaryDirectory();
                            String tempPath = tempDir.path;
                            var filePath = '$tempPath/signature.png';
                            return File(filePath).writeAsBytes(
                                data.buffer.asUint8List(
                                    data.offsetInBytes, data.lengthInBytes),
                                flush: true);
                          }

                          if (_controller.isEmpty) {
                            setState(
                              () {
                                signatureMemory = null;
                              },
                            );
                            Navigator.pop(context);
                          } else {
                            var image = await _controller.toImage();
                            final bytes = await image!
                                .toByteData(format: ui.ImageByteFormat.png);
                            var file = await writeToFile(bytes!);

                            signatureMemory =
                                Image.memory(bytes.buffer.asUint8List());

                            setState(
                              () {
                                signatureFile = file;
                              },
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(color: whiteColor),
                        )),
                  ),
                ],
              ),
            );
          });
        });
  }
}
