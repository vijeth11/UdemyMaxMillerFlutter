import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/constants/constants.dart';
import 'package:grocia/model/user_model.dart';
import 'package:grocia/pages/password_change_page.dart';
import 'package:grocia/provider/auth.provider.dart';
import 'package:grocia/widgets/account-option-tile.dart';
import 'package:grocia/widgets/create_animated_router.dart';
import 'package:grocia/widgets/form_textbox.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:grocia/widgets/user-profile-info-section.dart';
import 'package:provider/provider.dart';

class AccountEditScreen extends StatefulWidget {
  const AccountEditScreen({super.key});

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserModel item = Provider.of<AuthProvider>(context, listen: false).item;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                // TODO: open a drawer on click of menu
              },
              icon: const Icon(
                Icons.menu,
                color: kBlackColor,
              ))
        ],
        foregroundColor: kBlackColor,
        backgroundColor: kGreyLightColor,
        elevation: 1.0,
        title: const Text(
          "Edit My Account",
          style: screenHeaderStyle,
        ),
      ),
      body: Column(
        children: [
          UserProfileInfoSection(
            item: item,
            isEdit: true,
          ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getInputForm(FULL_NAME),
                    divider,
                    ...getInputForm(MOBILE_NUMBER),
                    divider,
                    ...getInputForm(EMAIL),
                    const SizedBox(
                      height: 10,
                    ),
                    SaveChangesButton(
                      onPress: () {
                        // need to implement save part
                      },
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 5,
          ),
          AccountOptionTile(
            titleName: "Change Password",
            leadingIcon: [],
            displayBoxArroundArrowIcon: false,
            onTap: () {
              Navigator.of(context)
                  .push(CreateRoute(const PasswordChangePage()));
            },
          )
        ],
      ),
    );
  }
}
