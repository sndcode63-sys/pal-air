import 'dart:io';

import 'package:airo_tech/Screens/Auth/Login/login_screen.dart';
import 'package:airo_tech/Screens/History/main_history.dart';

import 'package:airo_tech/Screens/HomeScreen/home_screen.dart';
import 'package:airo_tech/Screens/Installation/installation.dart';
import 'package:airo_tech/Screens/MyComplains/ComplainDetail/complain_detail.dart';
import 'package:airo_tech/Screens/MyComplains/ComplainDetail/complaint_sales_detail.dart';
import 'package:airo_tech/Screens/MyComplains/CreateReport/pdf_viewer.dart';
import 'package:airo_tech/Screens/MyComplains/ManageAeroTech/AddMachine/add_amc_machine.dart';
import 'package:airo_tech/Screens/MyComplains/ManageAeroTech/manage_aero_tech_machine.dart';
import 'package:airo_tech/Screens/MyComplains/OtherCompany/AddMachine/add_machine_other.dart';
import 'package:airo_tech/Screens/MyComplains/OtherCompany/other_company_machine.dart';
import 'package:airo_tech/Screens/MyComplains/SelctComplainType/select_complain_type.dart';
import 'package:airo_tech/Screens/MyComplains/complaint_model.dart';
import 'package:airo_tech/Screens/NewMachineDispatch/DispatchInspectionCheckList/dispatch_inp_list.dart';
import 'package:airo_tech/Screens/Profile/profile_screen.dart';
import 'package:airo_tech/Screens/SplashScreen/permission_screen.dart';
import 'package:airo_tech/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../Screens/NewMachineDispatch/machine_dispatch.dart';
import 'animated_route.dart';

class RouteNames {
  static const String splashScreen = '/splashScreen';
  static const String homeScreen = '/homeScreen';
  static const String loginScreen = '/loginScreen';
  static const String permissionScreen = '/permissionScreen';
  static const String profileScreen = '/profileScreen';
  static const String otherCompanyMachineScreen = '/otherCompanyMachineScreen';
  static const String complainDetailScreen = '/complainDetailScreen';
  static const String complainSalesDetailScreen = '/complainSalesDetailScreen';
  static const String pdfViewerPage = '/pdfViewerPage';
  static const String installationScreen = '/installationScreen';
  static const String machineDispatchScreen = '/machineDispatchScreen';
  static const String addOtherCompanyMachine = '/addOtherCompanyMachine';
  static const String addAmcMachineScreen = '/addAmcMachineScreen';
  static const String selectComplainType = '/selectComplainType';
  static const String manageAeroTechMachineScreen =
      '/manageAeroTechMachineScreen';
  static const String dispatchInspectionListScreen =
      '/dispatchInspectionListScreen';
  static const String mainHistoryScreen = '/mainHistoryScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return createRoute(const SplashScreen(), 0.0, 0.0);
      case RouteNames.permissionScreen:
        return createRoute(const PermissionScreen(), 0.0, 0.0);

      case RouteNames.homeScreen:
        return createRoute(const HomeScreen(), 0.0, 0.0);

      case RouteNames.loginScreen:
        return createRoute(const LoginScreen(), 0.0, 0.0);

      case RouteNames.profileScreen:
        return createRoute(const ProfileScreen(), 0.0, 0.0);

      case RouteNames.otherCompanyMachineScreen:
        return createRoute(const OtherCompanyMachineScreen(), 0.0, 0.0);

      case RouteNames.complainDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;

        final complaintModel = args['complaintModel'] as ComplaintModel;
        final from = args['from'] as String;
        return createRoute(
            ComplainDetailScreen(
              complaintModel: complaintModel,
              from: from,
            ),
            0.0,
            0.0);

      case RouteNames.complainSalesDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;

        final complaintModel = args['complaintModel'] as ComplaintModel;

        return createRoute(
            ComplaintSalesDetailScreen(
              complaintModel: complaintModel,
            ),
            0.0,
            0.0);

      case RouteNames.installationScreen:
        return createRoute(const InstallationScreen(), 0.0, 0.0);

      case RouteNames.machineDispatchScreen:
        return createRoute(const MachineDispatchScreen(), 0.0, 0.0);

      case RouteNames.dispatchInspectionListScreen:
        return createRoute(const DispatchInspectionListScreen(), 0.0, 0.0);

      case RouteNames.addOtherCompanyMachine:
        return createRoute(const AddOtherCompanyMachine(), 0.0, 0.0);

      case RouteNames.manageAeroTechMachineScreen:
        return createRoute(const ManageAeroTechMachineScreen(), 0.0, 0.0);

      case RouteNames.addAmcMachineScreen:
        return createRoute(const AddAmcMachineScreen(), 0.0, 0.0);

      case RouteNames.selectComplainType:
        return createRoute(const SelectComplainType(), 0.0, 0.0);

      case RouteNames.mainHistoryScreen:
        return createRoute(const MainHistoryScreen(), 0.0, 0.0);

      case RouteNames.pdfViewerPage:
        final args = settings.arguments as Map<String, dynamic>;

        final file = args['file'] as File;
        return createRoute(
            PFDViewerPage(
              file: file,
            ),
            0.0,
            0.0);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
