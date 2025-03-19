// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'dart:io';

import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../gen/assets.gen.dart';

class UploadImageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadImageWidgetState();
  }
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 180,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  hasPicture()
                      ? ColorUtil.color4D303030
                      : ColorUtil.colorFFF7F7F7,
            ),
            child: Stack(
              children: [
                if (hasPicture())
                  Center(
                    child: Image.file(File(imagePath!), fit: BoxFit.fitHeight),
                  ),
                if (!hasPicture())
                  Positioned(
                    bottom: 45,
                    left: 0,
                    right: 0,
                    child: Align(
                      child: Text(
                        AppLocalizations.of(context)!.click_upload_bank_card,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorUtil.colorFF445FF1,
                        ),
                      ),
                    ),
                  ),
                if (!hasPicture())
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 40,
                    child: InkWell(
                      child: Assets.icon.iconTakePhoto.svg(),

                      onTap: () async {
                        showChoosePictureDialog();
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (hasPicture()) _buildDelete(),
      ],
    );
  }

  void showChoosePictureDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                child: InkWell(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.take_photo,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorUtil.color303030,
                      ),
                    ),
                  ),
                  onTap: () {
                    pickFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Divider(color: ColorUtil.colorFFF6F6F6, height: 1),
              Container(
                height: 50,
                child: InkWell(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.picker_from_gallery,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorUtil.color303030,
                      ),
                    ),
                  ),
                  onTap: () {
                    pickFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Divider(color: ColorUtil.colorFFF6F6F6, height: 1),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 50,
                  child: Align(
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorUtil.color303030,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDelete() {
    return InkWell(
      child: Container(
        height: 34,
        width: 34,
        padding: EdgeInsets.all(9),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorUtil.colorFFF7F7F7,
        ),
        child: Assets.icon.iconDelete.svg(),
      ),
      onTap: () {
        setState(() {
          imagePath = null;
        });
      },
    );
  }

  void pickFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        imagePath = photo.path;
      });
    }
  }

  bool hasPicture() {
    return imagePath != null;
  }

  void pickFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imagePath = photo.path;
      });
    }
  }
}
