import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../Utils/appcolors.dart';
import '../../../Utils/common_functions.dart';
import '../../../Widgets/common_appbar.dart';
import '../../../Widgets/common_button_loader.dart';
import '../../../Widgets/custom_checkbox_list_item.dart';
import '../../../Widgets/dropdown_widget.dart';
import '../../../Widgets/input_fields.dart';
import '../Components/complaint_view.dart';
import '../CreateReport/report_pdf.dart';
import '../complaint_model.dart';
import 'complain_detail_provider.dart';

class ComplainDetailScreen extends StatefulWidget {
  final ComplaintModel complaintModel;
  final String from;
  const ComplainDetailScreen(
      {super.key, required this.complaintModel, required this.from});

  @override
  State<ComplainDetailScreen> createState() => _ComplainDetailScreenState();
}

class _ComplainDetailScreenState extends State<ComplainDetailScreen> {
  var signatureMemory, custSignatureMemory;
  final GlobalKey<FormState> _formKey = GlobalKey();

  File? signatureFile, custSignatureFile;
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 2,
      penColor: blackColor,
      exportBackgroundColor: Colors.white);

  final SignatureController _controllerCustomer = SignatureController(
      penStrokeWidth: 2,
      penColor: blackColor,
      exportBackgroundColor: Colors.white);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
      Provider.of<ComplainDetailProvider>(context, listen: false);
      provider.initData(widget.complaintModel);
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
                        child: const Text('No')),
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          appBar: commonAppBar(
            context: context,
            heading: "Service Report",
            onPressed: () {
              showAlertDialouge();
            },
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Column(
                  children: [
                    OrderDetailHelper(
                      heading: "Company",
                      value: widget.complaintModel.companyName!,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Address",
                      value: widget.complaintModel.address!,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MultiOrderDetailHelper(
                          heading: "Report No.",
                          value: widget.complaintModel.id!,
                        ),
                        MultiOrderDetailHelper(
                          heading: "Date",
                          value: CommonFunctions()
                              .returnAppDateFormat(widget.complaintModel.date!),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Assigned To",
                      value: widget.complaintModel.assignToName!,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Contact No",
                      value: widget.complaintModel.contact!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: blackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Types of Services",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: blackColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return Wrap(
                            children: provider.hobbyList.map(
                                  (hobby) {
                                bool isSelected = false;
                                if (provider.selectedHobby.contains(hobby)) {
                                  isSelected = true;
                                }
                                return GestureDetector(
                                  onTap: () {
                                    provider.changeSelectedHobby(
                                        hobby, widget.complaintModel, widget.from);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 4),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 25),
                                        decoration: BoxDecoration(
                                            color: isSelected
                                                ? primaryColor
                                                : whiteColor,
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(
                                                color: isSelected
                                                    ? primaryColor
                                                    : Colors.grey,
                                                width: 2)),
                                        child: Text(
                                          hobby,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isSelected
                                                  ? whiteColor
                                                  : Colors.grey,
                                              fontSize: 12),
                                        ),
                                      )),
                                );
                              },
                            ).toList(),
                          );
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return StepperTextField(
                            controllerValue: provider.ctlComplainType,
                            inputType: TextInputType.text,
                            hintValue: 'Complain Type',
                            validate: (val) {
                              return null;
                            },
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: blackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return StepperTextField(
                            controllerValue: provider.ctlEquipmentSrNo,
                            inputType: TextInputType.text,
                            hintValue: 'Equipment Sr. No.',
                            validate: (val) {
                              return null;
                            },
                          );
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Make",
                      value: widget.complaintModel.compressorMake!,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Comp Recvd On",
                      value: CommonFunctions().returnAppDateFormat(
                          widget.complaintModel.createdAt!),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Consumer<ComplainDetailProvider>(
                    //     builder: (context, provider, child) {
                    //   return Row(
                    //     children: [
                    //       Expanded(
                    //         child: OrderDetailHelper(
                    //           heading: "Failed On",
                    //           value: provider.faildOnDate == null
                    //               ? ""
                    //               : CommonFunctions().returnAppDateFormat(
                    //                   provider.faildOnDate!),
                    //         ),
                    //       ),
                    //       InkWell(
                    //         onTap: () => provider.geDate(context),
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 10, vertical: 5),
                    //           decoration: BoxDecoration(
                    //               color: primaryColor,
                    //               borderRadius: BorderRadius.circular(12)),
                    //           child: Text(
                    //             provider.faildOnDate == null
                    //                 ? "Select Date"
                    //                 : "Change Date",
                    //             style: GoogleFonts.poppins(
                    //                 color: whiteColor,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   );
                    // }),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return StepperTextField(
                            controllerValue: provider.FailedOn,
                            inputType: TextInputType.text,
                            hintValue: 'Failed On: ',
                            validate: (val) {
                              return null;
                            },
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return StepperTextField(
                            controllerValue: provider.ctlFilledBy,
                            inputType: TextInputType.text,
                            hintValue: 'Filled By / Ref. By',
                            validate: (val) {
                              return null;
                            },
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return StepperTextField(
                            controllerValue: provider.AttendBy,
                            inputType: TextInputType.text,
                            hintValue: 'Attend By',
                            validate: (val) {
                              return null;
                            },
                          );
                        }),
                    // OrderDetailHelper(
                    //   heading: "Attend On",
                    //   value:
                    //       CommonFunctions().returnAppDateFormat(DateTime.now()),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Complaint",
                      value: widget.complaintModel.complainType!,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    OrderDetailHelper(
                      heading: "Description",
                      value: widget.complaintModel.productDescription!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return StepperTextField(
                            controllerValue: provider.ctlModel,
                            inputType: TextInputType.text,
                            hintValue: 'Model',
                            validate: (val) {
                              return null;
                            },
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: blackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return const CheckBoxTitleList(
                            from: "rec",
                            title: "RECIPROCATING AIR COMPRESSOR",
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: blackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return const CheckBoxTitleList(
                            from: "screw",
                            title: "SCREW COMPRESSOR",
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: blackColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            children: [
                              // StepperTextField(
                              //   controllerValue: provider.workDone,
                              //   hintValue: 'Work Done',
                              //   inputType: TextInputType.multiline,
                              //   actionNext: TextInputAction.newline,
                              //   validate: (val) {
                              //     if (val!.isEmpty) {
                              //       return "Add Work Done Remark";
                              //     }
                              //     return null;
                              //   },
                              // ),
                              ExpandedDropDownWidget(
                                  labelText: 'Work Status',
                                  hintText: "Select Work Status",
                                  dropMenuList: const [
                                    "On Process",
                                    "Machine Open",
                                    "Holding",
                                    "Repeat",
                                    "Installation",
                                    "Visit",
                                    "Observation",
                                    "Work Done",
                                  ],
                                  selectedReturnValue: (value) {
                                    provider.onChangeWorkStatus(value);
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Consumer<ComplainDetailProvider>(
                                  builder: (context, provider, child) {
                                    return StepperTextField(
                                      controllerValue: provider.technicianRemark,
                                      inputType: TextInputType.text,
                                      hintValue: 'Technician Remark',
                                      validate: (val) {
                                        return null;
                                      },
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              StepperTextField(
                                controllerValue: provider.custRemark,
                                hintValue: 'Customer Remark',
                                inputType: TextInputType.multiline,
                                actionNext: TextInputAction.newline,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Add Remark";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: blackColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "0 TO ",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: provider.ctl9,
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors
                                                .grey), // Optional: Customize label color
                                        border:
                                        UnderlineInputBorder(), // Use UnderlineInputBorder
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "KG :",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: provider.ctl10,
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors
                                                .grey), // Optional: Customize label color
                                        border:
                                        UnderlineInputBorder(), // Use UnderlineInputBorder
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " MIN/SEC",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "OUT 0 TO ",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: provider.ctl11,
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors
                                                .grey), // Optional: Customize label color
                                        border:
                                        UnderlineInputBorder(), // Use UnderlineInputBorder
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "KG :",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: provider.ctl12,
                                      decoration: const InputDecoration(
                                        labelStyle: TextStyle(
                                            color: Colors
                                                .grey), // Optional: Customize label color
                                        border:
                                        UnderlineInputBorder(), // Use UnderlineInputBorder
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " MIN/SEC",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<ComplainDetailProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            children: [
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: borderColor)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Service Engineer / Representative",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      OrderDetailHelper(
                                          heading: "Name",
                                          value:
                                          provider.technicianModel.fullName ??
                                              ""),
                                      OrderDetailHelper(
                                          heading: "Date",
                                          value: CommonFunctions()
                                              .returnAppDateFormat(DateTime.now())),
                                      signatureMemory != null
                                          ? const SizedBox(
                                        height: 10,
                                      )
                                          : const SizedBox(),
                                      signatureMemory != null
                                          ? SizedBox(
                                        height: 130,
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: signatureMemory,
                                            ),
                                            const SizedBox(width: 10),
                                            Image.asset(
                                              "assets/images/stup.png",
                                              height: 130,
                                              width: 130,
                                            ),
                                          ],
                                        ),
                                      )
                                          : const SizedBox(),
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
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: borderColor)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      StepperTextField(
                                        rOnly: true,
                                        controllerValue: provider.custName,
                                        hintValue: 'Company Name',
                                        inputType: TextInputType.text,
                                        actionNext: TextInputAction.next,
                                        validate: (val) {
                                          if (val!.isEmpty) {
                                            return "Add Company Name";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StepperTextField(
                                        controllerValue: provider.name,
                                        hintValue: 'Customer Name',
                                        inputType: TextInputType.text,
                                        actionNext: TextInputAction.next,
                                        validate: (val) {
                                          if (val!.isEmpty) {
                                            return "Add Customer Name";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      StepperTextField(
                                        controllerValue: provider.mobileNo,
                                        hintValue: 'Customer Mobile No',
                                        inputType: TextInputType.phone,
                                        actionNext: TextInputAction.next,
                                        validate: (val) {
                                          if (val!.isEmpty) {
                                            return "Add Customer Mobile No";
                                          }
                                          if (val.length < 10) {
                                            return "Enter valid mobile number";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      OrderDetailHelper(
                                          heading: "Date",
                                          value: CommonFunctions()
                                              .returnAppDateFormat(DateTime.now())),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      signatureMemory != null
                                          ? const SizedBox(
                                        height: 10,
                                      )
                                          : const SizedBox(),
                                      custSignatureMemory != null
                                          ? SizedBox(
                                        height: 130,
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: custSignatureMemory,
                                            ),
                                            const SizedBox(width: 10),
                                            Image.asset(
                                              "assets/images/stup.png",
                                              height: 130,
                                              width: 130,
                                            ),
                                          ],
                                        ),
                                      )
                                          : const SizedBox(),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: blackColor,
                                          ),
                                          onPressed: () {
                                            CommonFunctions.hideKeyboard(context);
                                            _uploadSignatureCustomer(context);
                                            // provider.loadingFun(false);
                                          },
                                          child: Text(
                                            "Upload Customer Signature",
                                            style: GoogleFonts.poppins(
                                                color: whiteColor),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 25)),
                                  onPressed: provider.isLoading
                                      ? null
                                      : () async {
                                    dev.log(
                                      'Submit Report tapped (service)',
                                      name: 'SubmitReport',
                                    );
                                    final isValid =
                                    _formKey.currentState!.validate();

                                    if (!isValid) {
                                      dev.log(
                                        'Form validation failed',
                                        name: 'SubmitReport',
                                      );
                                      CommonFunctions.showErrorSnackbar(
                                          "Please fill all required fields (Company Name, Customer Name, Customer Mobile No, Customer Remark).");
                                      return;
                                    }

                                    if (signatureFile != null &&
                                        custSignatureFile != null &&
                                        provider.workDone.text.isNotEmpty) {
                                      dev.log(
                                        'Generating PDF… workDone="${provider.workDone.text}" complaintId=${widget.complaintModel.id} from=${widget.from}',
                                        name: 'SubmitReport',
                                      );
                                      final pdfFile =
                                      await ReportPDF().generate(
                                        widget.complaintModel,
                                        provider.hobbyList,
                                        provider.ctlComplainType.text,
                                        provider.selectedHobby,
                                        provider.reciprocatingList,
                                        provider.screwList,
                                        provider.workDone.text,
                                        provider.custRemark.text,
                                        signatureFile!,
                                        custSignatureFile!,
                                        provider.custName.text,
                                        provider.name.text,
                                        provider.mobileNo.text,
                                        provider.ctlRunningHours.text,
                                        provider.ctlLoadingHours.text,
                                        provider.ctlR.text,
                                        provider.ctlY.text,
                                        provider.ctlB.text,
                                        provider.ctlOilTemp.text,
                                        provider.ctlLoadPressure.text,
                                        provider.ctlUnloadPressure.text,
                                        provider.ctlNextServices.text,
                                        provider.ctlOne.text,
                                        provider.ctlTwo.text,
                                        provider.ctlThree.text,
                                        provider.ctlFour.text,
                                        provider.ctlFive.text,
                                        provider.ctlSix.text,
                                        provider.ctlSeven.text,
                                        provider.ctlEight.text,
                                        provider.AttendBy.text,
                                        provider.FailedOn.text,
                                        provider.technicianRemark.text,
                                        provider.ctlModel.text,
                                        provider.ctl9.text,
                                        provider.ctl10.text,
                                        provider.ctl11.text,
                                        provider.ctl12.text,
                                        provider.ctlEquipmentSrNo.text,
                                        provider.ctlFilledBy.text,
                                      );

                                      dev.log(
                                        'PDF ready: ${pdfFile?.path ?? '(null file)'}',
                                        name: 'SubmitReport',
                                      );
                                      if (pdfFile == null) {
                                        dev.log(
                                          'Abort: PDF was null',
                                          name: 'SubmitReport',
                                        );
                                        return;
                                      }
                                      // Navigator.pushNamed(
                                      //     context, RouteNames.pdfViewerPage,
                                      //     arguments: {"file": pdfFile});

                                      await provider.updateComlain(
                                          context,
                                          pdfFile,
                                          widget.complaintModel,
                                          widget.from);
                                    } else {
                                      dev.log(
                                        'Blocked: workDoneEmpty=${provider.workDone.text.isEmpty} techSig=${signatureFile != null} custSig=${custSignatureFile != null}',
                                        name: 'SubmitReport',
                                      );
                                      if (provider.workDone.text.isEmpty) {
                                        CommonFunctions.showErrorSnackbar(
                                            "Add Work Status of report.");
                                      }
                                      if (signatureFile == null ||
                                          custSignatureFile == null) {
                                        CommonFunctions.showErrorSnackbar(
                                            "technician or customer Signature is missing.");
                                      }
                                    }
                                  },
                                  child: provider.isLoading
                                      ? const CommonButtonLoader(
                                      indicatorColor: whiteColor)
                                      : Text(
                                    "Submit Report",
                                    style: GoogleFonts.poppins(
                                        color: whiteColor),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  Future _uploadSignatureCustomer(
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
          _controllerCustomer.clear();

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
                              controller: _controllerCustomer,
                            ),
                            Positioned(
                                bottom: 10,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    _controllerCustomer.clear();
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
                                var filePath = '$tempPath/signatureTwo.png';
                                return File(filePath).writeAsBytes(
                                    data.buffer.asUint8List(
                                        data.offsetInBytes, data.lengthInBytes),
                                    flush: true);
                              }

                              if (_controllerCustomer.isEmpty) {
                                setState(
                                      () {
                                    signatureMemory = null;
                                  },
                                );
                                Navigator.pop(context);
                              } else {
                                var image = await _controllerCustomer.toImage();
                                final bytes = await image!
                                    .toByteData(format: ui.ImageByteFormat.png);
                                var file = await writeToFile(bytes!);

                                custSignatureMemory =
                                    Image.memory(bytes.buffer.asUint8List());

                                setState(
                                      () {
                                    custSignatureFile = file;
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

class CheckBoxTitleList extends StatelessWidget {
  final String title, from;

  const CheckBoxTitleList({super.key, required this.title, required this.from});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              color: blackColor, borderRadius: BorderRadius.circular(12)),
          child: Text(
            title,
            style: GoogleFonts.poppins(
                color: whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<ComplainDetailProvider>(builder: (context, provider, child) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: from == "rec"
                ? provider.reciprocatingList.length
                : provider.screwList.length,
            itemBuilder: (context, index) {
              var data = from == "rec"
                  ? provider.reciprocatingList[index]
                  : provider.screwList[index];
              return data.title == "RUNNING HOURS"
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged: (isChecked) {
                      provider.onBoxchange(isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    width: size.width * 0.3,
                    child: StepperTextField(
                      controllerValue: provider.ctlRunningHours,
                      inputType: TextInputType.number,
                      hintValue: 'Running Hours',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : data.title == "LOADING HOURS"
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged: (isChecked) {
                      provider.onBoxchange(isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    width: size.width * 0.3,
                    child: StepperTextField(
                      controllerValue: provider.ctlLoadingHours,
                      inputType: TextInputType.number,
                      hintValue: 'Loading Hours',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : data.title == "INCOMING VOLTAGE"
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged: (isChecked) {
                      provider.onBoxchange(
                          isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: StepperTextField(
                            controllerValue: provider.ctlR,
                            inputType: TextInputType.number,
                            hintValue: 'R',
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
                            controllerValue: provider.ctlY,
                            inputType: TextInputType.number,
                            hintValue: 'Y',
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
                            controllerValue: provider.ctlB,
                            inputType: TextInputType.number,
                            hintValue: 'B',
                            validate: (val) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : data.title == "OIL TEMPERATURE"
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged: (isChecked) {
                      provider.onBoxchange(
                          isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    width: size.width * 0.6,
                    child: StepperTextField(
                      controllerValue: provider.ctlOilTemp,
                      inputType: TextInputType.text,
                      hintValue: 'OIL TEMPERATURE',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : data.title == "OIL TEMPERATURE"
                  ? Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged: (isChecked) {
                      provider.onBoxchange(
                          isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin:
                    const EdgeInsets.only(left: 30),
                    width: size.width * 0.6,
                    child: StepperTextField(
                      controllerValue:
                      provider.ctlOilTemp,
                      inputType: TextInputType.text,
                      hintValue: 'OIL TEMPERATURE',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : data.title == "LOADING PRESSURE"
                  ? Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged: (isChecked) {
                      provider.onBoxchange(
                          isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30),
                    width: size.width * 0.6,
                    child: StepperTextField(
                      controllerValue:
                      provider.ctlLoadPressure,
                      inputType: TextInputType.text,
                      hintValue: 'LOADING PRESSURE',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : data.title == "UNLOADING PRESSURE"
                  ? Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged:
                        (isChecked) {
                      provider.onBoxchange(
                          isChecked!, data, from);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30),
                    width: size.width * 0.6,
                    child: StepperTextField(
                      controllerValue: provider
                          .ctlUnloadPressure,
                      inputType:
                      TextInputType.text,
                      hintValue:
                      'UNLOADING PRESSURE',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : data.title == "NEXT SERVICES"
                  ? Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged:
                        (isChecked) {
                      provider.onBoxchange(
                          isChecked!,
                          data,
                          from);
                    },
                  ),
                  Container(
                    margin:
                    const EdgeInsets.only(
                        left: 30),
                    width: size.width * 0.6,
                    child: StepperTextField(
                      controllerValue: provider
                          .ctlNextServices,
                      suf: Column(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .center,
                        children: [
                          Text(
                            "Hrs",
                            style: GoogleFonts
                                .poppins(),
                          ),
                        ],
                      ),
                      inputType:
                      TextInputType.text,
                      hintValue:
                      'NEXT SERVICES',
                      validate: (val) {
                        return null;
                      },
                    ),
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomCheckBoxListItem(
                    item: data,
                    onCheckboxChanged:
                        (isChecked) {
                      provider.onBoxchange(
                          isChecked!,
                          data,
                          from);
                    },
                  ),
                  from != "rec"
                      ? Container(
                    margin:
                    const EdgeInsets
                        .only(
                        left: 30),
                    width: size.width *
                        0.85,
                    child:
                    StepperTextField(
                      controllerValue: data
                          .title ==
                          "AIR FILTER CONDITION IS GOOD AND NO DUST ENTRY"
                          ? provider
                          .ctlOne
                          : data.title ==
                          "DRYER CONDENSER CLEANING/COOLING FLUENCY"
                          ? provider
                          .ctlTwo
                          : data.title ==
                          "DRYER DEW POINT"
                          ? provider
                          .ctlThree
                          : data.title == "MAINTENANCE AS PER RECOMMENDATION"
                          ? provider.ctlFour
                          : data.title == "INSTALLATION AS PER RECOMMENDATION"
                          ? provider.ctlFive
                          : data.title == "LAST SERVICE WORKING HOURS / SERVICES"
                          ? provider.ctlSix
                          : data.title == "NEXT SERVICE WORKING HOURS / SERVICES"
                          ? provider.ctlSeven
                          : provider.ctlEight,
                      inputType:
                      TextInputType
                          .text,
                      hintValue:
                      data.title,
                      validate: (val) {
                        return null;
                      },
                    ),
                  )
                      : const SizedBox()
                ],
              );
            },
          );
        }),
      ],
    );
  }
}