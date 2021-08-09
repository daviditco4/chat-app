import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart' as p;

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImg;

  Future<void> _pickImage({required p.ImageSource source}) async {
    final imagePicker = p.ImagePicker();
    const imageDim = 500.0;
    final p.PickedFile? image = await imagePicker.getImage(
      source: source,
      maxWidth: imageDim,
      maxHeight: imageDim,
      preferredCameraDevice: p.CameraDevice.front,
    );

    if (image != null) {
      setState(() => _pickedImg = File(image.path));
      // widget.pickImgCallback(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    const imgR = 48.0;
    final sch = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: imgR,
          backgroundColor: sch.primary,
          foregroundImage: _pickedImg == null ? null : FileImage(_pickedImg!),
          child: Icon(Icons.person_rounded, size: imgR * 2, color: sch.surface),
        ),
        const SizedBox(height: 6.0),
        TextButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
          onPressed: () => _pickImage(source: p.ImageSource.camera),
        ),
        TextButton.icon(
          icon: const Icon(Icons.photo_library),
          label: const Text('Choose From Gallery'),
          onPressed: () => _pickImage(source: p.ImageSource.gallery),
        ),
      ],
    );
  }
}
