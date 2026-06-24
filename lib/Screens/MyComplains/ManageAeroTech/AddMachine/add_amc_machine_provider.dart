import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../Utils/common_functions.dart';
import '../../../../Widgets/machine_type_list.dart';
import '../../../Auth/auth_repository.dart';
import '../../../Auth/technician_model.dart';
import '../../complaint_repository.dart';

class AddMachineAMCProvider with ChangeNotifier {
  AuthRepository authRepository = AuthRepository();
  ComplaintRepository complaintRepository = ComplaintRepository();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isBtnLoading = false;
  bool get isBtnLoading => _isBtnLoading;

  loadingFun(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  isBtnLoadingFun(bool val) {
    _isBtnLoading = val;
    notifyListeners();
  }

  final TextEditingController _ctlPINum = TextEditingController();
  TextEditingController get ctlPINum => _ctlPINum;

  final TextEditingController _ctlDate = TextEditingController();
  TextEditingController get ctlDate => _ctlDate;

  final TextEditingController _ctlMachineType = TextEditingController();
  TextEditingController get ctlMachineType => _ctlMachineType;

  final TextEditingController _ctlCompressorMake = TextEditingController();
  TextEditingController get ctlCompressorMake => _ctlCompressorMake;

  final TextEditingController _ctlCompressorHP = TextEditingController();
  TextEditingController get ctlCompressorHP => _ctlCompressorHP;

  final TextEditingController _ctlCompName = TextEditingController();
  TextEditingController get ctlCompName => _ctlCompName;

  final TextEditingController _ctlCityName = TextEditingController();
  TextEditingController get ctlCityName => _ctlCityName;

  final TextEditingController _ctlAddress = TextEditingController();
  TextEditingController get ctlAddress => _ctlAddress;

  final TextEditingController _ctlContact = TextEditingController();
  TextEditingController get ctlContact => _ctlContact;

  final TextEditingController _ctlEmail = TextEditingController();
  TextEditingController get ctlEmail => _ctlEmail;

  final TextEditingController _ctlContactPerson = TextEditingController();
  TextEditingController get ctlContactPerson => _ctlContactPerson;

  final TextEditingController _ctlProductDesc = TextEditingController();
  TextEditingController get ctlProductDesc => _ctlProductDesc;

  final TextEditingController _ctlAmcType = TextEditingController();
  TextEditingController get ctlAmcType => _ctlAmcType;

  final TextEditingController _ctlTechnician = TextEditingController();
  TextEditingController get ctlTechnician => _ctlTechnician;

  final TextEditingController _ctlComplainDate = TextEditingController();
  TextEditingController get ctlComplainDate => _ctlComplainDate;

  final TextEditingController _ctlComplainType = TextEditingController();
  TextEditingController get ctlComplainType => _ctlComplainType;

  final TextEditingController _ctlComplainDesc = TextEditingController();
  TextEditingController get ctlComplainDesc => _ctlComplainDesc;

  final TextEditingController _ctlAMCDesc = TextEditingController();
  TextEditingController get ctlAMCDesc => _ctlAMCDesc;

  final List<TextEditingController> _ctlTextControllerList =
      List.generate(12, (i) => TextEditingController());

  List<TextEditingController> get ctlTextControllerList =>
      _ctlTextControllerList;

  String _errorDate = "",
      _errorCompressor = "",
      _errorHp = "",
      _errorName = "",
      _errorAddress = "",
      _errorCity = "",
      _errorContact = "",
      _errorEmail = "",
      _errorContactPerson = "",
      _prodDesc = "",
      _errorCatType = "";

  String get errorDate => _errorDate;
  String get errorCompressor => _errorCompressor;
  String get errorHp => _errorHp;
  String get errorName => _errorName;
  String get errorAddress => _errorAddress;
  String get errorCity => _errorCity;
  String get errorContact => _errorContact;
  String get errorEmail => _errorEmail;
  String get errorContactPerson => _errorContactPerson;
  String get prodDesc => _prodDesc;
  String get errorCatType => _errorCatType;

  intData() {
    _isBtnLoading = false;
    _isLoading = true;
    _ctlDate.clear();
    _ctlPINum.clear();
    _ctlMachineType.clear();
    _ctlCompressorMake.clear();
    _ctlCompressorHP.clear();
    _ctlCompName.clear();
    _ctlCityName.clear();
    _ctlAddress.clear();
    _ctlContact.clear();
    _ctlEmail.clear();
    _ctlContactPerson.clear();
    _ctlProductDesc.clear();
    _ctlAmcType.clear();
    _ctlTechnician.clear();
    _ctlComplainDate.clear();
    _ctlComplainType.clear();
    _ctlComplainDesc.clear();
    // _techList.clear();
    // _techNameList.clear();
    for (var e in _ctlTextControllerList) {
      e.clear();
    }
    _ctlAMCDesc.clear();
    clearErrorFields();
    techID = "";
    notifyListeners();
    // selectedModel = TechnicianListModel(techName: "", id: "");
  }

  clearErrorFields() {
    _errorDate = "";
    _errorCompressor = "";
    _errorHp = "";
    _errorName = "";
    _errorAddress = "";
    _errorCity = "";
    _errorContact = "";
    _errorEmail = "";
    _errorContactPerson = "";
    _prodDesc = "";
    _errorCatType = "";
  }

  DateTime? pickTime, complainTime;

  Future<void> getDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(context, pickTime, null);

    _ctlDate.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    pickTime = pickedDate[1];
    notifyListeners();
  }

