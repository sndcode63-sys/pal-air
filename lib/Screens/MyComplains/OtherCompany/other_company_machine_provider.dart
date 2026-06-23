import 'package:airo_tech/Screens/MyComplains/complaint_model.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_repository.dart';
import 'package:flutter/material.dart';

class OtherCompanyMachineProvider with ChangeNotifier {
  ComplaintRepository complaintRepository = ComplaintRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ComplaintModel> _otherAmcList = [];
  List<ComplaintModel> get otherAmcList => [..._otherAmcList];

  loadingFun(bool val) {
    _isLoading = val;

    notifyListeners();
  }

  initData() {
    _isLoading = true;
    _otherAmcList.clear();
  }

  Future getComplaintList(BuildContext context) async {
    loadingFun(true);
    initData();
    var result = await complaintRepository.getOtherAMCList(context);

    result.fold((error) {
      loadingFun(false);
    }, (data) {
      _otherAmcList = data;
      loadingFun(false);
    });
  }
}
