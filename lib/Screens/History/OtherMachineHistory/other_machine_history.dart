import 'package:airo_tech/Screens/MyComplains/Components/complaint_view.dart';
import 'package:airo_tech/Widgets/common_loader.dart';
import 'package:airo_tech/Widgets/no_data_found_widget.dart';
import 'package:airo_tech/Widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'other_history_provider.dart';

class OtherMachineHistory extends StatefulWidget {
  const OtherMachineHistory({super.key});

  @override
  State<OtherMachineHistory> createState() => _OtherMachineHistoryState();
}

class _OtherMachineHistoryState extends State<OtherMachineHistory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   var provider = Provider.of<OtherHistoryProvider>(context, listen: false);
      // provider.getOtherMachineHistoryList(
      //   "init",
      //   context,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OtherHistoryProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SearchWidget(
              fromOnTap: () => provider.geFromDate(context),
              toOnTap: () => provider.geToDate(context),
              fromdate: provider.ctlFromDate,
              toDate: provider.ctlUptoDate,
              // onSearch: () => provider.getOtherMachineHistoryList(
              //       "filter",
              //       context,
              //     )),
              onSearch: () {}),
          provider.isLoading
              ? const ExpandedCommonLoader()
              : Expanded(
                  child:
                      // RefreshIndicator(
                      //   onRefresh: () => provider.getOtherMachineHistoryList(
                      //     "refresh",
                      //     context,
                      //   ),
                      // child:
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
                  // ),
                ),
        ],
      ),
    );
  }
}