  // final List<TechnicianListModel> _techList = [];
  // List<TechnicianListModel> get techList => _techList;

  // final List<String> _techNameList = [];
  // List<String> get techNameList => _techNameList;

  // Future getTechnicianList(BuildContext context) async {
  //   loadingFun(true);
  //   intData();
  //   var result = await authRepository.getTechnicianList(context: context);

  //   result.fold((error) {
  //     CommonFunctions.showErrorSnackbar(error.message);
  //     loadingFun(false);
  //   }, (data) {
  //     _techList = data;
  //     _techNameList = _techList.map((e) => e.techName!).toList();
  //     loadingFun(false);
  //   });
  // }

  Future<void> getComplainDate(BuildContext context) async {
    List pickedDate =
        await CommonFunctions().pickDate(context, complainTime, null);

    _ctlComplainDate.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    complainTime = pickedDate[1];
    notifyListeners();
  }

  String techID = "";
  void changeComplainType(String value) async {
    _ctlAmcType.text = value;
    if (value == "AMC") {
      // selectedModel = TechnicianListModel(techName: "", id: "");
      techID = "";
      _ctlTechnician.clear();
      _ctlComplainDate.clear();
      _ctlComplainType.clear();
      _ctlComplainDesc.clear();
    } else {
      TechnicianModel tModel = await CommonFunctions().getProfileData();
      _ctlTechnician.text = tModel.fullName!;
      techID = tModel.id!;
      for (var e in _ctlTextControllerList) {
        e.clear();
      }
      _ctlAMCDesc.clear();
    }
    notifyListeners();
  }

  void changeTechnicianType(String value) {
    _ctlTechnician.text = value;
    notifyListeners();
  }

  void selectComplainType(String value) {
    _ctlComplainType.text = value;
    notifyListeners();
  }

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

