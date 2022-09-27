import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/page_button.dart';
import 'package:kedo_food/model/orderDetail.dart';

class ShippingAddressForm extends StatefulWidget {
  final Function getTextInput;
  final Function(OrderDetail, bool) onPress;
  late OrderDetail shippingData;
  ShippingAddressForm(
      {Key? key,
      required this.getTextInput,
      required this.onPress,
      required this.shippingData})
      : super(key: key);

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm>
    with SingleTickerProviderStateMixin {
  final _fullNameNode = FocusNode();
  final _email = FocusNode();
  final _phone = FocusNode();
  final _address = FocusNode();
  final _zipCode = FocusNode();
  final _city = FocusNode();
  final _country = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  bool saveShippingAddress = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0))
        .then((value) => _controller.forward());
    saveShippingAddress = widget.shippingData.deliveryUserName.isNotEmpty;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(
                node: _fullNameNode,
                initialValue: widget.shippingData.deliveryUserName,
                inputAction: TextInputAction.next,
                validate: (value) {
                  if (value.toString().isEmpty) {
                    return "Full name is required";
                  }
                },
                onSaved: (value) {
                  print("after submitted");
                  widget.shippingData =
                      widget.shippingData.copyWith(deliveryUserName: value);
                  FocusScope.of(context).requestFocus(_email);
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Email Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(
                inputAction: TextInputAction.next,
                initialValue: widget.shippingData.deliveryUserEmail,
                node: _email,
                validate: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid Email';
                  }
                },
                onSaved: (value) {
                  print("after submitted");
                  widget.shippingData =
                      widget.shippingData.copyWith(deliveryUserEmail: value);
                  FocusScope.of(context).requestFocus(_phone);
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Phone Number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(
                inputAction: TextInputAction.next,
                inputType: TextInputType.phone,
                initialValue: widget.shippingData.deliveryUserPhone,
                node: _phone,
                validate: (value) {
                  if (value.toString().isEmpty) {
                    return "phone number is required";
                  }
                  if (!value
                      .toString()
                      .contains(RegExp(r'\([0-9]{3}\) [0-9]{4}-[0-9]{4}'))) {
                    return "phone number format (000) 0000-0000";
                  }
                },
                onSaved: (value) {
                  print("after submitted");
                  widget.shippingData =
                      widget.shippingData.copyWith(deliveryUserPhone: value);
                  FocusScope.of(context).requestFocus(_address);
                }),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.getTextInput(
                maxLines: 3,
                inputAction: TextInputAction.newline,
                initialValue: widget.shippingData.deliveryAddress,
                node: _address,
                validate: (value) {
                  if (value.toString().isEmpty) {
                    return "Address is required";
                  }
                },
                onSaved: (value) {
                  print("after submitted");
                  widget.shippingData =
                      widget.shippingData.copyWith(deliveryAddress: value);
                  FocusScope.of(context).requestFocus(_zipCode);
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Zip Code",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 155,
                        child: widget.getTextInput(
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.number,
                            initialValue: widget.shippingData.deliveryZipCode,
                            node: _zipCode,
                            validate: (value) {
                              if (value.toString().isEmpty) {
                                return "Zip code is required";
                              }
                            },
                            onSaved: (value) {
                              print("after onSaved");
                              widget.shippingData = widget.shippingData
                                  .copyWith(deliveryZipCode: value);
                              FocusScope.of(context).requestFocus(_city);
                            })),
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "City",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 155,
                        child: widget.getTextInput(
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.text,
                            initialValue: widget.shippingData.deliveryCity,
                            validate: (value) {
                              if (value.toString().isEmpty) {
                                return "City is required";
                              }
                              if (value.toString().contains(RegExp('[0-9]+'))) {
                                return "City cannot have numbers";
                              }
                            },
                            node: _city,
                            onSaved: (value) {
                              print("after submitted");
                              widget.shippingData = widget.shippingData
                                  .copyWith(deliveryCity: value);
                              FocusScope.of(context).requestFocus(_country);
                            })),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Country",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            // Convert this to a dropdown
            widget.getTextInput(
                node: _country,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                initialValue: widget.shippingData.deliveryCountry,
                validate: (value) {
                  if (value.toString().isEmpty) {
                    return "Country is required";
                  }
                  if (value.toString().contains(RegExp('[0-9]+'))) {
                    return "Country cannot have numbers";
                  }
                },
                onSaved: (value) {
                  print("after submitted");
                  widget.shippingData =
                      widget.shippingData.copyWith(deliveryCountry: value);
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Checkbox(
                    value: saveShippingAddress,
                    onChanged: (value) {
                      setState(() {
                        saveShippingAddress = value as bool;
                      });
                    }),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Save shipping address",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            getPageButton("NEXT", () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              //_formKey.currentState?.reset();
              widget.onPress(widget.shippingData, saveShippingAddress);
            }),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
