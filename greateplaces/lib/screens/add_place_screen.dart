import 'package:flutter/material.dart';
import 'package:greateplaces/Widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a New Place'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,),
                    SizedBox(height: 10,),
                    ImageInput()
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.secondary),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Add Place'))
          ],
        ));
  }
}
