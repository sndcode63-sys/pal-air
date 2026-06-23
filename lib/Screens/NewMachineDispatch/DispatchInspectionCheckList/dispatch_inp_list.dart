import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:airo_tech/Widgets/common_button_loader.dart';
import 'package:airo_tech/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dispatch_inp_list_provider.dart';

class DispatchInspectionListScreen extends StatefulWidget {
  const DispatchInspectionListScreen({super.key});

  @override
  State<DispatchInspectionListScreen> createState() =>
      _DispatchInspectionListScreenState();
}

class _DispatchInspectionListScreenState
    extends State<DispatchInspectionListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
          Provider.of<DispatchInpectionListProvider>(context, listen: false);
      provider.initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: commonAppBar(
            context: context, heading: "DISPACH INSPECTION CHECKLIST"),
        body: Consumer<DispatchInpectionListProvider>(
            builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StepperTextField(
                              controllerValue: provider.ctlPiNum,
                              hintValue: 'PI No',
                              inputType: TextInputType.text,
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
                              controllerValue: provider.ctlDate,
                              hintValue: 'Date',
                              rOnly: true,
                              inputType: TextInputType.text,
                              onTap: () => provider.geDate(context),
                              validate: (val) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StepperTextField(
                        controllerValue: provider.ctlModelNum,
                        hintValue: 'Model No.',
                        inputType: TextInputType.text,
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StepperTextField(
                        controllerValue: provider.ctlClientName,
                        hintValue: 'Client Name',
                        inputType: TextInputType.text,
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
                            child: StepperTextField(
                              controllerValue: provider.ctlHP,
                              hintValue: 'HP',
                              inputType: TextInputType.text,
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
                              controllerValue: provider.ctlMO,
                              hintValue: 'Mobile',
                              mLength: 10,
                              inputType: TextInputType.text,
                              validate: (val) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StepperTextField(
                        controllerValue: provider.ctlDispatchLoc,
                        hintValue: 'Dispatch Location',
                        inputType: TextInputType.text,
                        actionNext: TextInputAction.next,
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: whiteColor,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 1,
                                color: blackColor,
                              );
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = provider.dispatchInspectList[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Sr. No.	${index + 1}',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Spacer(),
                                        Text(
                                          'Tick Mark',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Checkbox(
                                            value: data.isSelected,
                                            onChanged: (val) {
                                              provider.toggleProduct(
                                                  data, val!);
                                            }),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: DispatchInspTextField(
                                            hint: "Brand",
                                            controllerValue: data.brandName,
                                            onTap: () {},
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: DispatchInspTextField(
                                            hint: "Components",
                                            controllerValue: data.components,
                                            onTap: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DispatchInspTextField(
                                      hint: "Description",
                                      textAlignment: TextAlign.start,
                                      controllerValue: data.description,
                                      onTap: () {},
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DispatchInspTextField(
                                      hint: "Nos",
                                      textAlignment: TextAlign.start,
                                      controllerValue: data.nos,
                                      onTap: () {},
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: provider.dispatchInspectList.length),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Column(
                    children: [
                      StepperTextField(
                        controllerValue: provider.ctlCheckedPersonName,
                        hintValue: 'Checked Person Name:',
                        inputType: TextInputType.text,
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StepperTextField(
                        controllerValue: provider.ctlSuperVisorSign,
                        hintValue: 'Supervisor Sign:',
                        inputType: TextInputType.text,
                        validate: (val) {
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StepperTextField(
                        controllerValue: provider.ctlRemarkIfAny,
                        hintValue: 'Remark If Any:',
                        inputType: TextInputType.text,
                        validate: (val) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: provider.isBtnLoading
                      ? null
                      : () {
                          provider.submitAndDispatch(context);
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: primaryColor),
                    child: provider.isBtnLoading
                        ? const CommonButtonLoader(indicatorColor: whiteColor)
                        : Text(
                            "Submit & Dispatch",
                            style: GoogleFonts.poppins(color: whiteColor),
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
