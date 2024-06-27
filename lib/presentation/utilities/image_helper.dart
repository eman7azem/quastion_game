import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';

class ImageHelper {
  static Future<File?> showImageSourceDialog(BuildContext context) async {
    Completer<File?> completer = Completer<File?>();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              'اختار صورة',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Ah-moharram-bold',
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'الكاميرا',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Ah-moharram-bold',
                  ),
                ),
                onPressed: () async {
                  completer.complete(await getImage(ImageSource.camera));
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'معرض الصور',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Ah-moharram-bold',
                  ),
                ),
                onPressed: () async {
                  completer.complete(await getImage(ImageSource.gallery));
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }

  static Future<File?> getImage(ImageSource source) async {
    File? image;
    final imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(
      source: source,
    );
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    return image;
  }
}
