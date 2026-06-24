import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../Utils/common_functions.dart';
import '../../Auth/technician_model.dart';
import '../machine_dispatch_repository.dart';
import 'dispatch_insp_model.dart';

class DispatchInpectionListProvider with ChangeNotifier {
  MachineDispatchRepository machineDispatchRepository =
      MachineDispatchRepository();

  bool _isLoading = false;
  bool get isLaoding => _isLoading;

  loadingFun(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool _isBtnLoading = false;
  bool get isBtnLoading => _isBtnLoading;

  loadingBtnFun(bool val) {
    _isBtnLoading = val;
    notifyListeners();
  }

  final TextEditingController _ctlPiNum = TextEditingController();
  TextEditingController get ctlPiNum => _ctlPiNum;

  final TextEditingController _ctlDate = TextEditingController();
  TextEditingController get ctlDate => _ctlDate;

  final TextEditingController _ctlModelNum = TextEditingController();
  TextEditingController get ctlModelNum => _ctlModelNum;

  final TextEditingController _ctlClientName = TextEditingController();
  TextEditingController get ctlClientName => _ctlClientName;

  final TextEditingController _ctlHP = TextEditingController();
  TextEditingController get ctlHP => _ctlHP;

  final TextEditingController _ctlMO = TextEditingController();
  TextEditingController get ctlMO => _ctlMO;

  final TextEditingController _ctlDispatchLoc = TextEditingController();
  TextEditingController get ctlDispatchLoc => _ctlDispatchLoc;

  final TextEditingController _ctlCheckedPersonName = TextEditingController();
  TextEditingController get ctlCheckedPersonName => _ctlCheckedPersonName;

  final TextEditingController _ctlSuperVisorSign = TextEditingController();
  TextEditingController get ctlSuperVisorSign => _ctlSuperVisorSign;

  final TextEditingController _ctlRemarkIfAny = TextEditingController();
  TextEditingController get ctlRemarkIfAny => _ctlRemarkIfAny;

  final List<DispatchInspectionModel> _dispatchInspectList = [];
  List<DispatchInspectionModel> get dispatchInspectList =>
      [..._dispatchInspectList];

  final List<DispatchInspectionModel> _selectedList = [];
  List<DispatchInspectionModel> get electedList => _selectedList;

  List<String> componentList = [
    "Motor",
    "Motor Pulley Size",
    "Motor Relay",
    "V-Belt",
    "Pressure Gauge",
    "Pressure Switch",
    "Section Filter",
    "Inter Cooling Saftey Value",
    "Receiver Saftey valve",
    "Drain Valve",
    "Service Valve",
    "Nut-Bolt",
    "NRV",
    "Stater",
    "Compressor Oil Check(lTRS)",
    "Before Dispatch Testing",
    "Airotech Compresors Logo",
    "Daily Inspection Checklist",
    "IN-OUT",
    "Big",
    "Small",
  ];

  initData() {
    _isBtnLoading = false;
    _ctlPiNum.clear();
    _ctlDate.clear();
    _ctlModelNum.clear();
    _ctlClientName.clear();
    _ctlHP.clear();
    _ctlMO.clear();
    _ctlDispatchLoc.clear();
    _dispatchInspectList.clear();
    _ctlCheckedPersonName.clear();
    _ctlSuperVisorSign.clear();
    _ctlRemarkIfAny.clear();
    for (var element in componentList) {
      _dispatchInspectList.add(DispatchInspectionModel.fromJson(element));
    }
    notifyListeners();
  }

  void toggleProduct(DispatchInspectionModel product, bool val) {
    product.changeSelection = val;

    if (_selectedList.contains(product)) {
      _selectedList.remove(product);
    } else {
      _selectedList.add(product);
    }

    notifyListeners();
  }

  DateTime? date;
  Future<void> geDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(context, date, null);

    _ctlDate.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    date = pickedDate[1];
    notifyListeners();
  }

  Future submitAndDispatch(BuildContext context) async {
    loadingBtnFun(true);
    var createdArray = _selectedList.map((e) => e.toJson());
    var createdDatas = createdArray.toList();
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();

    var passedData = json.encode({
      "pi_no": _ctlPiNum.text,
      "date": CommonFunctions().returnAPiDateFormat(_ctlDate.text),
      "model": _ctlModelNum.text,
      "client_name": _ctlClientName.text,
      "hp": _ctlHP.text,
      "mobile": _ctlMO.text,
      "dispatch_location": _ctlDispatchLoc.text,
      "checked_person_name": _ctlCheckedPersonName.text,
      "supervisor_sign": _ctlSuperVisorSign.text,
      "remark": _ctlRemarkIfAny.text,
      "assign_technician": technicianModel.id,
      "created_at": CommonFunctions().returnCurrentTime(),
      "parts": createdDatas,
    });

    var result =
        await machineDispatchRepository.submitAndDispatch(context, passedData);

    result.fold((error) {
      loadingBtnFun(false);
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) {
      loadingBtnFun(false);
      CommonFunctions.showSuccessSnackbar("Machine Submit & Dispatch");
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _ctlPiNum.dispose();
    _ctlDate.dispose();
    _ctlModelNum.dispose();
    _ctlClientName.dispose();
    _ctlHP.dispose();
    _ctlMO.dispose();
    _ctlDispatchLoc.dispose();
    _ctlSuperVisorSign.dispose();
    _ctlRemarkIfAny.dispose();
    super.dispose();
  }
}
