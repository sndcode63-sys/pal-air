
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/common_loader.dart';
import '../../../Widgets/no_data_found_widget.dart';
import '../../../Widgets/search_widget.dart';
import '../../MyComplains/Components/complaint_view.dart';
import 'aerotech_history_provider.dart';

class AerotechMachineHistory extends StatefulWidget {
  const AerotechMachineHistory({super.key});

  @override
  State<AerotechMachineHistory> createState() => _AerotechMachineHistoryState();
}

class _AerotechMachineHistoryState extends State<AerotechMachineHistory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // var provider =
      //     Provider.of<AerotechHistoryProvider>(context, listen: false);
      // provider.getAeroTechMachineHistoryList(
      //   "init",
      //   context,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AerotechHistoryProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SearchWidget(
              fromOnTap: () => provider.geFromDate(context),
              toOnTap: () => provider.geToDate(context),
              fromdate: provider.ctlFromDate,
              toDate: provider.ctlUptoDate,
              // onSearch: () => provider.getAeroTechMachineHistoryList(
              //       "filter",
              //       context,
              //     )),
              onSearch: () {}),
          provider.isLoading
              ? const ExpandedCommonLoader()
              : Expanded(
                  child:
                      //  RefreshIndicator(
                      //   onRefresh: () => provider.getAeroTechMachineHistoryList(
                      //     "refresh",
                      //     context,
                      //   ),
                      //   child:
                      provider.otherAmcList.isEmpty
                          ? const NoDataFoundWidget()
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                var complaint = provider.otherAmcList[index];
                                return ComplaintView(
                                    from: "History",
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
          //  ),
        ],
      ),
    );
  }
}
