import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kedo_food/helper/utils.dart';
import 'package:kedo_food/infrastructure/page_button.dart';
import 'package:kedo_food/providers/auth_provider.dart';
import 'package:kedo_food/widgets/page_header.dart';
import 'package:kedo_food/widgets/shipping_address_form.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class UserProfile extends StatefulWidget {
  static const String routeName = 'UserProfile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool editUserDetails = false;
  bool uploadingDetails = false;
  late File? _storedImage = null;
  final GlobalKey<FormState> _formKey = GlobalKey();
  late Auth authProvider;
  List<Widget> getinitialWidgets(BuildContext context) {
    return [
      ...getPageHeader("Profile", context, titlePladding: 80),
      const SizedBox(
        height: 40,
      ),
    ];
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    setState(() {
      uploadingDetails = true;
    });
    await authProvider.updateUserProfile();
    setState(() {
      editUserDetails = false;
      uploadingDetails = false;
    });
  }

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
      uploadingDetails = true;
    });
    await authProvider.uploadUserProfile(_storedImage!);
    setState(() {
      uploadingDetails = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    authProvider = Provider.of<Auth>(context);
    return Scaffold(
        body:
            editUserDetails ? getEditDetailsDisplay() : getUserDetailDisplay());
  }

  Widget getEditDetailsDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...getinitialWidgets(context),
                Center(
                  child: GestureDetector(
                    onTap: _takePicture,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: _storedImage != null
                              ? DecorationImage(
                                  image: FileImage(
                                    _storedImage!,
                                  ),
                                  fit: BoxFit.cover)
                              : authProvider.userDetails.image.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        authProvider.userDetails.image,
                                      ),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: AssetImage(
                                        "assets/images/cameraIcon.png",
                                      ),
                                      fit: BoxFit.cover)),
                      child: authProvider.userDetails.image.isEmpty &&
                              _storedImage == null
                          ? const Text("Click to add profile image")
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                getTextInput(
                    initialValue: authProvider.userDetails.fullName,
                    placeHolder: "Full Name",
                    saved: (value) {
                      if (value != null && value.isNotEmpty) {
                        List<String> names = value.split(' ');
                        authProvider.userDetails = authProvider.userDetails
                            .copyTo(firstName: names[0]);
                        if (names.length > 1 && names[1].isNotEmpty) {
                          authProvider.userDetails = authProvider.userDetails
                              .copyTo(lastName: names[1]);
                        }
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                getTextInput(
                    initialValue: authProvider.userDetails.userName,
                    placeHolder: "Display Name",
                    saved: (value) {
                      if (value != null && value.isNotEmpty) {
                        authProvider.userDetails =
                            authProvider.userDetails.copyTo(userName: value);
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                getTextInput(
                    initialValue: authProvider.userDetails.emailAddress,
                    placeHolder: "Email Address",
                    saved: (value) {
                      if (value != null && value.isNotEmpty) {
                        authProvider.userDetails = authProvider.userDetails
                            .copyTo(emailAddress: value);
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                getTextInput(
                    initialValue: authProvider.userDetails.phone,
                    placeHolder: "Phone Number",
                    textFormatter: [TextMasking("(xxx) xxxx-xxxx")],
                    saved: (value) {
                      if (value != null && value.isNotEmpty) {
                        authProvider.userDetails =
                            authProvider.userDetails.copyTo(phone: value);
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                getTextInput(
                    initialValue: authProvider.userDetails.shippingAddress,
                    maxLines: 3,
                    placeHolder: "Address",
                    saved: (value) {
                      if (value != null && value.isNotEmpty) {
                        authProvider.userDetails = authProvider.userDetails
                            .copyTo(shippingAddress: value);
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                if (uploadingDetails)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  getPageButton("Update", _submit)
              ],
            ),
          )),
    );
  }

  Widget getUserDetailDisplay() {
    return SingleChildScrollView(
      child: Column(children: [
        ...getinitialWidgets(context),
        Center(
          child: Column(
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: authProvider.userDetails.image.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              authProvider.userDetails.image,
                            ),
                            fit: BoxFit.cover)
                        : const DecorationImage(
                            image: const AssetImage(
                              "assets/images/cameraIcon.png",
                            ),
                            fit: BoxFit.cover)),
                child: authProvider.userDetails.image.isEmpty
                    ? const Text("No Image Available")
                    : null,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                authProvider.userDetails.fullName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ...getUserDetailRow("User Name", authProvider.userDetails.userName),
        ...getUserDetailRow("Phone", authProvider.userDetails.phone),
        ...getUserDetailRow(
            "Email Address", authProvider.userDetails.emailAddress),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              const Text(
                "Address",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                authProvider.userDetails.shippingAddress,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ])),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Divider(
            height: 5,
            color: Colors.black,
          ),
        ),
        Center(
            child: TextButton(
                onPressed: () {
                  setState(() {
                    editUserDetails = true;
                  });
                },
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.green, fontSize: 22),
                )))
      ]),
    );
  }

  List<Widget> getUserDetailRow(String title, String data) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              data,
              style: const TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: const Divider(
          height: 5,
          color: Colors.black,
        ),
      ),
    ];
  }
}
