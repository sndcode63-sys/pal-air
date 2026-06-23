import 'dart:convert';

import 'package:airo_tech/Screens/Auth/technician_model.dart';
import 'package:airo_tech/Utils/images.dart';
import 'package:airo_tech/Widgets/machine_type_list.dart';
import 'package:airo_tech/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'appcolors.dart';
import 'local_shared_preferences.dart';
import 'route_names.dart';
import 'package:http/http.dart' as http;

class CommonFunctions {
  static var globalContext = NavigationService.navigatorKey.currentContext!;
  String selectedVisitDate = "", selectedYear = "";
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<String> loadAsset() async {
    return await rootBundle
        .loadString('assets/Dummy/Products/productData.json');
  }

  Future<String> loadFilterAsset() async {
    return await rootBundle.loadString('assets/Dummy/Products/lensFilter.json');
  }

  Future<String> loadNearbyShopAsset() async {
    return await rootBundle.loadString('assets/Dummy/Nearby/nearby_shops.json');
  }

  Future<TechnicianModel> getProfileData() async {
    String helper = await LocalPreferences().getProfileData() ?? "";

    Map<String, dynamic> userMap = jsonDecode(helper);
    TechnicianModel empModel = TechnicianModel.fromJson(userMap);
    return empModel;
  }

  double calculatePercentageFromPrices(
      {required int oldPrice, required int currentPrice}) {
    double percent = (oldPrice - currentPrice) / oldPrice * 100;
    return percent;
  }

