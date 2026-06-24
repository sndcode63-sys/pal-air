
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utils/appcolors.dart';
import '../../Utils/local_shared_preferences.dart';
import '../../Utils/route_names.dart';
import '../../Widgets/common_button_loader.dart';
import 'permission_provider.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final permissionProvider =
          Provider.of<PermissionProvider>(context, listen: false);
      permissionProvider.checkNotificationStatus();
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  onResumed() {
    final permissionProvider =
        Provider.of<PermissionProvider>(context, listen: false);
    permissionProvider.checkNotificationStatus();
  }

  @override
  Widget build(BuildContext context) {
    final permissionProvider = Provider.of<PermissionProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 600),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    elevation: 7,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.elliptical(700, 200))),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              topRight: Radius.elliptical(700, 200))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Access ',
                            style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            'Permissions',
                            style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: PermissionWidget(
                  isLoading: permissionProvider.isStorageLoading,
                  onTap: () {
                    permissionProvider.requestStoragePermission();
                  },
                  status: permissionProvider.storage,
                  passIcon: Icons.folder,
                  permission: "Storage access",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: PermissionWidget(
                  isLoading: permissionProvider.isCameraLoading,
                  onTap: () {
                    permissionProvider.requestCameraPermission();
                  },
                  status: permissionProvider.camera,
                  passIcon: Icons.camera,
                  permission: "Camera access",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: PermissionWidget(
                  isLoading: permissionProvider.isLocationLoading,
                  onTap: () {
                    permissionProvider.requestLocationPermission();
                  },
                  status: permissionProvider.location,
                  passIcon: Icons.location_pin,
                  permission: "Location access",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: PermissionWidget(
                  isLoading: permissionProvider.isNotificationLoading,
                  onTap: () {
                    permissionProvider.requestNotificationPermission();
                  },
                  status: permissionProvider.notification,
                  passIcon: Icons.notifications_active_outlined,
                  permission: "App Notifications",
                ),
              ),
              // permissionProvider.allPermissionGranted()
              //     ? const SizedBox()
              //     : SizedBox(
              //         height: 15,
              //       ),
              // permissionProvider.allPermissionGranted()
              //     ? const SizedBox()
              //     : FadeInUp(
              //         duration: const Duration(milliseconds: 1200),
              //         child: Align(
              //           alignment: Alignment.center,
              //           child: InkWell(
              //             onTap: permissionProvider.isLoading
              //                 ? null
              //                 : () {
              //                     permissionProvider.requestAllPermissions();
              //                   },
              //             child: permissionProvider.isLoading
              //                 ? const SizedBox(
              //                     height: 15,
              //                     width: 15,
              //                     child: CircularProgressIndicator(
              //                       color: whiteColor,
              //                     ),
              //                   )
              //                 : Container(
              //                     decoration: BoxDecoration(
              //                         color: whiteColor,
              //                         borderRadius: BorderRadius.circular(8)),
              //                     padding:
              //                         EdgeInsets.symmetric(horizontal: 10),
              //                     child: Row(
              //                       mainAxisSize: MainAxisSize.min,
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.center,
              //                       children: [
              //                         const Icon(
              //                           Icons.done_all_outlined,
              //                           color: primaryColor,
              //                         ),
              //                         Text(
              //                           'Allow access to all Permission',
              //                           style: GoogleFonts.poppins(
              //                               color: primaryColor,
              //                               fontSize: 13,
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //           ),
              //         ),
              //       ),

              const SizedBox(
                height: 5,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1100),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(primaryColor),
                          elevation: WidgetStateProperty.all(5),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 18)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(25),
                                      topLeft: Radius.circular(
                                        25,
                                      ))))),
                      onPressed: permissionProvider.isLoading
                          ? null
                          : () async {
                              bool isLogin =
                                  await LocalPreferences().getLoginBool() ??
                                      false;
                              if (context.mounted) {
                                if (isLogin) {
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.homeScreen);
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, RouteNames.loginScreen);
                                }
                              }
                            },
                      child: permissionProvider.isLoading
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: whiteColor,
                              ),
                            )
                          : Text(
                              'Continue',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PermissionWidget extends StatelessWidget {
  final IconData passIcon;
  final String permission, status;
  final VoidCallback onTap;
  final bool isLoading;

  const PermissionWidget(
      {super.key,
      required this.passIcon,
      required this.permission,
      required this.status,
      required this.onTap,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Card(
            elevation: 7,
            shadowColor: primaryColor,
            shape: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: secondaryColor, shape: BoxShape.circle),
              child: Icon(
                passIcon,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                permission,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: blackColor),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: status == "Granted" ? Colors.green : Colors.red,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    status,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: blackColor),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          isLoading
              ? const CommonButtonLoader(indicatorColor: primaryColor)
              : status == "Granted"
                  ? const SizedBox()
                  : InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          status == "Permenantly Denied"
                              ? "Settings"
                              : "request",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              fontSize: 12),
                        ),
                      ),
                    )
          // Card(
          //   elevation: 7,
          //   shadowColor: darkBlueColor,
          //   margin: EdgeInsets.zero,
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          //   child: CupertinoSwitch(
          //     onChanged: onChanged,
          //     value: isValue,
          //     activeColor: secondaryColor,
          //   ),
          // )
        ],
      ),
    );
  }
}
