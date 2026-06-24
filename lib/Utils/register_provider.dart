
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../Screens/Auth/Login/login_screen_provider.dart';
import '../Screens/History/AerotechMachineHistory/aerotech_history_provider.dart';
import '../Screens/History/OtherMachineHistory/other_history_provider.dart';
import '../Screens/Installation/installation_provider.dart';
import '../Screens/MyComplains/ComplainDetail/complain_detail_provider.dart';
import '../Screens/MyComplains/ComplainDetail/complaint_sales_detail_provider.dart';
import '../Screens/MyComplains/ManageAeroTech/AddMachine/add_amc_machine_provider.dart';
import '../Screens/MyComplains/ManageAeroTech/manage_aero_tech_machine_provider.dart';
import '../Screens/MyComplains/OtherCompany/AddMachine/add_machine_other_provider.dart';
import '../Screens/MyComplains/OtherCompany/other_company_machine_provider.dart';
import '../Screens/NewMachineDispatch/DispatchInspectionCheckList/dispatch_inp_list_provider.dart';
import '../Screens/NewMachineDispatch/machine_dispatch_provider.dart';
import '../Screens/Profile/profile_screen_provider.dart';
import '../Screens/SplashScreen/permission_provider.dart';
import '../Screens/SplashScreen/splash_screen_provider.dart';

List<SingleChildWidget> get registerProviders {
  return [
    //Auth
    ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
    ChangeNotifierProvider(create: (context) => PermissionProvider()),
    ChangeNotifierProvider(create: (context) => LoginScreenProvider()),
    ChangeNotifierProvider(create: (context) => ProfileScreenProvider()),
    ChangeNotifierProvider(create: (context) => ComplainDetailProvider()),
    ChangeNotifierProvider(create: (context) => InstallationProvider()),
    ChangeNotifierProvider(create: (context) => AddMachineOtherProvider()),
    ChangeNotifierProvider(create: (context) => AddMachineAMCProvider()),
    ChangeNotifierProvider(create: (context) => OtherCompanyMachineProvider()),
    ChangeNotifierProvider(
        create: (context) => ManageAeroTechMachineProvider()),
    ChangeNotifierProvider(
        create: (context) => DispatchInpectionListProvider()),
    ChangeNotifierProvider(create: (context) => OtherHistoryProvider()),
    ChangeNotifierProvider(create: (context) => AerotechHistoryProvider()),
    ChangeNotifierProvider(create: (context) => MachineDispatchProvider()),
    ChangeNotifierProvider(create: (context) => ComplaintSalesDetailProvider()),
  ];
}
