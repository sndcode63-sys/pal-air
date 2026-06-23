import 'dart:async';
import 'dart:convert';

import 'package:airo_tech/Screens/MyComplains/ManageAeroTech/manage_aero_tech_machine_provider.dart';
import 'package:airo_tech/Screens/MyComplains/OtherCompany/other_company_machine_provider.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_model.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_repository.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:airo_tech/Utils/route_names.dart';
import 'package:airo_tech/Widgets/common_button_loader.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ComplaintView extends StatefulWidget {
  final String from;
  final int index;
  final ComplaintModel complaint;
  const ComplaintView(
      {super.key,
      required this.complaint,
      required this.index,
      required this.from});

  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {
  navigateToDetail() async {
    await Navigator.pushNamed(context, RouteNames.complainDetailScreen,
        arguments: {
          "complaintModel": widget.complaint,
          "from": widget.from
        }).then(onRefresh);
  }

  navigateToSalesDetail() async {
    await Navigator.pushNamed(context, RouteNames.complainSalesDetailScreen,
        arguments: {
          "complaintModel": widget.complaint,
        }).then(onRefresh);
  }

  FutureOr onRefresh(dynamic value) {
    if (widget.from == "AeroTech") {
      var read = context.read<ManageAeroTechMachineProvider>();
      read.getComplaintList(context);
    } else {
      var read = context.read<OtherCompanyMachineProvider>();
      read.getComplaintList(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: blackColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MultiOrderDetailHelper(
                  heading: "S/n",
                  value: "${widget.index + 1}",
                ),
                MultiOrderDetailHelper(
                  heading: "Remark",
                  value: widget.complaint.workRemark!,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MultiOrderDetailHelper(
                  heading: "Date",
                  value: CommonFunctions()
                      .returnAppDateFormat(widget.complaint.date!),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            widget.from == "History"
                ? const SizedBox()
                : OrderDetailHelper(
                    heading: "Assigned To",
                    value: widget.complaint.assignToName!,
                  ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Company",
              value: widget.complaint.companyName!,
            ),
            const SizedBox(
              height: 5,
            ),
            widget.from == "History"
                ? const SizedBox()
                : OrderDetailHelper(
                    heading: "Contact No",
                    value: widget.complaint.contact!,
                  ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Contact Person",
              value: widget.complaint.contactPerson!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "City Name",
              value: widget.complaint.city!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Complaint",
              value: widget.complaint.complainType!,
            ),
            const SizedBox(
              height: 5,
            ),
            widget.from == "History"
                ? const SizedBox()
                : widget.complaint.checkIn!.isEmpty
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    // String? type;
                                    bool isLoading = false;
                                    return StatefulBuilder(builder:
                                        (context, StateSetter setState) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),

                                        title: Text(
                                          'Are you sure you want to proceed. ??',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        // content: const Text('FilerBackDrop'),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        // content: Column(
                                        //   mainAxisSize: MainAxisSize.min,
                                        //   children: [
                                        //     Text(
                                        //       'Select Report type.',
                                        //       textAlign: TextAlign.center,
                                        //       style: GoogleFonts.poppins(
                                        //           color: primaryColor,
                                        //           fontWeight: FontWeight.bold),
                                        //     ),
                                        //     Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: RadioListTile(
                                        //             contentPadding:
                                        //                 EdgeInsets.zero,
                                        //             dense: false,
                                        //             visualDensity:
                                        //                 VisualDensity.compact,
                                        //             title: Text(
                                        //               'Service',
                                        //               style:
                                        //                   GoogleFonts.poppins(
                                        //                       fontWeight:
                                        //                           FontWeight
                                        //                               .w500),
                                        //             ),
                                        //             value: 'service',
                                        //             groupValue: type,
                                        //             onChanged: (value) {
                                        //               setState(() {
                                        //                 type = value;
                                        //               });
                                        //             },
                                        //           ),
                                        //         ),
                                        //         Expanded(
                                        //           child: RadioListTile(
                                        //             contentPadding:
                                        //                 EdgeInsets.zero,
                                        //             dense: false,
                                        //             visualDensity:
                                        //                 VisualDensity.compact,
                                        //             title: Text(
                                        //               'Sales',
                                        //               style:
                                        //                   GoogleFonts.poppins(
                                        //                       fontWeight:
                                        //                           FontWeight
                                        //                               .w500),
                                        //             ),
                                        //             value: 'sales',
                                        //             groupValue: type,
                                        //             onChanged: (value) {
                                        //               setState(() {
                                        //                 type = value;
                                        //               });
                                        //             },
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              primaryColor),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: GoogleFonts.poppins(
                                                        color: whiteColor),
                                                  )),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              primaryColor),
                                                  onPressed: isLoading
                                                      ? null
                                                      : () {
                                                          // if (type != null &&
                                                          //     type!
                                                          //         .isNotEmpty) {
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          updateComlain(
                                                            context,
                                                            widget.complaint,
                                                            widget.from,
                                                          ).then((value) {
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                          });
                                                          // } else {
                                                          //   CommonFunctions
                                                          //       .showErrorSnackbar(
                                                          //           "Select Report Type");
                                                          // }
                                                        },
                                                  child: isLoading
                                                      ? const CommonButtonLoader(
                                                          indicatorColor:
                                                              whiteColor)
                                                      : Text(
                                                          'Yes',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color:
                                                                      whiteColor),
                                                        ))
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                                  });
                            },
                            child: Text(
                              'Proceed',
                              style: GoogleFonts.poppins(color: whiteColor),
                            )))
                    : InkWell(
                        // onTap: () => navigateToSalesDetail(),
                        onTap: () {
                          if (widget.complaint.reportType!.isNotEmpty) {
                            if (widget.complaint.reportType == "Sales") {
                              navigateToSalesDetail();
                            } else {
                              navigateToDetail();
                            }
                          } else {
                            navigateToDetail();
                          }
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "In Progress",
                                speed: const Duration(milliseconds: 150),
                                textStyle: const TextStyle(
                                  color: whiteColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            displayFullTextOnTap: true,
                            stopPauseOnTap: false,
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }

  Future updateComlain(
    BuildContext context,
    ComplaintModel model,
    String from,
  ) async {
    ComplaintRepository complaintRepository = ComplaintRepository();

    final data = await CommonFunctions().getLatLong();

    if (data == "error") {
      if (context.mounted) Navigator.pop(context);
      return;
    }

    final address = await CommonFunctions()
        .getCurrentAddressByLatLong(data.latitude, data.longitude);

    var passedData = json.encode({
      "id": model.id,
      "latitude": "${data.latitude}#${data.longitude}",
      "longitude": address,
      "checkIn": CommonFunctions().returnCurrentTime()
    });

    dynamic result;
    if (from == "Other") {
      result =
          await complaintRepository.updateOtherCheckin(context, passedData);
    } else {
      result =
          await complaintRepository.updateAerotechCheckin(context, passedData);
    }

    result.fold((error) {
      Navigator.pop(context);
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) async {
      if (data != null) {
        // var responseJson = json.decode(data.body);

        if (data.statusCode == 400) {
          Navigator.pop(context);
        } else if (data.statusCode == 200) {
          Navigator.pop(context);
          navigateToDetail();
        }
      }
    });
  }
}

class OrderDetailHelper extends StatelessWidget {
  final String heading, value;

  const OrderDetailHelper({
    super.key,
    required this.heading,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.poppins(
              fontSize: 13, fontWeight: FontWeight.bold, color: blackColor),
        ),
        Text(
          " :",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: blackColor),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
                fontSize: 12.5, fontWeight: FontWeight.w500, color: blackColor),
          ),
        ),
      ],
    );
  }
}

class MultiOrderDetailHelper extends StatelessWidget {
  final String heading, value;

  const MultiOrderDetailHelper({
    super.key,
    required this.heading,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          heading,
          style: GoogleFonts.poppins(
              fontSize: 13, fontWeight: FontWeight.bold, color: blackColor),
        ),
        Text(
          ":",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w500, color: blackColor),
        ),
      ],
    );
  }
}
