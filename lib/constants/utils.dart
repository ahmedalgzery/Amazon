import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// Function to display a SnackBar message
void showSnackBar(BuildContext context, String text,bool status) {
  if (status == true){
  return showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message:
          text,
    ));}
    else{
      return showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message:
          text,
    ));
    }

}

// Function to pick multiple images using FilePicker
Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image, // Select only image files
      allowMultiple: true, // Allow selection of multiple files
    );

    if (files != null && files.files.isNotEmpty) {
      for (var i = 0; i < files.files.length; i++) {
        images.add(
          File(files.files[i].path!), // Add selected image files to the list
        );
      }
    }
  } catch (e) {
    debugPrint(e.toString()); // Print any errors that occur during the process
  }
  return images; // Return the list of selected image files
}
