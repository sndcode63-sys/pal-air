import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/appcolors.dart';

class MultiSelectDialogItem<V> {
  String name;
  String type;

  MultiSelectDialogItem({
    required this.name,
    required this.type,
  });
}

class MultiSelectDialog<V> extends StatefulWidget {
  const MultiSelectDialog(
      {super.key, required this.items, required this.onTap});

  final List<MultiSelectDialogItem<V>> items;
  final VoidCallback onTap;
  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  void _onCancelTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding:
          const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 20),
      title: Text('Select Machine',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
      contentPadding: const EdgeInsets.all(10.0),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ListTileTheme(
                contentPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
                child: ListBody(
                  children: widget.items.map(_buildItem).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: _onCancelTap,
          child: Text(
            'CANCEL',
            style: GoogleFonts.poppins(color: whiteColor),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    return item.type == "data"
        ? InkWell(
            onTap: () {
              Navigator.pop(context, item.name);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                item.name,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                ),
              ),
            ),
          )
        : Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 72, 70, 70),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Text(
              item.name,
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w600, color: whiteColor),
            ),
          );
  }
}