    notifyListeners();
  }

  void showMultiSelect(BuildContext context) async {
    final selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          onTap: () {},
          items: CommonFunctions().getMachineType(),
        );
      },
    );

    _ctlMachineType.text = selectedValue ?? "";
    notifyListeners();
  }

  Future addNewComlain(BuildContext context) async {
    isBtnLoadingFun(true);
    TechnicianModel tModel = await CommonFunctions().getProfileData();
    var passedData = json.encode({
      "pi_no": _ctlPINum.text,
      "date": CommonFunctions().returnAPiDateFormat(_ctlDate.text),
      "machineType": _ctlMachineType.text,
      "compressorMake": ctlCompressorMake.text,
      "compressorHp": _ctlCompressorHP.text,
      "companyName": _ctlCompName.text,
      "address": _ctlAddress.text,
      "city": _ctlCityName.text,
      "contact": _ctlContact.text,
      "email": _ctlEmail.text,
      "contactPerson": _ctlContactPerson.text,
      "productDescription": _ctlProductDesc.text,
      "catype": _ctlAmcType.text,
      "comp_assignTechnician": techID,
      "complainDate":
          CommonFunctions().returnAPiDateFormat(_ctlComplainDate.text),
      "complainType": _ctlComplainType.text,
      "comp_description": _ctlComplainDesc.text,
      "amc_date1":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[0].text),
      "amc_date2":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[1].text),
      "amc_date3":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[2].text),
      "amc_date4":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[3].text),
      "amc_date5":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[4].text),
      "amc_date6":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[5].text),
      "amc_date7":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[6].text),
      "amc_date8":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[7].text),
      "amc_date9":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[8].text),
      "amc_date10":
          CommonFunctions().returnAPiDateFormat(_ctlTextControllerList[9].text),
      "amc_date11": CommonFunctions()
          .returnAPiDateFormat(_ctlTextControllerList[10].text),
      "amc_date12": CommonFunctions()
          .returnAPiDateFormat(_ctlTextControllerList[11].text),
      "amc_description": _ctlAMCDesc.text,
      "created_by": tModel.id,
      "created_at": CommonFunctions().returnCurrentTime()
    });

    var result = await complaintRepository.addAerotechMachineComplain(
        context, passedData);

    result.fold((error) {}, (data) async {
      clearErrorFields();

      if (data != null) {
        var responseJson = json.decode(data.body);

        if (data.statusCode == 400) {
          isBtnLoadingFun(false);
          if (responseJson['msg'] == "Validation Error") {
            responseJson['errors'].forEach((k, v) {
              if (k == "date") {
                _errorDate = v;
              }
              if (k == "compressorMake") {
                _errorCompressor = v;
              }
              if (k == "compressorHp") {
                _errorHp = v;
              }
              if (k == "companyName") {
                _errorName = v;
              }
              if (k == "address") {
                _errorAddress = v;
              }
              if (k == "city") {
                _errorCity = v;
              }
              if (k == "contact") {
                _errorContact = v;
              }
              if (k == "email") {
                _errorEmail = v;
              }
              if (k == "contactPerson") {
                _errorContactPerson = v;
              }
              if (k == "productDescription") {
                _prodDesc = v;
              }
              if (k == "catype") {
                _errorCatType = v;
              }
            });
          } else {
            CommonFunctions.showErrorSnackbar(responseJson['msg']);
            isBtnLoadingFun(false);
          }
        } else if (data.statusCode == 200) {
          CommonFunctions.showSuccessSnackbar(responseJson['msg']);
          isBtnLoadingFun(false);
          Navigator.pop(context);
        }
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _ctlDate.dispose();
    _ctlMachineType.dispose();
    _ctlCompressorMake.dispose();
    _ctlCompressorHP.dispose();
    _ctlCompName.dispose();
    _ctlCityName.dispose();
    _ctlAddress.dispose();
    _ctlContact.dispose();
    _ctlEmail.dispose();
    _ctlContactPerson.dispose();
    _ctlProductDesc.dispose();
    _ctlAmcType.dispose();
    _ctlTechnician.dispose();
    _ctlComplainDate.dispose();
    _ctlComplainType.dispose();
    _ctlComplainDesc.dispose();
    _ctlAMCDesc.dispose();
    super.dispose();
  }
}
