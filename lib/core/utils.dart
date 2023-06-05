import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

void showSnackBar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<Uint8List> pickImage()async{
  final picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.gallery);
  return imageFile!.readAsBytes();
}
