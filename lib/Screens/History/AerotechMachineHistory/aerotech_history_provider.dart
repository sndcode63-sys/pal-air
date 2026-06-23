import 'package:airo_tech/Screens/MyComplains/complaint_model.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_repository.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AerotechHistoryProvider with ChangeNotifier {
  ComplaintRepository complaintRepository = ComplaintRepository();

  final TextEditingController _ctlFromDate = TextEditingController();
  TextEditingController get ctlFromDate => _ctlFromDate;

  final TextEditingController _ctlUptoDate = TextEditingController();
  TextEditingController get ctlUptoDate => _ctlUptoDate;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ComplaintModel> _otherAmcList = [];
  List<ComplaintModel> get otherAmcList => [..._otherAmcList];

  loadingFun(bool val) {
    _isLoading = val;

    notifyListeners();
  }

  initData() {
    _ctlFromDate.clear();
    _ctlUptoDate.clear();
    _isLoading = true;
    _otherAmcList.clear();
    fromDate = null;
    uptoDate = null;
  }

  DateTime? fromDate, uptoDate;
  Future<void> geFromDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(context, fromDate, null);

    _ctlFromDate.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    fromDate = pickedDate[1];
    notifyListeners();
  }

  Future<void> geToDate(BuildContext context) async {
    List pickedDate = await CommonFunctions().pickDate(context, uptoDate, null);

    _ctlUptoDate.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    uptoDate = pickedDate[1];
    notifyListeners();
  }

  Future getAeroTechMachineHistoryList(
    String from,
    BuildContext context,
  ) async {
    loadingFun(true);
    if (from != "filter") {
      initData();
    }

    var result = await complaintRepository.getAeroTechMachineHistoryList(
        context,
        fromDate != null ? DateFormat('yyyy-MM-dd').format(fromDate!) : "",
        uptoDate != null ? DateFormat('yyyy-MM-dd').format(uptoDate!) : "");

    result.fold((error) {
      loadingFun(false);
    }, (data) {
      _otherAmcList = data;
      loadingFun(false);
    });
  }
}
