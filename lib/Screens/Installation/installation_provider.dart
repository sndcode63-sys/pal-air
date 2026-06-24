import 'package:flutter/material.dart';

import 'installation_model.dart';
import 'installation_repository.dart';

class InstallationProvider with ChangeNotifier {
  InstallationRepository installationRepository = InstallationRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<InstallationModel> _installationList = [];
  List<InstallationModel> get installationList => [..._installationList];

  loadingFun(bool val) {
    _isLoading = val;

    notifyListeners();
  }

  initData() {
    _isLoading = true;
    _installationList.clear();
  }

  Future getInstallationList(BuildContext context) async {
    loadingFun(true);
    initData();
    var result = await installationRepository.getInstallationList(context);

    result.fold((error) {
      loadingFun(false);
    }, (data) {
      _installationList = data;
      loadingFun(false);
    });
  }
}
