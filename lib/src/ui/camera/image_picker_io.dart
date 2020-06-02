import 'dart:async';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Future<String> pickImage(String imageFile) async {
  final file =
  File(imageFile);
  return file.path;
}
