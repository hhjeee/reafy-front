import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reafy_front/src/utils/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class PickImage extends StatefulWidget {
  final Function(String) onImagePicked; // 콜백 함수

  const PickImage({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  //Uint8List? _image;
  final ImagePicker picker = ImagePicker();
  XFile? _image;

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
      /*setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
      widget.onImagePicked(pickedFile.path);*/
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

            //width: 300,
            //height: 250,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPhotoArea(),
                ])));

    /*
        child: _image != null
            ? Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.file(File(_image!.path)),
                    /*NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),*/
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ), /*
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(_image!),
                    fit: BoxFit.cover,
                  ),
                  //borderRadius: BorderRadius.circular(10), // 네모난 모양으로 설정
                ),*/
              )
            : Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: gray, width: 1)),
                child: Center(
                    child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: const Icon(Icons.add_a_photo_rounded,
                            color: gray)))));
 */
  }

  Widget _buildPhotoArea() {
    return Stack(
      //alignment: Alignment.center, // This ensures the stack is centered
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
                color: Color(0xFFFFD747), // Border color
                strokeWidth: 1, // Border width
                dashPattern: [2, 3],
                radius: const Radius.circular(5),
                borderType: BorderType.RRect, // Gap between dashes
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
      ],
    );
  }

  void _buildButton(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
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
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
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
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
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
