import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utils/appcolors.dart';
import '../../Utils/common_functions.dart';
import '../../Widgets/input_fields.dart';
import '../MyComplains/Components/complaint_view.dart';
import '../NewMachineDispatch/machine_dispatch_provider.dart';
import '../NewMachineDispatch/machine_dispatch_repository.dart';
import 'installation_model.dart';
import 'installation_provider.dart';
import 'installation_repository.dart';

class InstallationDispatchView extends StatefulWidget {
  final int index;
  final InstallationModel model;

  const InstallationDispatchView({
    super.key,
    required this.index,
    required this.model,
  });

  @override
  State<InstallationDispatchView> createState() =>
      _InstallationDispatchViewState();
}

class _InstallationDispatchViewState extends State<InstallationDispatchView> {
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
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Action",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                        fontSize: 12),
                  ),
                  _action(context)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MultiOrderDetailHelper(
                  heading: "MID",
                  value: widget.model.id!,
                ),
                MultiOrderDetailHelper(
                  heading: "Status",
                  value: widget.model.status!,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            MultiOrderDetailHelper(
              heading: "Date Of Installation",
              value: CommonFunctions().returnAppDateFormat(widget.model.date!),
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Assigned To",
              value: widget.model.fullName!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Client Name",
              value: widget.model.clientName!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Mobile",
              value: widget.model.mobile!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Dispatch\nLocation",
              value: widget.model.dispatchLocation!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Person",
              value: widget.model.installationPerson!,
            ),
          ],
        ),
      ),
    );
  }

  final List<TextEditingController> _ctlTextControllerList =
      List.generate(12, (i) => TextEditingController());

  void onClickAmcDate(int index, BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != DateTime.now()) {
      String formattedDate = "${picked!.year}-${picked.month}-${picked.day}";
      _ctlTextControllerList[index].text = formattedDate;
    }

    setState(() {});
  }

  _action(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(
          Icons.expand_more,
          color: blackColor,
          size: 20,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          for (var e in _ctlTextControllerList) {
                            e.clear();
                          }
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)),
                            title: Text(
                              'PREVENTIVE TYPE',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: blackColor),
                              textAlign: TextAlign.center,
                            ),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 3,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisExtent: 50,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10.0),
                                  itemBuilder: (context, index) {
                                    return StepperTextField(
                                      rOnly: true,
                                      controllerValue:
                                          _ctlTextControllerList[index],
                                      suf: const Icon(
                                        Icons.calendar_month,
                                        color: blackColor,
                                      ),
                                      onTap: () {
                                        onClickAmcDate(index, context);
                                      },
                                      hintValue: 'Preventive Date-${index + 1}',
                                      validate: (val) {
                                        return null;
                                      },
                                    );
                                  },
                                  itemCount: _ctlTextControllerList.length),
                            ),
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
                                        style: GoogleFonts.poppins(
                                            color: whiteColor),
                                      )),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor),
                                      onPressed: () {
                                        installationDoneHold(context);
                                      },
                                      child: Text(
                                        'Yes',
                                        style: GoogleFonts.poppins(
                                            color: whiteColor),
                                      ))
                                ],
                              ),
                            ],
                          );
                        });
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.pencil_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Installation Done",
                      style: GoogleFonts.poppins(
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () => statusChangeHold(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.pencil_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Holding",
                      style: GoogleFonts.poppins(
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ]);
  }

  InstallationRepository installationRepository = InstallationRepository();

  Future statusChangeHold(BuildContext context) async {
    var read = context.read<InstallationProvider>();
    var passedData = json.encode({"id": widget.model.id, "status": "Holding"});
    var result =
        await installationRepository.updateHoldingStatus(context, passedData);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) {
      read.getInstallationList(context);
    });
  }

  Future installationDoneHold(
    BuildContext context,
  ) async {
    var read = context.read<InstallationProvider>();

    var passedData = json.encode({
      "id": widget.model.id,
      "status": "Installation Done",
      "date1":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[0].text),
      "date2":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[1].text),
      "date3":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[2].text),
      "date4":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[3].text),
      "date5":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[4].text),
      "date6":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[5].text),
      "date7":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[6].text),
      "date8":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[7].text),
      "date9":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[8].text),
      "date10":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[9].text),
      "date11": CommonFunctions()
          .returnAPiDateFormat(_ctlTextControllerList[10].text),
      "date12":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[11].text)
    });
    Navigator.pop(context);
    var result =
        await installationRepository.updateHoldingStatus(context, passedData);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) {
      read.getInstallationList(context);
    });
  }
}

class NewMachineDispatchView extends StatefulWidget {
  final int index;
  final InstallationModel model;
  const NewMachineDispatchView(
      {super.key, required this.index, required this.model});

  @override
  State<NewMachineDispatchView> createState() => _NewMachineDispatchViewState();
}

class _NewMachineDispatchViewState extends State<NewMachineDispatchView> {
  MachineDispatchRepository machineDispatchRepository =
      MachineDispatchRepository();
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
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Action",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                        fontSize: 12),
                  ),
                  _action(context)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MultiOrderDetailHelper(
                  heading: "MID",
                  value: widget.model.id!,
                ),
                MultiOrderDetailHelper(
                  heading: "Status",
                  value: widget.model.status!,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            MultiOrderDetailHelper(
              heading: "Date Of Installation",
              value: CommonFunctions().returnAppDateFormat(widget.model.date!),
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Assigned To",
              value: widget.model.fullName!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Client Name",
              value: widget.model.clientName!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Mobile",
              value: widget.model.mobile!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Dispatch\nLocation",
              value: widget.model.dispatchLocation!,
            ),
            const SizedBox(
              height: 5,
            ),
            OrderDetailHelper(
              heading: "Person",
              value: widget.model.installationPerson!,
            ),
          ],
        ),
      ),
    );
  }

  Future statusChangeHold(BuildContext context, String person) async {
    var read = context.read<MachineDispatchProvider>();
    var passedData = json.encode({
      "id": widget.model.id,
      "installation_person": person,
      "status": "Send Installation"
    });
    Navigator.pop(context);
    var result =
        await machineDispatchRepository.sendInstallation(context, passedData);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) {
      read.getMachineDipatchList(context);
    });
  }

  _action(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: const Icon(
          Icons.expand_more,
          color: blackColor,
          size: 20,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          GlobalKey<FormState> formKey = GlobalKey();
                          TextEditingController installationPerson =
                              TextEditingController();
                          return Form(
                            key: formKey,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12)),
                              title: Text(
                                'INSTALLATION PROCESS',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: blackColor),
                                textAlign: TextAlign.center,
                              ),
                              content: StepperTextField(
                                controllerValue: installationPerson,
                                hintValue: 'Installation Person',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "required*";
                                  }
                                  return null;
                                },
                              ),
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
                                          style: GoogleFonts.poppins(
                                              color: whiteColor),
                                        )),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor),
                                        onPressed: () {
                                          final isValid =
                                              formKey.currentState!.validate();

                                          if (!isValid) {
                                            return;
                                          }
                                          statusChangeHold(
                                              context, installationPerson.text);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: GoogleFonts.poppins(
                                              color: whiteColor),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.pencil_circle,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Send Installation",
                      style: GoogleFonts.poppins(
                          color: blackColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ]);
  }
}
