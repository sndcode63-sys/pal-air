import 'dart:convert';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/appcolors.dart';
import '../../../Utils/common_functions.dart';
import '../../../Utils/route_names.dart';
import '../../../Widgets/common_button_loader.dart';
import '../../Auth/technician_model.dart';
import '../complaint_model.dart';
import '../complaint_repository.dart';
import 'helper_models.dart';

class ComplainDetailProvider with ChangeNotifier {
  ComplaintRepository complaintRepository = ComplaintRepository();
  final TextEditingController _workDone = TextEditingController();
  TextEditingController get workDone => _workDone;

  final TextEditingController _ctlRunningHours = TextEditingController();
  TextEditingController get ctlRunningHours => _ctlRunningHours;

  final TextEditingController _ctlLoadingHours = TextEditingController();
  TextEditingController get ctlLoadingHours => _ctlLoadingHours;

  final TextEditingController _ctlR = TextEditingController();
  TextEditingController get ctlR => _ctlR;

  final TextEditingController _ctlY = TextEditingController();
  TextEditingController get ctlY => _ctlY;

  final TextEditingController _ctlB = TextEditingController();
  TextEditingController get ctlB => _ctlB;

  final TextEditingController _ctlOilTemp = TextEditingController();
  TextEditingController get ctlOilTemp => _ctlOilTemp;

  final TextEditingController _ctlLoadPressure = TextEditingController();
  TextEditingController get ctlLoadPressure => _ctlLoadPressure;

  final TextEditingController _ctlUnloadPressure = TextEditingController();
  TextEditingController get ctlUnloadPressure => _ctlUnloadPressure;

  final TextEditingController _ctlNextServices = TextEditingController();
  TextEditingController get ctlNextServices => _ctlNextServices;

  final TextEditingController _ctlOne = TextEditingController();
  TextEditingController get ctlOne => _ctlOne;

  final TextEditingController _ctlTwo = TextEditingController();
  TextEditingController get ctlTwo => _ctlTwo;

  final TextEditingController _ctlThree = TextEditingController();
  TextEditingController get ctlThree => _ctlThree;

  final TextEditingController _ctlFour = TextEditingController();
  TextEditingController get ctlFour => _ctlFour;
  final TextEditingController _ctlFive = TextEditingController();
  TextEditingController get ctlFive => _ctlFive;
  final TextEditingController _ctlSix = TextEditingController();
  TextEditingController get ctlSix => _ctlSix;
  final TextEditingController _ctlSeven = TextEditingController();
  TextEditingController get ctlSeven => _ctlSeven;
  final TextEditingController _ctlEight = TextEditingController();
  TextEditingController get ctlEight => _ctlEight;

  final TextEditingController _ctl9 = TextEditingController();
  TextEditingController get ctl9 => _ctl9;

  final TextEditingController _ctl10 = TextEditingController();
  TextEditingController get ctl10 => _ctl10;

  final TextEditingController _ctl11 = TextEditingController();
  TextEditingController get ctl11 => _ctl11;

  final TextEditingController _ctl12 = TextEditingController();
  TextEditingController get ctl12 => _ctl12;

  final TextEditingController _ctlModel = TextEditingController();
  TextEditingController get ctlModel => _ctlModel;

