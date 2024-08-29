import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
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
  XFile? _imageFile;
  CroppedFile? _croppedFile;

  Future<void> getImage(ImageSource imageSource) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        _imageFile = pickedFile;
        await cropImage();
      }
    } catch (e) {
      print("디버깅용 이미지 호출 에러 : $e");
    }
  }

  Future<void> cropImage() async {
    if (_imageFile != null) {
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: _imageFile!.path, // 사용할 이미지 경로
          compressFormat: ImageCompressFormat.jpg, // 저장할 이미지 확장자(jpg/png)
          compressQuality: 50, // 저장할 이미지의 퀄리티
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: '이미지 자르기/회전하기', // 타이틀바 제목
                toolbarColor: Colors.deepOrange, // 타이틀바 배경색
                toolbarWidgetColor: Colors.white, // 타이틀바 단추색
                initAspectRatio:
                    CropAspectRatioPreset.original, // 이미지 크로퍼 시작 시 원하는 가로 세로 비율
                lockAspectRatio: false), // 고정 값으로 자르기 (기본값 : 사용안함)

            // iOS UI 설정
            IOSUiSettings(
              title: '이미지 자르기/회전하기', // 보기 컨트롤러의 맨 위에 나타나는 제목
            )
          ]);

      if (croppedFile != null) {
        final String? compressedImagePath =
            await compressImage(croppedFile.path);
        if (compressedImagePath != null) {
          setState(() {
            _croppedFile = CroppedFile(compressedImagePath);
          });
          widget.onImagePicked(compressedImagePath);
        }
      }
    }
  }

  Future<String?> compressImage(String path) async {
    final filePath = path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 50,
        format: CompressFormat.png,
      );
      return compressedImage?.path;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 50,
      );
      return compressedImage?.path;
    }
  }

  Widget _buildPhotoArea() {
    return Stack(
      children: [
        _imageFile != null
            ? Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(_croppedFile != null
                        ? _croppedFile!.path
                        : _imageFile!.path)),
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
        if (_croppedFile != null)
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                setState(() {
                  _croppedFile = null;
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
            child: Container(
              margin: EdgeInsets.only(
                bottom: 30,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getImage(ImageSource.gallery);
                      },
                      child: const SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image, size: 70, color: yellow),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                  color: dark_gray,
                                  fontWeight: FontWeight.w700),
                            )
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.camera_alt, size: 70, color: yellow),
                            Text(
                              "Camera",
                              style: TextStyle(
                                  color: dark_gray,
                                  fontWeight: FontWeight.w700),
                            )
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

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != null) {
      _imageFile = XFile(widget.imagePath!);
    }
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
}
