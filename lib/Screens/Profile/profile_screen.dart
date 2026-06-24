import 'package:airo_tech/Utils/appcolors.dart';
import 'package:airo_tech/Utils/common_functions.dart';
import 'package:airo_tech/Utils/upload_images_helper.dart';
import 'package:airo_tech/Widgets/common_appbar.dart';
import 'package:airo_tech/Widgets/common_button_loader.dart';
import 'package:airo_tech/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

import 'profile_screen_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool colorChange = false;
  CroppedFile? document;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = Provider.of<ProfileScreenProvider>(context, listen: false);
      provider.getProfileData(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<ProfileScreenProvider>(
      context,
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: commonAppBar(context: context, heading: "Profile"),
        body: colorChange
            ? const SizedBox()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    UploadImagesHelperProfile(
                      uploadImage: () {
                        CommonFunctions().showPopUp(
                            context: context,
                            screenHeight: size.height,
                            screenWidth: size.width,
                            onCameraClick: () async {
                              Navigator.pop(context);
                              setState(() {
                                colorChange = true;
                              });
                              await CommonFunctions()
                                  .pickAndCropImage(from: "camera")
                                  .then((value) {
                                setState(() {
                                  colorChange = false;

                                  if (value != null) {
                                    document = value;
                                  }
                                });
                              });
                            },
                            onGalleryClick: () async {
                              Navigator.pop(context);
                              setState(() {
                                colorChange = true;
                              });
                              await CommonFunctions()
                                  .pickAndCropImage(from: "gallery")
                                  .then((value) {
                                setState(() {
                                  colorChange = false;

                                  if (value != null) {
                                    document = value;
                                  }
                                });
                              });
                            });
                      },
                      removeImage: () {
                        document = null;
                        setState(() {});
                      },
                      passedfile: document,
                      imagePath: provider.technicianModel.image,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Consumer<ProfileScreenProvider>(
                        builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              StepperTextField(
                                rOnly: true,
                                controllerValue: provider.ctlName,
                                inputType: TextInputType.text,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Username can't be empty.";
                                  } else {
                                    return null;
                                  }
                                },
                                hintValue: "Username",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              StepperTextField(
                                mLength: 10,
                                rOnly: true,
                                controllerValue: provider.ctlMobile,
                                inputType: TextInputType.phone,
                                validate: (val) {
                                  return null;
                                },
                                hintValue: "Mobile",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              StepperTextField(
                                rOnly: true,
                                controllerValue: provider.ctlEmail,
                                inputType: TextInputType.emailAddress,
                                validate: (val) {
                                  return null;
                                },
                                hintValue: "Email",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor),
                                  onPressed: provider.btnIsLoading
                                      ? null
                                      : () {
                                          var isValid =
                                              _formKey.currentState!.validate();

                                          if (!isValid) {
                                            return;
                                          }

                                          if (document == null) {
                                            CommonFunctions.showErrorSnackbar(
                                                "Select Image for update.");
                                          } else {
                                            provider.updateProfile(
                                                context, document);
                                          }

                                          _formKey.currentState!.save();
                                        },
                                  child: provider.btnIsLoading
                                      ? const CommonButtonLoader(
                                          indicatorColor: whiteColor)
                                      : Text(
                                          'Update',
                                          style: GoogleFonts.poppins(
                                              color: whiteColor),
                                        ))
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () {
            provider.employeeCheckOut(context).then((value) {
              CommonFunctions().logOut(context);
            });
          },
          label: provider.lgBtnLoading
              ? const CommonButtonLoader(indicatorColor: whiteColor)
              : Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: whiteColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'logout',
                      style: GoogleFonts.poppins(
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
