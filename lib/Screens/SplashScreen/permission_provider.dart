import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _storage = "",
      _notification = "",
      _camera = "",
      _location = "",
      _latitude = "",
      _longitude = "";
  String get storage => _storage;
  String get notification => _notification;
  String get camera => _camera;
  String get location => _location;
  String get latitude => _latitude;
  String get longitude => _longitude;

  bool _isStorageLoading = true;
  bool get isStorageLoading => _isStorageLoading;

  isStorageLoadingFun(bool val) {
    _isStorageLoading = val;
    notifyListeners();
  }

  bool _isCameraLoading = true;
  bool get isCameraLoading => _isCameraLoading;

  isCameraLoadingFun(bool val) {
    _isCameraLoading = val;
    notifyListeners();
  }

  bool _isLocationLoading = true;
  bool get isLocationLoading => _isLocationLoading;

  isLocationLoadingFun(bool val) {
    _isLocationLoading = val;
    notifyListeners();
  }

  bool _isNotificationLoading = true;
  bool get isNotificationLoading => _isNotificationLoading;

  isNotificationLoadingFun(bool val) {
    _isNotificationLoading = val;
    notifyListeners();
  }

  isLoadingFun(bool val) {
    _isLoading = val;
    _storage = "";
    _notification = "";
    _camera = "";
    _location = "";
    _isStorageLoading = true;
    _isCameraLoading = true;
    _isLocationLoading = true;
    _isNotificationLoading = true;
    notifyListeners();
  }

  bool allPermissionGranted() {
    return (_location == "Granted" &&
        _storage == "Granted" &&
        _notification == "Granted" &&
        _location == "Granted");
  }

  Future checkNotificationStatus() async {
    final plugin = DeviceInfoPlugin();
    PermissionStatus storageStatus;
    if (Platform.isAndroid) {
      final android = await plugin.androidInfo;
      storageStatus = android.version.sdkInt < 33
          ? await Permission.storage.request()
          : PermissionStatus.granted;
    } else {
      storageStatus = await Permission.storage.status;
    }

    PermissionStatus notificationStatus = await Permission.notification.status;
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;

    if (storageStatus.isGranted) {
      _storage = "Granted";
    } else if (storageStatus.isDenied) {
      _storage = "Denied";
    } else {
      _storage = "Permenantly Denied";
    }

    if (notificationStatus.isGranted) {
      _notification = "Granted";
    } else if (notificationStatus.isDenied) {
      _notification = "Denied";
    } else {
      _notification = "Permenantly Denied";
    }

    if (cameraStatus.isGranted) {
      _camera = "Granted";
    } else if (cameraStatus.isDenied) {
      _camera = "Denied";
    } else {
      _camera = "Permenantly Denied";
    }

    if (locationStatus.isGranted) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      }).catchError((e) {
        debugPrint(e);
      });
      _location = "Granted";
    } else if (locationStatus.isDenied) {
      _location = "Denied";
    } else {
      _location = "Permenantly Denied";
    }
    _isStorageLoading = false;
    _isCameraLoading = false;
    _isLocationLoading = false;
    _isNotificationLoading = false;
    notifyListeners();
  }

  Future requestStoragePermission() async {
    isStorageLoadingFun(true);
    // PermissionStatus status = await Permission.storage.request();
    final plugin = DeviceInfoPlugin();

    PermissionStatus storageStatus;
    if (Platform.isAndroid) {
      final android = await plugin.androidInfo;
      storageStatus = android.version.sdkInt < 33
          ? await Permission.storage.request()
          : PermissionStatus.granted;
    } else {
      storageStatus = await Permission.storage.status;
    }
    if (storageStatus.isGranted) {
      _storage = "Granted";
    } else if (storageStatus.isPermanentlyDenied) {
      await Permission.storage.status;
    } else {
      _storage = "Permenantly Denied";
      openAppSettings();
    }
    isStorageLoadingFun(false);
  }

  Future requestCameraPermission() async {
    isCameraLoadingFun(true);
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      _camera = "Granted";
    } else if (status.isPermanentlyDenied) {
      _camera = "Denied";
      await Permission.camera.request();
    } else {
      openAppSettings();
      _camera = "Permenantly Denied";
    }

    isCameraLoadingFun(false);
  }

  Future requestLocationPermission() async {
    isLocationLoadingFun(true);
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      _location = "Granted";
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      }).catchError((e) {
        debugPrint(e);
      });
    } else if (status.isDenied) {
      _location = "Denied";
      await Permission.location.request();
    } else {
      _location = "Permenantly Denied";
      openAppSettings();
    }
    isLocationLoadingFun(false);
  }

  Future requestNotificationPermission() async {
    isNotificationLoadingFun(true);
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      _notification = "Granted";
    } else if (status.isDenied) {
      _notification = "Denied";
      await Permission.notification.request();
    } else {
      openAppSettings();
      _notification = "Permenantly Denied";
    }
    isNotificationLoadingFun(false);
  }

  // Future<void> requestAllPermissions() async {
  //   isLoadingFun(true);
  //   final plugin = DeviceInfoPlugin();

  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.camera,
  //     Permission.storage,
  //     Permission.location,
  //     Permission.notification,
  //   ].request();

  //   statuses.forEach((permission, status) async {
  //     if (permission == Permission.camera) {
  //       if (status.isGranted) {
  //         _camera = "Granted";
  //       } else if (status.isDenied) {
  //         _camera = "Denied";
  //       } else {
  //         _camera = "Permenantly Denied";
  //       }
  //     }
  //     if (permission == Permission.notification) {
  //       if (status.isGranted) {
  //         _notification = "Granted";
  //       } else if (status.isDenied) {
  //         _notification = "Denied";
  //       } else {
  //         _notification = "Permenantly Denied";
  //       }
  //     }
  //     if (permission == Permission.location) {
  //       if (status.isGranted) {
  //         await Geolocator.getCurrentPosition(
  //                 desiredAccuracy: LocationAccuracy.high)
  //             .then((Position position) {
  //           _latitude = position.latitude.toString();
  //           _longitude = position.longitude.toString();
  //         }).catchError((e) {
  //           debugPrint(e);
  //         });
  //         _location = "Granted";
  //       } else if (status.isDenied) {
  //         _location = "Denied";
  //       } else {
  //         _location = "Permenantly Denied";
  //       }
  //     }
  //     if (permission == Permission.storage) {
  //       PermissionStatus storageStatus;
  //       if (Platform.isAndroid) {
  //         final android = await plugin.androidInfo;
  //         storageStatus = android.version.sdkInt < 33
  //             ? await Permission.storage.request()
  //             : PermissionStatus.granted;
  //       } else {
  //         storageStatus = await Permission.storage.status;
  //       }

  //       if (status.isGranted) {
  //         _storage = "Granted";
  //       } else if (status.isDenied) {
  //         _storage = "Denied";
  //       } else {
  //         _storage = "Permenantly Denied";
  //       }
  //     }
  //   });
  //   isLoadingFun(false);
  // }
}
