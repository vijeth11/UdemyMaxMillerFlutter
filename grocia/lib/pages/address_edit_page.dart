import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class AddressEditPage extends StatefulWidget {
  const AddressEditPage({super.key});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: kWhiteColor,
        title: const Text("Delivery Address"),
        actions: [
          IconButton(
              onPressed: () {
                ModalRoute.of(context)?.navigator;
              },
              icon: const Icon(
                Icons.close,
                color: kGreyLightColor,
              ))
        ],
      ),
      body: Form(key: _formKey, child: Column()),
    );
  }
}
