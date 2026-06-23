import 'package:airo_tech/Screens/History/AerotechMachineHistory/aerotech_machine_history.dart';
import 'package:airo_tech/Screens/History/OtherMachineHistory/other_machine_history.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class MainHistoryScreen extends StatefulWidget {
  const MainHistoryScreen({super.key});

  @override
  State<MainHistoryScreen> createState() => _MainHistoryScreenState();
}

class _MainHistoryScreenState extends State<MainHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        heading: "History",
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          labelColor: whiteColor,
          unselectedLabelColor: blackColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          controller: tabController,
          indicatorColor: Colors.black,
          indicatorWeight: 2.0,
          indicator: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8)),
          tabs: const [
            Tab(
              child: Text(
                'Other Machine History',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Tab(
              child: Text(
                'Aerotech Machine History',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [OtherMachineHistory(), AerotechMachineHistory()],
      ),
    );
  }
}
