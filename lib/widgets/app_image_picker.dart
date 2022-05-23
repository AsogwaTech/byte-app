import 'dart:io';

import 'package:etra_flutter/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future selectImage(BuildContext context, Function(dynamic) onImageSelected,
    {CropperConfig? cropperConfig,
    bool? cropAfterSelection,
    List<ImageSource> imageSources = const [ImageSource.gallery]}) async {
  if (imageSources.length == 1) {
    showImagePicker(context, imageSources[0], onImageSelected, cropperConfig!,
        cropAfterSelection!);
    return;
  }
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (_) {
      return AppImagePicker(
        onImageSelected: (f) {
          Navigator.pop(context);
          onImageSelected.call(f);
        },
        cropAfterSelection: cropAfterSelection!,
        cropperConfig: cropperConfig!,
      );
    },
  );
}

void showImagePicker(
    BuildContext context,
    ImageSource source,
    Function(dynamic) onImageSelected,
    CropperConfig cropperConfig,
    bool cropAfterSelection) async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: source);
  if (pickedFile == null) {
    return;
  }
  if (!cropAfterSelection) {
    if (kIsWeb) {
      onImageSelected.call(await pickedFile.readAsBytes());
    } else {
      onImageSelected.call(File(pickedFile.path));
    }
    return;
  }
  File? f;
  try {
    f = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: cropperConfig.aspectRatioPresets,
        androidUiSettings: cropperConfig.androidUiSettings,
        iosUiSettings: cropperConfig.iosUiSettings);
    onImageSelected.call(f);
  } catch (e) {
    print(e);
  }
}

class AppImagePicker extends StatefulWidget {
  final bool cropAfterSelection;
  final CropperConfig cropperConfig;
  final Function(dynamic)? onImageSelected;

  const AppImagePicker({
    Key? key,
    this.cropAfterSelection = false,
    this.cropperConfig = const CropperConfig(
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    ),
    @required this.onImageSelected,
  }) : super(key: key);

  @override
  _AppImagePickerState createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 100,
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            GridView(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.camera);
                  },
                  child: GridTile(
                    child: Icon(
                      Icons.camera_alt,
                      size: 60,
                      color: appPrimaryColor,
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Camera',
                          textScaleFactor: 1.2,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                  },
                  child: GridTile(
                    child: Icon(
                      Icons.photo,
                      size: 60,
                      color: appPrimaryColor,
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Gallery', textScaleFactor: 1.2),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void pickImage(ImageSource source) async {
    showImagePicker(context, source, widget.onImageSelected!,
        widget.cropperConfig, widget.cropAfterSelection);
  }
}

class CropperConfig {
  final List<CropAspectRatioPreset> aspectRatioPresets;
  final AndroidUiSettings androidUiSettings;
  final IOSUiSettings iosUiSettings;

  const CropperConfig(
      {this.aspectRatioPresets = const [],
      this.androidUiSettings = const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      this.iosUiSettings = const IOSUiSettings(
        minimumAspectRatio: 1.0,
      )});
}
