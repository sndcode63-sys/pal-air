import 'package:airo_tech/Screens/Installation/installation_dispatch_view.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:airo_tech/Widgets/common_loader.dart';
import 'package:airo_tech/Widgets/no_data_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'installation_provider.dart';

class InstallationScreen extends StatefulWidget {
  const InstallationScreen({super.key});

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<InstallationProvider>(context, listen: false);
      provider.getInstallationList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<InstallationProvider>(
      context,
    );
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "INSTALLATION"),
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
                      onRefresh: () => provider.getInstallationList(context),
                      child: provider.installationList.isEmpty
                          ? const NoDataFoundWidget()
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                var data = provider.installationList[index];
                                return InstallationDispatchView(
                                    index: index, model: data);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: provider.installationList.length),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
