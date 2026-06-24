import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Utils/common_functions.dart';
import '../Auth/auth_repository.dart';
import '../Auth/technician_model.dart';

class ProfileScreenProvider with ChangeNotifier {
  AuthRepository authRepository = AuthRepository();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _btnIsLoading = false;
  bool get btnIsLoading => _btnIsLoading;

  bool _lgBtnLoading = false;
  bool get lgBtnLoading => _lgBtnLoading;

  TechnicianModel technicianModel = TechnicianModel();

  final TextEditingController _ctlName = TextEditingController();
  TextEditingController get ctlName => _ctlName;

  final TextEditingController _ctlMobile = TextEditingController();
  TextEditingController get ctlMobile => _ctlMobile;

  final TextEditingController _ctlEmail = TextEditingController();
  TextEditingController get ctlEmail => _ctlEmail;

  ProfileScreenProvider() {
    _isLoading = true;
    _btnIsLoading = false;
    _lgBtnLoading = false;
    _ctlName.clear();
    _ctlMobile.clear();
    _ctlEmail.clear();
    technicianModel = TechnicianModel();
  }

  initData() {
    _isLoading = true;
    _btnIsLoading = false;
    _lgBtnLoading = false;
    _ctlName.clear();
    _ctlMobile.clear();
    _ctlEmail.clear();
    technicianModel = TechnicianModel();
  }

  loadingFun(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  btnLoadingFun(bool val) {
    _btnIsLoading = val;
    notifyListeners();
  }

  lgBtnLoadingFun(bool val) {
    _lgBtnLoading = val;
    notifyListeners();
  }

  Future getProfileData(BuildContext context) async {
    initData();
    var result = await authRepository.getProfile(context);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      loadingFun(false);
    }, (data) {
      technicianModel = data;

      _ctlEmail.text = technicianModel.email!;
      _ctlMobile.text = technicianModel.phone!;
      _ctlName.text = technicianModel.fullName!;

      loadingFun(false);
    });
  }

  Future updateProfile(
    BuildContext context,
    dynamic document,
  ) async {
    btnLoadingFun(true);
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    FormData formData = FormData.fromMap({
      'id': technicianModel.id,
      "image": await MultipartFile.fromFile(
        document.path,
      ),
    });

    var result = await authRepository.updateProfile(context, formData);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      btnLoadingFun(false);
    }, (data) {
      if (data != null) {
        if (data.data['response'] == false) {
          btnLoadingFun(false);
          CommonFunctions.showErrorSnackbar(data.data['msg']);
        } else {
          btnLoadingFun(false);
          CommonFunctions.showSuccessSnackbar("Profile Updated.");
          Navigator.pop(context);
        }
      }
      notifyListeners();
    });
  }

  Future employeeCheckOut(BuildContext context) async {
    lgBtnLoadingFun(true);
    var data = await CommonFunctions().getLatLong();
    // var address = await CommonFunctions().getCurrentLocationAddress(data);
    var address = await CommonFunctions()
        .getCurrentAddressByLatLong(data.latitude, data.longitude);
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    var passedData =
        json.encode({"empId": technicianModel.id, "out_address": address});
    var result = await authRepository.checkOut(context, passedData);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      lgBtnLoadingFun(false);
    }, (data) {
      CommonFunctions.showSuccessSnackbar("Checked Out");
      lgBtnLoadingFun(false);
    });
  }

  @override
  void dispose() {
    _ctlName.dispose();
    _ctlMobile.dispose();
    _ctlEmail.dispose();
    super.dispose();
  }
}
