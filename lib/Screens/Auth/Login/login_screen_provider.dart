import 'dart:convert';

import 'package:airo_tech/Screens/Auth/auth_repository.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:airo_tech/Utils/local_shared_preferences.dart';
import 'package:airo_tech/Utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginScreenProvider with ChangeNotifier {
  AuthRepository authRepository = AuthRepository();
  final TextEditingController _ctlEmail = TextEditingController();
  TextEditingController get ctlEmail => _ctlEmail;

  final TextEditingController _ctlPassword = TextEditingController();
  TextEditingController get ctlPassword => _ctlPassword;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _showHidePass = true;
  bool get showHidePass => _showHidePass;

  String _errorEmailText = "", _errorPasswordText = "";
  String get errorEmailText => _errorEmailText;
  String get errorPasswordText => _errorPasswordText;

  initData() {
    _isLoading = false;

    _ctlEmail.clear();
    _ctlPassword.clear();
    _showHidePass = true;
    _errorEmailText = "";
    _errorPasswordText = "";
    notifyListeners();
  }

  void isLoadingFun(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void changeShowhidePass(bool val) {
    _showHidePass = !val;
    notifyListeners();
  }

  void clearPass(bool val) {
    _ctlPassword.clear();
  }

  Future<void> login(BuildContext context) async {
    isLoadingFun(true);
    CommonFunctions.hideKeyboard(context);
    var passedData = json.encode({
      "email": _ctlEmail.text,
      "password": _ctlPassword.text,
    });
    var result = await authRepository.loginUser(passedData, context);

    result.fold((error) {
      isLoadingFun(false);
      CommonFunctions.showErrorSnackbar(error.message);
    }, (data) async {
      _errorEmailText = "";
      _errorPasswordText = "";

      if (data != null) {
        var responseJson = json.decode(data.body);

        if (data.statusCode == 400) {
          isLoadingFun(false);
          if (responseJson['msg'] == "Validation Error") {
            responseJson['errors'].forEach((k, v) {
              if (k == "email") {
                _errorEmailText = v;
              }
              if (k == "password") {
                _errorPasswordText = v;
              }
            });
          } else {
            CommonFunctions.showErrorSnackbar(responseJson['msg']);
            isLoadingFun(false);
          }
        } else if (data.statusCode == 200) {
          isLoadingFun(false);
          await LocalPreferences().setLoginBool(true);
          String profileData = jsonEncode(responseJson['data']);
          await LocalPreferences().setProfileData(profileData);

          getEmployeeAttendence(context, responseJson['data']["id"]);

          //  Navigator.pushNamed(context, RouteNames.homeScreen);
        }
      }
      notifyListeners();
    });
  }

  Future getEmployeeAttendence(BuildContext context, String id) async {
    var result =
        await authRepository.getEmployeeAttendence(context: context, id: id);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      isLoadingFun(false);
    }, (data) {
      var todate = DateTime.now();
      String toDateStr = DateFormat('yyyy-MM-dd').format(todate);
      if (data.checkInDate != null) {
        var splitted = data.checkInDate!.split(" ");
        if (toDateStr == splitted[0]) {
          if (data.checkInTime!.isEmpty) {
            employeeCheckIn(context, id);
          } else {
            Navigator.pushNamed(context, RouteNames.homeScreen);
          }
        } else {
          employeeCheckIn(context, id);
        }
      } else {
        employeeCheckIn(context, id);
      }
    });
  }

  Future employeeCheckIn(BuildContext context, String id) async {
    var data = await CommonFunctions().getLatLong();
    // var address = await CommonFunctions().getCurrentLocationAddress(data);

    var address = await CommonFunctions()
        .getCurrentAddressByLatLong(data.latitude, data.longitude);

    var passedData =
        json.encode({"empId": id, "createdBy": id, "in_address": address});
    var result = await authRepository.checkIn(context, passedData);

    result.fold((error) {
      CommonFunctions.showErrorSnackbar(error.message);
      isLoadingFun(false);
    }, (data) {
      CommonFunctions.showSuccessSnackbar("Checked In");
      isLoadingFun(false);
      Navigator.pushNamed(context, RouteNames.homeScreen);
    });
  }
}
