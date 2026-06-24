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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileScreenProvider>(context, listen: false)
          .getProfileData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ProfileScreenProvider>(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Red header bar
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

            // Dashboard
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
                      child: Text(
                        "Dashboard",
                        style: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      children: [
                        FadeIn(
                          duration: const Duration(milliseconds: 800),
                          child: DashBoardWidget(
                            onPressed: () => selectComplainType(context),
                            title: 'My Complains',
                            iconString: Images.mytasks,
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(milliseconds: 800),
                          child: DashBoardWidget(
                            onPressed: () => Navigator.pushNamed(context, RouteNames.mainHistoryScreen),
                            title: 'History',
                            iconString: Images.mytasks,
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(milliseconds: 700),
                          child: DashBoardWidget(
                            onPressed: () => Navigator.pushNamed(context, RouteNames.installationScreen),
                            title: 'Installation',
                            iconString: Images.installation,
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(milliseconds: 700),
                          child: DashBoardWidget(
                            onPressed: () => Navigator.pushNamed(context, RouteNames.machineDispatchScreen),
                            title: 'New Machine\n Dispatch',
                            iconString: Images.newMachine,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectComplainType(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: whiteColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.menu, color: primaryColor),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Complain / AMC',
                    style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w700, color: secondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _sheetOption(
                context: context,
                icon: Icons.precision_manufacturing_outlined,
                title: 'Other Company Machine',
                subtitle: 'Log complaint for non-PAL-Air units',
                onTap: () {
                  Navigator.of(context)
                    ..pop()
                    ..pushNamed(RouteNames.otherCompanyMachineScreen);
                },
              ),
              const SizedBox(height: 10),
              _sheetOption(
                context: context,
                icon: Icons.air_rounded,
                title: 'Manage PAL-Air Machine',
                subtitle: 'AMC & complaints for PAL-Air units',
                onTap: () {
                  Navigator.of(context)
                    ..pop()
                    ..pushNamed(RouteNames.manageAeroTechMachineScreen);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: whiteColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 13, color: secondaryColor,
                  )),
                  Text(subtitle, style: GoogleFonts.poppins(
                    fontSize: 10, color: Colors.grey[500],
                  )),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