  final TextEditingController _ctlEquipmentSrNo = TextEditingController();
  TextEditingController get ctlEquipmentSrNo => _ctlEquipmentSrNo;
  final TextEditingController _ctlFilledBy = TextEditingController();
  TextEditingController get ctlFilledBy => _ctlFilledBy;
  final TextEditingController _ctlAttendBy = TextEditingController();
  TextEditingController get AttendBy => _ctlAttendBy;
  final TextEditingController _ctlFailedOn = TextEditingController();
  TextEditingController get FailedOn => _ctlFailedOn;
  final TextEditingController _ctlComplainType = TextEditingController();
  TextEditingController get ctlComplainType => _ctlComplainType;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  loadingFun(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final TextEditingController _custRemark = TextEditingController();
  TextEditingController get custRemark => _custRemark;
  final TextEditingController _technicianRemark = TextEditingController();
  TextEditingController get technicianRemark => _technicianRemark;

  final TextEditingController _custName = TextEditingController();
  TextEditingController get custName => _custName;

  final TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  final TextEditingController _mobileNo = TextEditingController();
  TextEditingController get mobileNo => _mobileNo;

  TechnicianModel _technicianModel = TechnicianModel();
  TechnicianModel get technicianModel => _technicianModel;
  initData(ComplaintModel complaintModel) async {
    faildOnDate = null;
    _isLoading = false;
    _selectedHobby.clear();
    _ctlRunningHours.clear();
    _ctlLoadPressure.clear();
    _ctlUnloadPressure.clear();
    _ctlNextServices.clear();
    _ctlOne.clear();
    _ctlTwo.clear();
    _ctlThree.clear();
    _ctlFour.clear();
    _ctlFive.clear();
    _ctlSix.clear();
    _ctlSeven.clear();
    _ctlEight.clear();
    _ctl9.clear();
    _ctl10.clear();
    _ctl11.clear();
    _ctl11.clear();
    _ctlModel.clear();
    _ctlEquipmentSrNo.clear();
    _ctlFilledBy.clear();
    _ctlR.clear();
    _ctlY.clear();
    _ctlB.clear();
    _ctlOilTemp.clear();
    _technicianModel = TechnicianModel();
    _name.clear();
    _mobileNo.clear();
    _ctlComplainType.clear();
    _ctlAttendBy.clear();
    _ctlFailedOn.clear();
    _technicianRemark.clear();
    _custName.clear();
    _custRemark.clear();
    _workDone.clear();
    _custName.text = complaintModel.companyName!;
    _mobileNo.text = complaintModel.contact ?? "";
    _ctlEquipmentSrNo.text = complaintModel.id!;
    _technicianModel = await CommonFunctions().getProfileData();
    _reciprocatingList = [
      ReciprocatingModel(
          title: 'AIR FILTER ELEMENT/CLEANING', isSelected: false),
      ReciprocatingModel(title: 'CRANK CASE CLEAN', isSelected: false),
      ReciprocatingModel(title: 'VALVE PLATE CLEAN CHANGE', isSelected: false),
      ReciprocatingModel(
          title: 'OIL LEVEL CHECK &amp; TOP UP/ NEW', isSelected: false),
      ReciprocatingModel(title: "'V'BELT TENSION CHECK", isSelected: false),
      ReciprocatingModel(title: 'PILOT VALVE CHECK/CHANGE', isSelected: false),
      ReciprocatingModel(
          title: 'INTER COOL SAFETY VALVE CHECK/CHANGE', isSelected: false),
      ReciprocatingModel(
          title: 'ROTATION DIRECTION OF PULLY', isSelected: false),
      ReciprocatingModel(
          title: 'ALL BOLT ARE TIGHTNESS/CHECK', isSelected: false),
      ReciprocatingModel(
          title: 'AIR RECEIVER TANK SAFETY VALVE/P.G/P.S', isSelected: false),
      ReciprocatingModel(
          title: 'WATER DRAIN VALVE OPERATING', isSelected: false),
      ReciprocatingModel(
          title: 'HEAD SERVICING / TOTALLY OVER HOLDING WORK',
          isSelected: false),
      ReciprocatingModel(title: 'BLOW OF AIR', isSelected: false),
      ReciprocatingModel(title: 'N.R.V', isSelected: false),
      ReciprocatingModel(title: 'Others', isSelected: false),
    ];

    _screwList = [
      ReciprocatingModel(
          title: 'AIR FILTER CONDITION IS GOOD AND NO DUST ENTRY',
          isSelected: false),
      ReciprocatingModel(
          title: 'DRYER CONDENSER CLEANING/COOLING FLUENCY', isSelected: false),
      ReciprocatingModel(title: 'DRYER DEW POINT', isSelected: false),
      ReciprocatingModel(
          title: 'MAINTENANCE AS PER RECOMMENDATION', isSelected: false),
      ReciprocatingModel(
          title: "INSTALLATION AS PER RECOMMENDATION", isSelected: false),
      ReciprocatingModel(
          title: 'LAST SERVICE WORKING HOURS / SERVICES', isSelected: false),
      ReciprocatingModel(
          title: 'NEXT SERVICE WORKING HOURS / SERVICES', isSelected: false),
      ReciprocatingModel(title: 'RUNNING HOURS', isSelected: false),
      ReciprocatingModel(title: 'LOADING HOURS', isSelected: false),
      ReciprocatingModel(title: 'INCOMING VOLTAGE', isSelected: false),
      ReciprocatingModel(
          title: 'LINE CURRENT MEASURED FULL LOAD / UNLOAD', isSelected: false),
      ReciprocatingModel(title: 'OIL TEMPERATURE', isSelected: false),
      ReciprocatingModel(title: 'LOADING PRESSURE', isSelected: false),
      ReciprocatingModel(title: 'UNLOADING PRESSURE', isSelected: false),
      ReciprocatingModel(title: 'Others', isSelected: false),
    ];
    notifyListeners();
  }

  List<String> get hobbyList => [
        'Observation',
        'Preventive',
        'BreakDown',
        "Others",
        'Service',
        "Compressor Installation",
        "Air Dryer Installation",
      ];

  List<ReciprocatingModel> _reciprocatingList = [];
  List<ReciprocatingModel> get reciprocatingList => [..._reciprocatingList];

  List<ReciprocatingModel> _screwList = [];
  List<ReciprocatingModel> get screwList => [..._screwList];

  final List<String> _selectedHobby = [];
  List<String> get selectedHobby => [..._selectedHobby];

  changeSelectedHobby(
      String hobby, ComplaintModel complaintModel, String from) {
    if (!_selectedHobby.contains(hobby)) {
      if (hobby == "Observation") {
        showDialog(
          context: CommonFunctions.globalContext,
          builder: (context) {
            String? type;
            return StatefulBuilder(builder: (context, StateSetter setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  'Select Report Type',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                content: Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          'Service',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        value: 'service',
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: false,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          'Sales',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        value: 'sales',
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (type != null && type!.isNotEmpty) {
                                if (type == "service") {
                                  Navigator.pop(context);
                                  _selectedHobby.add(hobby);

                                  updateComlainReportType(
                                      context, complaintModel, from, "Service");
                                } else {
                                  updateComlainReportType(
                                      context, complaintModel, from, "Sales");
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop()
                                    ..pushNamed(
                                        RouteNames.complainSalesDetailScreen,
                                        arguments: {
                                          "complaintModel": complaintModel,
                                        });
                                }
                              } else {
                                CommonFunctions.showErrorSnackbar(
                                    "Select Report Type");
                              }
                            },
                      child: isLoading
                          ? const CommonButtonLoader(indicatorColor: whiteColor)
                          : Text(
                              'Yes',
                              style: GoogleFonts.poppins(color: whiteColor),
                            ))
                ],
              );
            });
          },
        );
      } else {
        _selectedHobby.add(hobby);
      }
    } else {
      _selectedHobby.removeWhere((element) => element == hobby);
    }
    notifyListeners();
  }

  void onBoxchange(bool val, ReciprocatingModel reciprocatingModel, from) {
    reciprocatingModel.isSelected = val;

    notifyListeners();
  }

  void onChangeWorkStatus(String status) {
    _workDone.text = status;

    notifyListeners();
  }

  Future updateComlainReportType(BuildContext context,
      ComplaintModel complaintModel, String from, String type) async {
    var passedData = json.encode({
      "report_type": type,
      "id": complaintModel.id,
    });

    dynamic result;

    if (from == "Other") {
      result =
          await complaintRepository.updateOtherReportType(context, passedData);
    } else {
      result = await complaintRepository.updateAerotechReportType(
          context, passedData);
    }

    result.fold((error) {
      loadingFun(false);
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) async {
      if (data != null) {
        if (data.statusCode == 400) {
        } else if (data.statusCode == 200) {}
      }
      notifyListeners();
    });
  }

  DateTime? faildOnDate;
  Future<void> geDate(BuildContext context) async {
    List pickedDate =
        await CommonFunctions().pickDate(context, faildOnDate, null);

    //String failedOnDate = pickedDate[0] == "null" ? "" : pickedDate[0];
    faildOnDate = pickedDate[1];
    notifyListeners();
  }

  String _checkoutResponseMessage(dynamic data) {
    if (data == null) return '';
    if (data is String) {
      try {
        final m = json.decode(data) as Map<String, dynamic>;
        return (m['message'] ?? m['notification'] ?? '').toString();
      } catch (_) {
        return data;
      }
    }
    if (data is Map) {
      return (data['message'] ?? data['notification'] ?? '').toString();
    }
    return data.toString();
  }

  Future updateComlain(BuildContext context, var pdfFile,
      ComplaintModel complaintModel, String from) async {
    try {
      dev.log(
        'updateComlain start: id=${complaintModel.id} from=$from isWorkDone=${_workDone.text == "Work Done"} remark=${_workDone.text}',
        name: 'SubmitReport',
      );
      loadingFun(true);

      dynamic positionData;
      String address = "";
      final isWorkDone = _workDone.text == "Work Done";

      if (isWorkDone) {
        positionData = await CommonFunctions().getLatLong();
        if (positionData == "error") {
          dev.log('Location permission / error — aborting',
              name: 'SubmitReport');
          return;
        }
        address = await CommonFunctions().getCurrentAddressByLatLong(
            positionData.latitude, positionData.longitude);
        dev.log(
          'Geocode ok: address length=${address.length}',
          name: 'SubmitReport',
        );
      } else {
        dev.log('Skipping location (not Work Done)', name: 'SubmitReport');
      }

      final FormData passedData;

      if (isWorkDone) {
        passedData = FormData.fromMap({
          "work_remark": "Work Done",
          "id": complaintModel.id,
          "latitude1": "${positionData.latitude}#${positionData.longitude}",
          "longitude1": address,
          "pdf": await MultipartFile.fromFile(
            pdfFile.path,
          ),
          "checkOut": CommonFunctions().returnCurrentTime()
        });
      } else {
        passedData = FormData.fromMap({
          "work_remark": _workDone.text,
          "id": complaintModel.id,
          "latitude1": "",
          "longitude1": "",
          "pdf": await MultipartFile.fromFile(
            pdfFile.path,
          ),
          "checkOut": ""
        });
      }

      final endpoint = from == "Other"
          ? 'proceed-other-checkout'
          : 'proceed-airotech-checkout';
      dev.log('POST checkout: $endpoint', name: 'SubmitReport');

      final result = from == "Other"
          ? await complaintRepository.updateCheckOut(context, passedData)
          : await complaintRepository.updateAerotechCheckOut(
              context, passedData);

      result.fold((error) {
        dev.log(
          'API Left (failure): ${error?.message} code=${error.statusCode}',
          name: 'SubmitReport',
        );
        CommonFunctions.showErrorSnackbar(error.message);
      }, (data) {
        if (data is Response) {
          final code = data.statusCode;
          dev.log(
            'API Right: status=$code dataType=${data.data.runtimeType}',
            name: 'SubmitReport',
          );
          if (code == 200) {
            CommonFunctions.showSuccessSnackbar("Complaint Submitted");
            if (context.mounted) {
              Navigator.pushNamed(context, RouteNames.pdfViewerPage,
                  arguments: {"file": pdfFile});
            }
            dev.log('Success — navigating to PDF viewer', name: 'SubmitReport');
          } else if (code == 400) {
            final msg = _checkoutResponseMessage(data.data);
            dev.log('HTTP 400 body: $msg', name: 'SubmitReport');
            CommonFunctions.showErrorSnackbar(
                msg.isEmpty ? 'Could not submit report' : msg);
          } else {
            dev.log('Unexpected HTTP $code', name: 'SubmitReport');
            CommonFunctions.showErrorSnackbar(
                'Server error (${code ?? "unknown"})');
          }
        } else {
          dev.log('API Right: unexpected type ${data.runtimeType}',
              name: 'SubmitReport');
          CommonFunctions.showErrorSnackbar('Unexpected response from server');
        }
        notifyListeners();
      });
    } catch (e, st) {
      dev.log(
        'updateComlain exception: $e',
        name: 'SubmitReport',
        stackTrace: st,
      );
      CommonFunctions.showErrorSnackbar(e.toString());
    } finally {
      loadingFun(false);
      dev.log('updateComlain finished (loading cleared)', name: 'SubmitReport');
    }
  }
}
