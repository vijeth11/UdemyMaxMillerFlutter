import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function onSelecImage;

  const ImageInput(this.onSelecImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late File? _storedImage = null;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await imageFile.saveTo('${appDir.path}/$fileName');
    widget.onSelecImage(File('${appDir.path}/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken!',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(width: 20),
        Expanded(
            child: TextButton.icon(
          icon: Icon(Icons.camera),
          onPressed: _takePicture,
          label: Text('Take Picture'),
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor)),
        ))
      ],
    );
  }
}
