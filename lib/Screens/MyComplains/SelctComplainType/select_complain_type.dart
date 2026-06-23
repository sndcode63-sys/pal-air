import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/route_names.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectComplainType extends StatelessWidget {
  const SelectComplainType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
          context: context,
          heading: "Select Complain Type",
        ),
        body: _buildInitialWidget(context));
  }

  Widget _buildInitialWidget(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Column(
        children: [
          SchemeListTile(
            titleString: 'Type One',
            onClicked: () {
              Navigator.pushNamed(context, RouteNames.complainDetailScreen);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SchemeMachineExchange()));
            },
          ),
          const SizedBox(
            height: 12,
          ),
          SchemeListTile(
            titleString: 'Type Two',
            onClicked: () {
              Navigator.pushNamed(context, RouteNames.complainDetailScreen);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          SchemeListTile(
            titleString: 'Type Three',
            onClicked: () {
              Navigator.pushNamed(context, RouteNames.complainDetailScreen);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          SchemeListTile(
            titleString: 'Type Four',
            onClicked: () {
              Navigator.pushNamed(context, RouteNames.complainDetailScreen);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          SchemeListTile(
            titleString: 'Type Five',
            onClicked: () {
              Navigator.pushNamed(context, RouteNames.complainDetailScreen);
            },
          ),
          const SizedBox(
            height: 12,
          ),
          SchemeListTile(
            titleString: 'In Warranty',
            onClicked: () {
              Navigator.pushNamed(context, RouteNames.complainDetailScreen);
            },
          ),
        ],
      ),
    ));
  }
}

class SchemeListTile extends StatelessWidget {
  final String titleString;
  final VoidCallback onClicked;
  const SchemeListTile(
      {super.key, required this.titleString, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: primaryColor.withOpacity(0.2),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: primaryColor, width: 1)),
      onTap: onClicked,
      title: Text(
        titleString,
        style: GoogleFonts.poppins(fontSize: 12),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.black,
        size: 12,
      ),
    );
  }
}
