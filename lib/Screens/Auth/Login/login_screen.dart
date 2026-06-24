import 'package:airo_tech/Screens/Auth/Login/login_screen_provider.dart';
import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/images.dart';
import 'package:airo_tech/Widgets/common_button_loader.dart';
import 'package:airo_tech/Widgets/error_found_widgets.dart';
import 'package:airo_tech/Widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTime now = DateTime.now();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LoginScreenProvider>(context, listen: false).initData();
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Top brand section
                SizedBox(
                  height: size.height * 0.32,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                          )],
                        ),
                        padding: const EdgeInsets.all(14),
                        child: Image.asset(Images.appLogo),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "PAL-AIR",
                        style: GoogleFonts.rajdhani(
                          color: whiteColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 5,
                        ),
                      ),
                      Text(
                        "Leader in Ventilation Technology",
                        style: GoogleFonts.poppins(
                          color: whiteColor.withOpacity(0.75),
                          fontSize: 10,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                // White form card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                      child: Consumer<LoginScreenProvider>(
                        builder: (context, provider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back",
                                style: GoogleFonts.poppins(
                                  color: secondaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DateFormat('EEEE, dd MMM yyyy').format(now),
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text("Email", style: _labelStyle()),
                              const SizedBox(height: 6),
                              LoginTextField(
                                pref: const Icon(CupertinoIcons.mail, color: primaryColor, size: 20),
                                controllerValue: provider.ctlEmail,
                                hintText: 'Enter your email',
                                inputType: TextInputType.emailAddress,
                                validate: (val) => val!.isEmpty ? "Can't be Empty." : null,
                              ),
                              if (provider.errorEmailText.isNotEmpty)
                                ErrorText(error: provider.errorEmailText, errorColor: primaryColor),
                              const SizedBox(height: 16),
                              Text("Password", style: _labelStyle()),
                              const SizedBox(height: 6),
                              LoginTextField(
                                pref: const Icon(CupertinoIcons.lock, color: primaryColor, size: 20),
                                obsText: provider.showHidePass,
                                suf: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () => provider.changeShowhidePass(provider.showHidePass),
                                      child: Icon(
                                        provider.showHidePass ? Icons.visibility_off : Icons.visibility,
                                        color: primaryColor, size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () => provider.clearPass(provider.showHidePass),
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(CupertinoIcons.clear_circled, color: primaryColor, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                controllerValue: provider.ctlPassword,
                                hintText: 'Enter your password',
                                inputType: TextInputType.visiblePassword,
                                validate: (val) => val!.isEmpty ? "Can't be Empty." : null,
                              ),
                              if (provider.errorPasswordText.isNotEmpty)
                                ErrorText(error: provider.errorPasswordText, errorColor: primaryColor),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    backgroundColor: primaryColor,
                                    elevation: 3,
                                  ),
                                  onPressed: provider.isLoading
                                      ? null
                                      : () async {
                                          if (!_formKey.currentState!.validate()) return;
                                          _formKey.currentState!.save();
                                          provider.login(context);
                                        },
                                  child: provider.isLoading
                                      ? const CommonButtonLoader(indicatorColor: whiteColor)
                                      : Text(
                                          "Sign In",
                                          style: GoogleFonts.poppins(
                                            color: whiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _labelStyle() => GoogleFonts.poppins(
        color: secondaryColor,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );
}
