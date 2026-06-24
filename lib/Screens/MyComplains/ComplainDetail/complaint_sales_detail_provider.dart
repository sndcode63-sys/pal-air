import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../Utils/common_functions.dart';
import '../../../Utils/route_names.dart';
import '../complaint_model.dart';
import '../complaint_repository.dart';

class ComplaintSalesDetailProvider with ChangeNotifier {
  ComplaintRepository complaintRepository = ComplaintRepository();
  final _ctlName = TextEditingController();
  TextEditingController get ctlName => _ctlName;

  final _ctlDesignation = TextEditingController();
  TextEditingController get ctlDesignation => _ctlDesignation;

  final _ctlOrganization = TextEditingController();
  TextEditingController get ctlOrganization => _ctlOrganization;

  final _ctlAddress = TextEditingController();
  TextEditingController get ctlAddress => _ctlAddress;

  final _ctlMobile = TextEditingController();
  TextEditingController get ctlMobile => _ctlMobile;

  final _ctlOfficeNo = TextEditingController();
  TextEditingController get ctlOfficeNo => _ctlOfficeNo;

  final _ctlEmail = TextEditingController();
  TextEditingController get ctlEmail => _ctlEmail;

  final _mcController = TextEditingController();
  TextEditingController get mcController => _mcController;

  final _ctlAirFlow = TextEditingController();
  TextEditingController get ctlAirFlow => _ctlAirFlow;

  final _ctlPressure = TextEditingController();
  TextEditingController get ctlPressure => _ctlPressure;

  final _ctlPower = TextEditingController();
  TextEditingController get ctlPower => _ctlPower;

  final _ctlApplication = TextEditingController();
  TextEditingController get ctlApplication => _ctlApplication;

  final _ctlSuggestedType = TextEditingController();
  TextEditingController get ctlSuggestedType => _ctlSuggestedType;

  final _ctlCompCapModel = TextEditingController();
  TextEditingController get ctlCompCapModel => _ctlCompCapModel;

  final _ctlAirRecCap = TextEditingController();
  TextEditingController get ctlAirRecCap => _ctlAirRecCap;

  final _ctlAirDryer = TextEditingController();
  TextEditingController get ctlAirDryer => _ctlAirDryer;

  final _ctlPreFilters = TextEditingController();
  TextEditingController get ctlPreFilters => _ctlPreFilters;

  final _ctlPostFilters = TextEditingController();
  TextEditingController get ctlPostFilters => _ctlPostFilters;

  final _ctlOtherAccessory = TextEditingController();
  TextEditingController get ctlOtherAccessory => _ctlOtherAccessory;

  final _ctlAnyOtherDetailToSend = TextEditingController();
  TextEditingController get ctlAnyOtherDetailToSend => _ctlAnyOtherDetailToSend;

  final _ctlVisitDate = TextEditingController();
  TextEditingController get ctlVisitDate => _ctlVisitDate;

  final _ctlNextFollowUp = TextEditingController();
  TextEditingController get ctlNextFollowUp => _ctlNextFollowUp;

  final _ctlDeliveryReq = TextEditingController();
  TextEditingController get ctlDeliveryReq => _ctlDeliveryReq;

  final _ctlBrand = TextEditingController();
  TextEditingController get ctlBrand => _ctlBrand;

  final _ctlScrewRecip = TextEditingController();
  TextEditingController get ctlScrewRecip => _ctlScrewRecip;

  final _ctlNos = TextEditingController();
  TextEditingController get ctlNos => _ctlNos;

  final _ctlYearOfPurchase = TextEditingController();
  TextEditingController get ctlYearOfPurchase => _ctlYearOfPurchase;

  final _ctlAddComments = TextEditingController();
  TextEditingController get ctlAddComments => _ctlAddComments;

  final _ctlNameOfRepresentative = TextEditingController();
  TextEditingController get ctlNameOfRepresentative => _ctlNameOfRepresentative;

  String? _selection, _compPackReq, _reqQuote;
  dynamic get selection => _selection;
  dynamic get compPackReq => _compPackReq;
  dynamic get reqQuote => _reqQuote;

  List<bool> _checkBoxValues = [];

  List<bool> get checkBoxValues => [..._checkBoxValues];

  DateTime? visitDate, pickedYear;

  Future<void> geVisitDate(BuildContext context) async {
    List pickedDate = await CommonFunctions()
        .pickDate(context, visitDate, DateTime(DateTime.now().year + 20));

    _ctlVisitDate.text = pickedDate[0] == "null" ? "" : pickedDate[0];
    visitDate = pickedDate[1];
    notifyListeners();
  }

  Future<void> getYear(BuildContext context) async {
    List pickYear = await CommonFunctions()
        .pickYear(context, pickedYear, DateTime(DateTime.now().year + 20));

    _ctlYearOfPurchase.text = pickYear[0] == "null" ? "" : pickYear[0];
    pickedYear = pickYear[1];
    notifyListeners();
  }

  changeSelection(value) {
    _selection = value;
    notifyListeners();
  }

  changeCompPackReq(value) {
    _compPackReq = value;
    notifyListeners();
  }

  changeReqQoute(value) {
    _reqQuote = value;
    notifyListeners();
  }

  changeProductIndex(int index, bool value) {
    _checkBoxValues[index] = value;
    notifyListeners();
  }

