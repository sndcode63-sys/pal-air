import 'dart:async';

import 'package:airo_tech/Screens/Installation/installation_dispatch_view.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/route_names.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:airo_tech/Widgets/common_loader.dart';
import 'package:airo_tech/Widgets/no_data_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'machine_dispatch_provider.dart';

class MachineDispatchScreen extends StatefulWidget {
  const MachineDispatchScreen({super.key});

  @override
  State<MachineDispatchScreen> createState() => _MachineDispatchScreenState();
}

class _MachineDispatchScreenState extends State<MachineDispatchScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider =
          Provider.of<MachineDispatchProvider>(context, listen: false);
      provider.getMachineDipatchList(context);
    });
  }

  navigateToAddMachine() async {
    await Navigator.pushNamed(
      context,
      RouteNames.dispatchInspectionListScreen,
    ).then(onRefresh);
  }

  FutureOr onRefresh(dynamic value) {
    var provider = Provider.of<MachineDispatchProvider>(context, listen: false);
    provider.getMachineDipatchList(context);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MachineDispatchProvider>(
      context,
    );
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "MACHINE DISPATCH LIST"),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Thanks we are proceeding for the installation.",
              style: GoogleFonts.poppins(
                  letterSpacing: 0.7,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            provider.isLoading
                ? const ExpandedCommonLoader()
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => provider.getMachineDipatchList(context),
                      child: provider.newMachineList.isEmpty
                          ? const NoDataFoundWidget()
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                var data = provider.newMachineList[index];
                                return NewMachineDispatchView(
                                    index: index, model: data);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: provider.newMachineList.length),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          navigateToAddMachine();
        },
        child: const Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
