import 'package:airo_tech/Screens/Installation/installation_model.dart';
import 'package:flutter/material.dart';

import 'machine_dispatch_repository.dart';

class MachineDispatchProvider with ChangeNotifier {
  MachineDispatchRepository machineDispatchRepository =
      MachineDispatchRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<InstallationModel> _newMachineList = [];
  List<InstallationModel> get newMachineList => [..._newMachineList];

  loadingFun(bool val) {
    _isLoading = val;

    notifyListeners();
  }

  initData() {
    _isLoading = true;
    _newMachineList.clear();
  }

  Future getMachineDipatchList(BuildContext context) async {
    loadingFun(true);
    initData();
    var result = await machineDispatchRepository.getMachineDipatchList(context);

    result.fold((error) {
      loadingFun(false);
    }, (data) {
      _newMachineList = data;
      loadingFun(false);
    });
  }
}
