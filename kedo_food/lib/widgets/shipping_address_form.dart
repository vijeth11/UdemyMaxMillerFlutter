import 'package:flutter/material.dart';
import 'package:kedo_food/infrastructure/page_button.dart';

class ShippingAddressForm extends StatefulWidget {
  final Function getTextInput;
  final VoidCallback onPress;
  const ShippingAddressForm(
      {Key? key, required this.getTextInput, required this.onPress})
      : super(key: key);

  @override
  State<ShippingAddressForm> createState() => _ShippingAddressFormState();
}

class _ShippingAddressFormState extends State<ShippingAddressForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0))
        .then((value) => _controller.forward());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
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
          widget.getTextInput(),
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
          widget.getTextInput(),
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
          widget.getTextInput(maxLines: 3),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(width: 155, child: widget.getTextInput()),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(width: 155, child: widget.getTextInput()),
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
          widget.getTextInput(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
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
          getPageButton("NEXT", widget.onPress),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
