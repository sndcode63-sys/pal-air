import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/local_shared_preferences.dart';
import '../../Utils/route_names.dart';

class SplashScreenProvider with ChangeNotifier {
  Future<void> checkVersion(BuildContext context) async {
    getislogin(context);
    // if (Platform.isAndroid) {
    //   if (info.version.isNotEmpty) {
    //     _verifyVersionAndroid(context);
    //   }
    // } else if (Platform.isIOS) {
    //   if (info.version.isNotEmpty) {
    //     _verifyVersion(context);
    //   }
    // }
  }

  getislogin(BuildContext context) async {
    final plugin = DeviceInfoPlugin();
    PermissionStatus storageStatus;
    PermissionStatus notificationStatus = await Permission.notification.status;

    // Check if running on web
    if (kIsWeb) {
      storageStatus = PermissionStatus.granted;
    } else if (Platform.isAndroid) {
      final android = await plugin.androidInfo;

      if (android.version.sdkInt < 33) {
        storageStatus = await Permission.storage.status;
      } else {
        storageStatus = PermissionStatus.granted;
      }
    } else {
      storageStatus = await Permission.storage.status;
    }

    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;

    if (notificationStatus.isGranted &&
        cameraStatus.isGranted &&
        locationStatus.isGranted &&
        storageStatus.isGranted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DateTime now = DateTime.now();
      String formattedDate = '${now.year}-${now.month}-${now.day}';

      String? lastDate = prefs.getString('lastDate');

      if (lastDate != formattedDate) {
        if (context.mounted) {
          LocalPreferences().setLoginBool(false);
          prefs.setString('lastDate', formattedDate);
          Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
        }
      } else {
        Future.delayed(const Duration(seconds: 3), () async {
          bool isLogin = await LocalPreferences().getLoginBool() ?? false;
          if (context.mounted) {
            if (isLogin) {
              Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
            } else {
              Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
            }
          }
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteNames.permissionScreen);
      });
    }
  }
}