  initData() {
    _mcController.clear();
    _ctlName.clear();
    _ctlDesignation.clear();
    _ctlOrganization.clear();
    _ctlAddress.clear();
    _ctlMobile.clear();
    _ctlOfficeNo.clear();
    _ctlEmail.clear();
    _ctlEmail.clear();
    _ctlAirFlow.clear();
    _ctlPressure.clear();
    _ctlPower.clear();
    _ctlApplication.clear();
    _ctlSuggestedType.clear();
    _ctlCompCapModel.clear();
    _ctlAirRecCap.clear();
    _ctlAirDryer.clear();
    _ctlPreFilters.clear();
    _ctlPostFilters.clear();
    _ctlOtherAccessory.clear();
    _ctlAnyOtherDetailToSend.clear();
    _ctlVisitDate.clear();
    _ctlNextFollowUp.clear();
    _ctlDeliveryReq.clear();
    _ctlScrewRecip.clear();
    _ctlNos.clear();
    _ctlBrand.clear();
    _ctlYearOfPurchase.clear();
    _ctlNameOfRepresentative.clear();
    _ctlAddComments.clear();
    visitDate = null;
    _selection = null;
    _checkBoxValues = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  loadingFun(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String _checkoutResponseMessage(dynamic data) {
    if (data == null) return '';
    if (data is String) {
      try {
        final m = json.decode(data) as Map<String, dynamic>;
        return (m['message'] ?? m['notification'] ?? '').toString();
      } catch (_) {
        return data;
      }
    }
    if (data is Map) {
      return (data['message'] ?? data['notification'] ?? '').toString();
    }
    return data.toString();
  }

  Future updateComlain(BuildContext context, var pdfFile,
      ComplaintModel complaintModel, String from) async {
    try {
      dev.log(
        'updateComlain (sales) start: id=${complaintModel.id} from=$from',
        name: 'SubmitReport',
      );
      loadingFun(true);
      final data = await CommonFunctions().getLatLong();
      if (data == "error") {
        dev.log('Location error — abort (sales)', name: 'SubmitReport');
        return;
      }

      final address = await CommonFunctions()
          .getCurrentAddressByLatLong(data.latitude, data.longitude);
      dev.log('Geocode ok (sales): len=${address.length}',
          name: 'SubmitReport');

      final passedData = FormData.fromMap({
        "work_remark": "Work Done",
        "id": complaintModel.id,
        "latitude1": "${data.latitude}#${data.longitude}",
        "longitude1": address,
        "pdf": await MultipartFile.fromFile(
          pdfFile.path,
        ),
        "checkOut": CommonFunctions().returnCurrentTime()
      });

      final ep = from == "Other"
          ? 'proceed-other-checkout'
          : 'proceed-airotech-checkout';
      dev.log('POST checkout (sales): $ep', name: 'SubmitReport');

      final result = from == "Other"
          ? await complaintRepository.updateCheckOut(context, passedData)
          : await complaintRepository.updateAerotechCheckOut(
              context, passedData);

      result.fold((error) {
        dev.log(
          'API Left (sales): ${error.message} code=${error.statusCode}',
          name: 'SubmitReport',
        );
        CommonFunctions.showErrorSnackbar(error.message);
      }, (data) {
        if (data is Response) {
          final code = data.statusCode;
          dev.log(
            'API Right (sales): status=$code',
            name: 'SubmitReport',
          );
          if (code == 200) {
            CommonFunctions.showSuccessSnackbar("Complaint Submitted");
            if (context.mounted) {
              Navigator.pushNamed(context, RouteNames.pdfViewerPage,
                  arguments: {"file": pdfFile});
            }
            dev.log('Success (sales)', name: 'SubmitReport');
          } else if (code == 400) {
            final msg = _checkoutResponseMessage(data.data);
            dev.log('HTTP 400 (sales): $msg', name: 'SubmitReport');
            CommonFunctions.showErrorSnackbar(
                msg.isEmpty ? 'Could not submit report' : msg);
          } else {
            CommonFunctions.showErrorSnackbar(
                'Server error (${code ?? "unknown"})');
          }
        } else {
          dev.log('Unexpected response type (sales): ${data.runtimeType}',
              name: 'SubmitReport');
          CommonFunctions.showErrorSnackbar('Unexpected response from server');
        }
        notifyListeners();
      });
    } catch (e, st) {
      dev.log('updateComlain (sales) exception: $e',
          name: 'SubmitReport', stackTrace: st);
      CommonFunctions.showErrorSnackbar(e.toString());
    } finally {
      loadingFun(false);
      dev.log('updateComlain (sales) done', name: 'SubmitReport');
    }
  }

  @override
  void dispose() {
    _mcController.dispose();
    _ctlName.dispose();
    _ctlDesignation.dispose();
    _ctlOrganization.dispose();
    _ctlAddress.dispose();
    _ctlMobile.dispose();
    _ctlOfficeNo.dispose();
    _ctlEmail.dispose();
    _ctlEmail.dispose();
    _ctlAirFlow.dispose();
    _ctlPressure.dispose();
    _ctlPower.dispose();
    _ctlApplication.dispose();
    _ctlSuggestedType.dispose();
    _ctlCompCapModel.dispose();
    _ctlAirRecCap.dispose();
    _ctlAirDryer.dispose();
    _ctlPreFilters.dispose();
    _ctlPostFilters.dispose();
    _ctlOtherAccessory.dispose();
    _ctlAnyOtherDetailToSend.dispose();
    _ctlVisitDate.dispose();
    _ctlNextFollowUp.dispose();
    _ctlDeliveryReq.dispose();
    _ctlScrewRecip.dispose();
    _ctlNos.dispose();
    _ctlAddComments.dispose();
    _ctlYearOfPurchase.dispose();
    _ctlNameOfRepresentative.dispose();
    _ctlBrand.dispose();
    super.dispose();
  }
}
