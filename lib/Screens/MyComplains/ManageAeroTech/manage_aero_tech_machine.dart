import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utils/appcolors.dart';
import '../../../Utils/route_names.dart';
import '../../../Widgets/common_appbar.dart';
import '../../../Widgets/common_loader.dart';
import '../../../Widgets/no_data_found_widget.dart';
import '../Components/complaint_view.dart';
import 'manage_aero_tech_machine_provider.dart';

class ManageAeroTechMachineScreen extends StatefulWidget {
  const ManageAeroTechMachineScreen({super.key});

  @override
  State<ManageAeroTechMachineScreen> createState() =>
      _ManageAeroTechMachineScreenState();
}

class _ManageAeroTechMachineScreenState
    extends State<ManageAeroTechMachineScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
          Provider.of<ManageAeroTechMachineProvider>(context, listen: false);
      provider.getComplaintList(context);
    });
  }

  navigateToAddAerotechMachine() async {
    await Navigator.pushNamed(
      context,
      RouteNames.addAmcMachineScreen,
    ).then(onRefresh);
  }

  FutureOr onRefresh(dynamic value) {
    var provider =
        Provider.of<ManageAeroTechMachineProvider>(context, listen: false);
    provider.getComplaintList(context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ManageAeroTechMachineProvider>(
      context,
    );
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        heading: "ADD NEW AMC (AIRO TECHENTERPRICES)",
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
                            from: "Aerotech",
                            complaint: complaint,
                            index: index);
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
        onPressed: () => navigateToAddAerotechMachine(),
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