  Future pickDate(
    BuildContext context,
    DateTime? pickedDate,
    DateTime? lastDate,
  ) async {
    final initalDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: pickedDate ?? initalDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: lastDate ?? DateTime.now(),
    );
    if (newDate == null) {
      return ["null", null];
    } else {
      selectedVisitDate = DateFormat('dd-MM-yyyy').format(newDate);
      return [selectedVisitDate, newDate];
    }
  }

  Future pickYear(
    BuildContext context,
    DateTime? pickedDate,
    DateTime? lastDate,
  ) async {
    final initalDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: pickedDate ?? initalDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: lastDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
    if (newDate == null) {
      return ["null", null];
    } else {
      selectedYear = DateFormat('yyyy').format(newDate);
      return [selectedYear, newDate];
    }
  }

  static void showErrorSnackbar(String msg) {
    ScaffoldMessenger.of(globalContext).clearSnackBars();
    ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
        margin: const EdgeInsets.only(bottom: 70.0, left: 20, right: 20),
        content: Text(
          msg,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: Colors.red.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showSuccessSnackbar(String msg) {
    ScaffoldMessenger.of(globalContext).clearSnackBars();
    ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
        margin: const EdgeInsets.only(bottom: 70.0, left: 20, right: 20),
        content: Text(
          msg,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: Colors.green.withOpacity(.8),
        behavior: SnackBarBehavior.floating));
  }

  static void showWarningSnackbar(String msg) {
    ScaffoldMessenger.of(globalContext).clearSnackBars();
    ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
        margin: const EdgeInsets.only(bottom: 70.0, left: 20, right: 20),
        content: Text(
          msg,
          style: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
        backgroundColor: blackColor,
        behavior: SnackBarBehavior.floating));
  }

  Future<void> makePhoneCall(String phone) async {
    String phoneNumber =
        'tel:+91$phone'; // Replace with the desired phone number

    // Check if the phone call can be launched
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      // Launch the phone call
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      CommonFunctions.showErrorSnackbar("Something went wrong.");
    }
  }

  void sessionTimeOut(BuildContext context) async {
    LocalPreferences().setLoginBool(false);

    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.splashScreen, (route) => false);
    }
  }

  String returnAppDateFormat(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String returnCurrentTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  String returnAPiDateFormat(String date) {
    if (date.isEmpty) {
      return "";
    }
    var helper = date.split("-");

    return "${helper[2]}-${helper[1]}-${helper[0]}";
  }

  dynamic getLatLong() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } else if (status.isDenied) {
      CommonFunctions.showErrorSnackbar("Enable location first from settings.");
      await Permission.location.request();
      return "error";
    } else {
      CommonFunctions.showErrorSnackbar("Enable location first from settings.");
      return "error";
      // openAppSettings();
    }
  }

  getCurrentLocationAddress(var position) async {
    // currentlocation!.add(position.latitude);
    // currentlocation!.add(position.longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String street = placemarks.elementAt(0).street.toString();
    String subLocality = placemarks.elementAt(0).subLocality.toString();
    // String country = placemarks.elementAt(3).country.toString();
    String locality = placemarks.elementAt(0).locality.toString();
    String administrativeArea =
        placemarks.elementAt(0).administrativeArea.toString();

    String fulladdress = '$street,$subLocality,$locality,$administrativeArea';
    return fulladdress;
  }

  void logOut(BuildContext context) async {
    LocalPreferences().setLoginBool(false);
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.splashScreen, (route) => false);
    }
  }

  showPopUp({
    required BuildContext context,
    required double screenHeight,
    required double screenWidth,
    required VoidCallback onCameraClick,
    required VoidCallback onGalleryClick,
  }) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '____',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 17),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColumnImageTextHelper(
                          imagePath: Images.bycamera,
                          title: 'Camera',
                          onCLicked: onCameraClick,
                          sHeight: screenHeight,
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        ColumnImageTextHelper(
                          imagePath: Images.bygallery,
                          title: 'Gallery',
                          onCLicked: onGalleryClick,
                          sHeight: screenHeight,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  Future getCurrentAddressByLatLong(double latitude, double longitude) async {
    String address = "";
    try {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyBAy4wuelv36fwFPBBjQRvEjRkQE_f0ruA";
      var response = await http.get(Uri.parse(autoCompleteUrl));

      if (response.statusCode == 200) {
        var responsebody = json.decode(response.body);
        address = responsebody["results"][0]["formatted_address"];
      } else {
        address = "";
      }
    } catch (error) {
      address = "";
    }
    return address;
  }

  Future<dynamic> pickAndCropImage({required String from}) async {
    final picker = ImagePicker();
    final XFile? pickedFile;
    if (from == "camera") {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      // Crop the picked image
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ],
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        // Do something with the cropped image (e.g., display it or upload it)

        return croppedFile;
      } else {
        return null;
      }
    }
  }

  List<MultiSelectDialogItem<int>> getMachineType() {
    return <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(
        name: 'SCREW AIR COMPRESSOR',
        type: 'sep',
      ),
      MultiSelectDialogItem(
        name: 'AIRO-TECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'CP',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'ATLASCOPCO',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'ELGI',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'IR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'COMTECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PARTH TECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'MK ENG.',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'DEEP PNEUM.',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'OTHER',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'RECIPROCATING AIR COMPRESSOR',
        type: 'sep',
      ),
      MultiSelectDialogItem(
        name: 'AIRO-TECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'AIR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PARTH TECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'INDO AIR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PARAS',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'HERON',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PARAS',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'KUNAL PNEUM.',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'ELGI',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'RAJKOT',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'CP',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'ATLAS COPCO',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'OTHER',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'AIR DRYER',
        type: 'sep',
      ),
      MultiSelectDialogItem(
        name: 'AIRO-TECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'ANNAIR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'GENUS',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PARAS',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PARTH TECH',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'YUNIK AIR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'PAL AIR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'CLASSIC AIR',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'CONCEPT',
        type: 'data',
      ),
      MultiSelectDialogItem(
        name: 'OTHER',
        type: 'data',
      ),
    ];
  }
}

class ColumnImageTextHelper extends StatelessWidget {
  final double? sHeight;
  final String? imagePath;
  final String? title;
  final VoidCallback? onCLicked;
  const ColumnImageTextHelper(
      {super.key, this.sHeight, this.imagePath, this.onCLicked, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCLicked,
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath!,
            height: sHeight! * 0.04,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            title!,
            style:
                const TextStyle(color: blackColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
