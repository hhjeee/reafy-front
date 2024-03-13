import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PickImage extends StatefulWidget {
  final Function(String?) onImagePicked;
  final String? imagePath;

  const PickImage({Key? key, required this.onImagePicked, this.imagePath})
      : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final ImagePicker picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != null) {
      _image = XFile(widget.imagePath!);
    }
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      String? compressedImagePath = await compressImage(pickedFile.path);
      if (compressedImagePath != null) {
        setState(() {
          _image = XFile(compressedImagePath);
        });
        widget.onImagePicked(compressedImagePath);
      }
    }
  }

  Future<String?> compressImage(String path) async {
    final filePath = path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    var compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 50, // 압축 품질 설정
    );

    return compressedImage?.path;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPhotoArea(),
                ])));
  }

  Widget _buildPhotoArea() {
    return Stack(
      children: [
        _image != null
            ? Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(_image!.path)),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            : DottedBorder(
                color: Color(0xFFFFD747),
                strokeWidth: 1,
                dashPattern: [2, 3],
                radius: const Radius.circular(5),
                borderType: BorderType.RRect,
                child: Container(
                    width: double.infinity,
                    height: 84,
                    color: Color(0xFFFFF7D9).withOpacity(0.5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.add_a_photo_rounded, color: yellow),
                            iconSize: 30,
                            onPressed: () => _buildButton(context),
                          ),
                          Text(
                            "사진 첨부하기",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: yellow),
                          )
                        ])),
              ),
        if (_image != null)
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  _image = null;
                });
                widget.onImagePicked(null);
              },
              child: Icon(Icons.cancel, color: Color(0xFFFFD747), size: 24),
            ),
          ),
      ],
    );
  }

  void _buildButton(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Color(0xFFFFF7D9),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getImage(ImageSource.gallery);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.image, size: 70, color: yellow),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt, size: 70, color: yellow),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
