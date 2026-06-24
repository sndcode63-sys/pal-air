import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../Utils/appcolors.dart';
import '../../../Utils/route_names.dart';
import '../../../Widgets/common_appbar.dart';
import '../../../Widgets/common_loader.dart';
import '../../../Widgets/no_data_found_widget.dart';
import '../Components/complaint_view.dart';
import 'other_company_machine_provider.dart';

class OtherCompanyMachineScreen extends StatefulWidget {
  const OtherCompanyMachineScreen({super.key});

  @override
  State<OtherCompanyMachineScreen> createState() =>
      _OtherCompanyMachineScreenState();
}

class _OtherCompanyMachineScreenState extends State<OtherCompanyMachineScreen>
    with WidgetsBindingObserver {
  PermissionStatus? locationStatus;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
          Provider.of<OtherCompanyMachineProvider>(context, listen: false);
      provider.getComplaintList(context);
    });
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    locationStatus = await Permission.location.status;
    if (locationStatus!.isGranted) {
      locationStatus = PermissionStatus.granted;
    } else if (locationStatus!.isDenied) {
      locationStatus = PermissionStatus.denied;
      await Permission.location.request();
    } else {
      locationStatus = PermissionStatus.permanentlyDenied;
      openAppSettings();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  onResumed() {
    _checkLocationPermission();
  }

  navigateToAddOtherMachine() async {
    await Navigator.pushNamed(
      context,
      RouteNames.addOtherCompanyMachine,
    ).then(onRefresh);
  }

  FutureOr onRefresh(dynamic value) {
    var provider =
        Provider.of<OtherCompanyMachineProvider>(context, listen: false);
    provider.getComplaintList(context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OtherCompanyMachineProvider>(
      context,
    );
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        heading: "OTHER AMC LIST",
      ),
      body: provider.isLoading
          ? const CommonLoader()
          : RefreshIndicator(
              onRefresh: () => provider.getComplaintList(context),
              child: provider.otherAmcList.isEmpty
                  ? const NoDataFoundWidget()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        var complaint = provider.otherAmcList[index];
                        return ComplaintView(
                            from: "Other", complaint: complaint, index: index);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: provider.otherAmcList.length),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => navigateToAddOtherMachine(),
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
