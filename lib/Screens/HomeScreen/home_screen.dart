import 'package:airo_tech/Screens/Profile/profile_screen_provider.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/images.dart';
import 'package:airo_tech/Utils/route_names.dart';
import 'package:airo_tech/Widgets/dashboard_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ProfileScreenProvider>(context, listen: false);
      provider.getProfileData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<ProfileScreenProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(

                  Images.logo,
                  width: size.width * 0.42,
                ),
                provider.isLoading
                    ? const SizedBox()
                    : InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, RouteNames.profileScreen),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            width: 40,
                            height: 40,
                            imageUrl: provider.technicianModel.image ?? "",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                              width: 25,
                              height: 25,
                              child: Shimmer(
                                colorOpacity: 0,
                                duration: const Duration(seconds: 3),
                                interval: const Duration(seconds: 5),
                                color: Colors.white,
                                direction: const ShimmerDirection.fromLTRB(),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: primaryColor),
                              child: const Icon(
                                CupertinoIcons.person,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 0.0,
                  children: [
                    FadeIn(
                      duration: const Duration(milliseconds: 800),
                      child: DashBoardWidget(
                        onPressed: () {
                          selectComplainType(context);
                          //    Navigator.pushNamed(context, RouteNames.newOrderScreen);
                        },
                        title: 'My Complains',
                        iconString: Images.mytasks,
                      ),
                    ),
                    FadeIn(
                      duration: const Duration(milliseconds: 800),
                      child: DashBoardWidget(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteNames.mainHistoryScreen);
                        },
                        title: 'History',
                        iconString: Images.mytasks,
                      ),
                    ),
                    FadeIn(
                      duration: const Duration(milliseconds: 700),
                      child: DashBoardWidget(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteNames.installationScreen);
                        },
                        title: 'Installation',
                        iconString: Images.installation,
                      ),
                    ),
                    FadeIn(
                      duration: const Duration(milliseconds: 700),
                      child: DashBoardWidget(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteNames.machineDispatchScreen);
                        },
                        title: 'New Machine\n Dispatch',
                        iconString: Images.newMachine,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  selectComplainType(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: primaryColor,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu,
                        color: whiteColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Complain/AMC',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pushNamed(RouteNames.otherCompanyMachineScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_outward_rounded,
                          color: whiteColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Other Company Machine',
                          style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_right_rounded,
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pushNamed(RouteNames.manageAeroTechMachineScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_outward_rounded,
                          color: whiteColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Manage AeroTech Machine',
                          style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_right_rounded,
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                // ListTile(
                //   horizontalTitleGap: 1,
                //   minLeadingWidth: 0,
                //   dense: true,
                //   contentPadding:
                //       const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                //   onTap: () {},
                //   title: Text(
                //     'Manage AeroTech Machine',
                //     style: GoogleFonts.poppins(
                //         fontSize: 12, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // ListTile(
                //   horizontalTitleGap: 1,
                //   minLeadingWidth: 0,
                //   dense: true,
                //   contentPadding:
                //       const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                //   onTap: () {},
                //   title: Text(
                //     'Other Company Machine',
                //     style: GoogleFonts.poppins(
                //         fontSize: 12, fontWeight: FontWeight.bold),
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        });
  }
}
