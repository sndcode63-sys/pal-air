import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:airo_tech/Widgets/app_button.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:airo_tech/Widgets/common_button_loader.dart';
import 'package:airo_tech/Widgets/dropdown_widget.dart';
import 'package:airo_tech/Widgets/error_found_widgets.dart';
import 'package:airo_tech/Widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'add_machine_other_provider.dart';

class AddOtherCompanyMachine extends StatefulWidget {
  const AddOtherCompanyMachine({super.key});

  @override
  State<AddOtherCompanyMachine> createState() => _AddOtherCompanyMachineState();
}

class _AddOtherCompanyMachineState extends State<AddOtherCompanyMachine> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
          Provider.of<AddMachineOtherProvider>(context, listen: false);

      provider.intData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: commonAppBar(context: context, heading: "NEW COMPLAIN / AMC"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                elevation: 5,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12))),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: const BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12))),
                        child: Text(
                          "ADD COMPLAIN / AMC FORM",
                          style: GoogleFonts.poppins(
                              color: whiteColor, fontWeight: FontWeight.bold),
                        )),
                    Consumer<AddMachineOtherProvider>(
                        builder: (context, provider, child) {
                      return Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 15),
                          child: Column(
                            children: [
                              StepperTextField(
                                controllerValue: provider.ctlDate,
                                rOnly: true,
                                suf: const Icon(
                                  Icons.calendar_month,
                                  color: blackColor,
                                ),
                                onTap: () {
                                  provider.getDate(context);
                                },
                                hintValue: 'Date',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorDate.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorDate,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlMachineType,
                                onTap: () {
                                  provider.showMultiSelect(context);
                                },
                                rOnly: true,
                                hintValue: 'Machine Type',
                                validate: (val) {
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StepperTextField(
                                          controllerValue:
                                              provider.ctlCompressorMake,
                                          hintValue: 'Make',
                                          validate: (val) {
                                            if (val!.isEmpty) {
                                              return "Field is required.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        provider.errorCompressor.isEmpty
                                            ? Container()
                                            : ErrorText(
                                                error: provider.errorCompressor,
                                                errorColor: Colors.red,
                                              ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StepperTextField(
                                          controllerValue:
                                              provider.ctlCompressorHP,
                                          hintValue: 'HP',
                                          validate: (val) {
                                            if (val!.isEmpty) {
                                              return "Field is required.";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        provider.errorHp.isEmpty
                                            ? Container()
                                            : ErrorText(
                                                error: provider.errorHp,
                                                errorColor: Colors.red,
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlCompName,
                                suf: const Icon(
                                  Icons.business_outlined,
                                  color: blackColor,
                                ),
                                onTap: () {},
                                hintValue: 'Company Name',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorName.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorName,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlAddress,
                                suf: const Icon(
                                  Icons.location_pin,
                                  color: blackColor,
                                ),
                                onTap: () {},
                                inputType: TextInputType.streetAddress,
                                hintValue: 'Address',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorAddress.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorAddress,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlCityName,
                                suf: const Icon(
                                  Icons.location_pin,
                                  color: blackColor,
                                ),
                                inputType: TextInputType.streetAddress,
                                hintValue: 'City Name',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorCity.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorCity,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlContact,
                                suf: const Icon(
                                  CupertinoIcons.phone,
                                  color: blackColor,
                                ),
                                mLength: 10,
                                hintValue: 'Contact No.',
                                inputType: TextInputType.phone,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else if (val.length < 10) {
                                    return "Number should be 10 digit";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorContact.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorContact,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlEmail,
                                suf: const Icon(
                                  CupertinoIcons.mail,
                                  color: blackColor,
                                ),
                                onTap: () {},
                                inputType: TextInputType.emailAddress,
                                hintValue: 'Email',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorEmail.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorEmail,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlContactPerson,
                                suf: const Icon(
                                  CupertinoIcons.person,
                                  color: blackColor,
                                ),
                                onTap: () {},
                                hintValue: 'Contact Person',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.errorContactPerson.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorContactPerson,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              StepperTextField(
                                controllerValue: provider.ctlProductDesc,
                                onTap: () {},
                                hintValue: 'Product Description',
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Field is required.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              provider.prodDesc.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.prodDesc,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              ExpandedDropDownWidget(
                                  labelText: 'Select Complain Or AMC Type',
                                  hintText: "Select Complain Or AMC Type",
                                  dropMenuList: const [
                                    "Complain",
                                    "AMC",
                                  ],
                                  selectedReturnValue: (value) {
                                    provider.changeComplainType(value);
                                  }),
                              provider.errorCatType.isEmpty
                                  ? Container()
                                  : ErrorText(
                                      error: provider.errorCatType,
                                      errorColor: Colors.red,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              provider.ctlAmcType.text.isNotEmpty
                                  ? provider.ctlAmcType.text == "Complain"
                                      ? Column(
                                          children: [
                                            StepperTextField(
                                              controllerValue:
                                                  provider.ctlTechnician,
                                              rOnly: true,
                                              hintValue: 'Technician',
                                              validate: (val) {
                                                return null;
                                              },
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            StepperTextField(
                                              controllerValue:
                                                  provider.ctlComplainDate,
                                              rOnly: true,
                                              suf: const Icon(
                                                Icons.calendar_month,
                                                color: blackColor,
                                              ),
                                              onTap: () {
                                                provider
                                                    .getComplainDate(context);
                                              },
                                              hintValue: 'Complain Date',
                                              validate: (val) {
                                                return null;
                                              },
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ExpandedDropDownWidget(
                                                labelText:
                                                    'Select Complain Type',
                                                hintText:
                                                    "Select Complain Type",
                                                dropMenuList: const [
                                                  "Visit",
                                                  "Machine Observation",
                                                  "Preventive",
                                                  "Head Servicing",
                                                  "BreakDown",
                                                  "AMC",
                                                  "Electric Promblem",
                                                  "Other",
                                                ],
                                                selectedReturnValue: (value) {
                                                  provider.selectComplainType(
                                                      value);
                                                }),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            StepperTextField(
                                              controllerValue:
                                                  provider.ctlComplainDesc,
                                              hintValue: 'Description',
                                              validate: (val) {
                                                return null;
                                              },
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            GridView.builder(
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        mainAxisExtent: 50,
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10.0),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return StepperTextField(
                                                    rOnly: true,
                                                    controllerValue: provider
                                                            .ctlTextControllerList[
                                                        index],
                                                    suf: const Icon(
                                                      Icons.calendar_month,
                                                      color: blackColor,
                                                    ),
                                                    onTap: () {
                                                      provider.onClickAmcDate(
                                                          index, context);
                                                    },
                                                    hintValue:
                                                        'AMC Date-${index + 1}',
                                                    validate: (val) {
                                                      return null;
                                                    },
                                                  );
                                                },
                                                itemCount: provider
                                                    .ctlTextControllerList
                                                    .length),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            StepperTextField(
                                              controllerValue:
                                                  provider.ctlAMCDesc,
                                              onTap: () {},
                                              hintValue: 'AMC Description',
                                              validate: (val) {
                                                return null;
                                              },
                                            ),
                                          ],
                                        )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              AppButton(
                                btnTitle: provider.isBtnLoading
                                    ? const CommonButtonLoader(
                                        indicatorColor: whiteColor)
                                    : Text(
                                        'Submit',
                                        style: GoogleFonts.poppins(
                                            color: whiteColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                onTap: provider.isBtnLoading
                                    ? null
                                    : () {
                                        final isValid =
                                            _formKey.currentState!.validate();

                                        if (!isValid) {
                                          return;
                                        }

                                        _formKey.currentState!.save();
                                        if (provider
                                            .ctlAmcType.text.isNotEmpty) {
                                          provider.addNewComlain(context);
                                        } else {
                                          CommonFunctions.showErrorSnackbar(
                                              "Select Complain Or AMC Type");
                                        }
                                      },
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
