
import 'package:flutter/material.dart';

import '../complaint_model.dart';
import '../complaint_repository.dart';

class ManageAeroTechMachineProvider with ChangeNotifier {
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
    var result = await complaintRepository.getAerotechMachineList(context);

    result.fold((error) {
      loadingFun(false);
    }, (data) {
      _otherAmcList = data;
      loadingFun(false);
    });
  }
}
