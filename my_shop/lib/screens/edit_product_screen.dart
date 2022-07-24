import 'package:flutter/material.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';

import '../widgets/display_error.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/editProduct';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageFocusNode = FocusNode();
  bool isInit = true;
  bool isLoading = false;
  Product product =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  // the type present in Global key create a attribute in state and hooks to
  // the form
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";

  @override
  void initState() {
    _imageFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        product = Provider.of<Products>(context, listen: false)
            .findById(productId as String);
        _imageController.text = imageUrl = product.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {
        imageUrl = _imageController.text;
      });
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _discriptionFocusNode.dispose();
    _imageFocusNode.removeListener(updateImageUrl);
    _imageFocusNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void saveForm() {
    var isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      isLoading = true;
    });
    if (product.id.isEmpty) {
      Provider.of<Products>(context, listen: false)
          .addProduct(product)
          .then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }).catchError((error) {
        displayError(
            error,
            context,
            () => setState(() {
                  isLoading = false;
                }));
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(product.id, product)
          .then((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }).catchError((error) => displayError(
              error,
              context,
              () => setState(() {
                    isLoading = false;
                  })));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  // you can use autoValidateMode to call validate function of text fields on each key stroke
                  // insted of validating on save click
                  key: _formKey,
                  child: ListView(children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      initialValue: product.title,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Please provide a value'
                            : null;
                      },
                      onSaved: (value) {
                        product = Product(
                            id: product.id,
                            favourite: product.favourite,
                            title: value ?? '',
                            description: product.description,
                            price: product.price,
                            imageUrl: product.imageUrl);
                      },
                    ),
                    TextFormField(
                        decoration: const InputDecoration(labelText: 'Price'),
                        initialValue: product.price.toString(),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_discriptionFocusNode),
                        validator: (value) {
                          return (value ?? '').isEmpty
                              ? 'Please enter a price'
                              : double.tryParse(value ?? '') == null
                                  ? 'please enter a valid number'
                                  : double.parse(value ?? '0') <= 0
                                      ? 'please enter a number  greated than 0'
                                      : null;
                        },
                        onSaved: (value) {
                          product = Product(
                              id: product.id,
                              favourite: product.favourite,
                              title: product.title,
                              description: product.description,
                              price: double.parse(value ?? '0'),
                              imageUrl: product.imageUrl);
                        }),
                    TextFormField(
                        maxLines: 3,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        initialValue: product.description,
                        keyboardType: TextInputType.multiline,
                        focusNode: _discriptionFocusNode,
                        validator: (value) {
                          return (value ?? '').isEmpty
                              ? 'Please enter a description'
                              : (value ?? '').length <= 10
                                  ? 'Please enter more than 10 characters'
                                  : null;
                        },
                        onSaved: (value) {
                          product = Product(
                              id: product.id,
                              favourite: product.favourite,
                              title: product.title,
                              description: value ?? '',
                              price: product.price,
                              imageUrl: product.imageUrl);
                        }),
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: imageUrl.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(imageUrl),
                                )),
                      Expanded(
                          child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Image Url'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageController,
                              focusNode: _imageFocusNode,
                              validator: (value) {
                                return (value ?? '').isEmpty
                                    ? 'Please enter an image url'
                                    : (!(value ?? '').startsWith('http') &&
                                                !(value ?? '')
                                                    .startsWith('https')) ||
                                            (!(value ?? '').endsWith('jpeg') &&
                                                !(value ?? '')
                                                    .endsWith('jpg') &&
                                                !(value ?? '').endsWith('png'))
                                        ? 'Please enter a valid image url'
                                        : null;
                              },
                              onFieldSubmitted: (value) {
                                setState(() {
                                  imageUrl = value;
                                });
                                saveForm();
                              },
                              onSaved: (value) {
                                product = Product(
                                    id: product.id,
                                    favourite: product.favourite,
                                    title: product.title,
                                    description: product.description,
                                    price: product.price,
                                    imageUrl: value ?? '');
                              }))
                    ]),
                  ])),
            ),
    );
  }
}
