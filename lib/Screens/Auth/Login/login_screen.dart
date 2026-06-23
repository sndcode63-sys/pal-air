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
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTime now = DateTime.now();
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<LoginScreenProvider>(context, listen: false);
      provider.initData();
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Consumer<LoginScreenProvider>(
                      builder: (context, provider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Images.logo),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "꧁༺ ${DateFormat('dd-MM-yyyy').format(now)} ༻꧂",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoginTextField(
                            pref: const Icon(
                              CupertinoIcons.mail,
                              color: primaryColor,
                            ),
                            controllerValue: provider.ctlEmail,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            validate: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          provider.errorEmailText.isEmpty
                              ? Container()
                              : ErrorText(
                                  error: provider.errorEmailText,
                                  errorColor: Colors.red,
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                          LoginTextField(
                            pref: const Icon(
                              CupertinoIcons.lock,
                              color: primaryColor,
                            ),
                            obsText: provider.showHidePass,
                            suf: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () {
                                      provider.changeShowhidePass(
                                          provider.showHidePass);
                                    },
                                    child: Icon(
                                      provider.showHidePass
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: primaryColor,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      provider.clearPass(provider.showHidePass);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        CupertinoIcons.clear_circled,
                                        color: primaryColor,
                                      ),
                                    )),
                              ],
                            ),
                            controllerValue: provider.ctlPassword,
                            hintText: 'Password',
                            inputType: TextInputType.visiblePassword,
                            validate: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          provider.errorPasswordText.isEmpty
                              ? Container()
                              : ErrorText(
                                  error: provider.errorPasswordText,
                                  errorColor: Colors.red,
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    backgroundColor: primaryColor),
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        final isValid =
                                            _formKey.currentState!.validate();

                                        if (!isValid) {
                                          return;
                                        }
                                        _formKey.currentState!.save();

                                        provider.login(context);
                                      },
                                child: provider.isLoading
                                    ? const CommonButtonLoader(
                                        indicatorColor: primaryColor,
                                      )
                                    : Text(
                                        "Sign In",
                                        style: GoogleFonts.poppins(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
