
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

import '../../../Utils/route_names.dart';
import '../../../Widgets/common_appbar.dart';

class PFDViewerPage extends StatefulWidget {
  final File? file;
  const PFDViewerPage({
    super.key,
    this.file,
  });

  @override
  PFDViewerPageState createState() => PFDViewerPageState();
}

class PFDViewerPageState extends State<PFDViewerPage> {
  Future<bool> onBackPressed() async {
    // Navigator.pop(context);
    Navigator.pushReplacementNamed(context, RouteNames.homeScreen);

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: commonAppBar(
            context: context,
            heading: "PDF",
            onPressed: () {
              //  Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
            },
            widgetList: [
              IconButton(
                  onPressed: () {
                    Share.shareXFiles([XFile(widget.file!.path)],
                        text: 'Great picture');
                  },
                  icon: const Icon(Icons.share))
            ]),
        body: PDFView(
          filePath: widget.file!.path,
        ),
      ),
    );
  }
}
