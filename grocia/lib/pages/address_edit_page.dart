import 'package:flutter/material.dart';
import 'package:grocia/constants/account-edit.const.dart';
import 'package:grocia/constants/address-edit.constants.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/model/address_model.dart';
import 'package:grocia/widgets/page-app-bar.dart';
import 'package:grocia/widgets/form_textbox.dart';

class AddressEditPage extends StatefulWidget {
  const AddressEditPage({super.key});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  // TODO: Add functionality to get Data from form and save
  final _formKey = GlobalKey<FormState>();
  AddressType selectedType = AddressType.Home;

  @override
  Widget build(BuildContext context) {
    final double sizeOfButton = MediaQuery.of(context).size.width * 0.31;
    final double sizeOfTabButtons = MediaQuery.of(context).size.width * 0.5;
    
    return Scaffold(
      appBar: getPageAppBar("Delivery Address", context),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...getInputForm(DELIVERY_ADDRESS),
                divider,
                ...getInputForm(COMPLETE_ADDRESS),
                divider,
                ...getInputForm(DELIVERY_INSTRUCTIONS),
                divider,
                Text("Nickname"),
                Row(
                  children: [
                    addressTypeSelector(
                        sizeOfButton,
                        "Home",
                        AddressType.Home,
                        BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        )),
                    addressTypeSelector(sizeOfButton, "Work", AddressType.Work,
                        BorderRadius.all(Radius.circular(0))),
                    addressTypeSelector(
                        sizeOfButton,
                        "Other",
                        AddressType.Other,
                        BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)))
                  ],
                )
              ],
            ),
          )),
      bottomSheet: Row(
        children: [
          SizedBox(
              width: sizeOfTabButtons,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Close",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kWhiteColor),
                    foregroundColor: MaterialStateProperty.all(kBlackColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))),
                    minimumSize:
                        MaterialStateProperty.all(Size.fromHeight(70))),
              )),
          SizedBox(
              width: sizeOfTabButtons,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Save changes",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          kGreenColor.withOpacity(0.7)),
                      foregroundColor: MaterialStateProperty.all(kWhiteColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                      minimumSize:
                          MaterialStateProperty.all(Size.fromHeight(70)))))
        ],
      ),
    );
  }

  

  SizedBox addressTypeSelector(double sizeOfButton, String title,
      AddressType type, BorderRadius borderRadius) {
    return SizedBox(
      width: sizeOfButton,
      child: TextButton(
          onPressed: () {
            setState(() {
              selectedType = type;
            });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  selectedType == type ? kGreyColor : kWhiteColor),
              foregroundColor: MaterialStateProperty.all(
                  selectedType == type ? kWhiteColor : kGreyColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  side: BorderSide(color: kGreyColor),
                  borderRadius: borderRadius))),
          child: Text(title)),
    );
  }
}
