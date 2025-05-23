import 'dart:io';

import 'package:dentilligence/constance/text_styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSelectionPage extends StatefulWidget {
  const PhotoSelectionPage({Key? key}) : super(key: key);

  @override
  State<PhotoSelectionPage> createState() => _PhotoSelectionPageState();
}

class _PhotoSelectionPageState extends State<PhotoSelectionPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _showTextField = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _showDialogBox(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSourceButton(
                icon: Icons.photo_library,
                label: "Gallery",
                onTap: () {
                  Navigator.pop(context); // Close the sheet
                  _pickImage(ImageSource.gallery); // Your image picking logic
                },
              ),
              SizedBox(width: 20.w),
              _buildSourceButton(
                icon: Icons.camera_alt,
                label: "Camera",
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color.fromRGBO(255, 210, 38, 0.2),
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 196, 32, 0.2),
                      Color.fromRGBO(245, 103, 253, 0.1),
                      Color.fromRGBO(245, 103, 253, 0.2),
                      Color.fromRGBO(42, 202, 234, 0.1),
                    ],
                    stops: [0.0, 0.55, 0.65, 0.95],
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Photo Selection",
                        style: GoogleFonts.gluten(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      _buildUploadArea(),
                      SizedBox(height: 30.h),
                      _buildImagePreview(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(5.dg),
          margin: EdgeInsets.symmetric(horizontal: 5.dg, vertical: 5.dg),
          child: DottedBorder(
            color: Color.fromRGBO(42, 202, 234, 1),
            strokeWidth: 2,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(20.r),
            child: Container(
              width: 300.w,
              height: 150.h,
              // color: Colors.white,
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  _showDialogBox(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 50.sp,
                      color: const Color.fromRGBO(
                        42,
                        202,
                        234,
                        1,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Upload Photo",
                      style: TextStyles.blueText,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 60,
              color: Color.fromRGBO(245, 103, 253, 0.8),
            ),
            SizedBox(height: 15),
            Text(
              label,
              style: GoogleFonts.gluten(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Uploaded photo",
                style: GoogleFonts.gluten(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(42, 202, 234, 0.8),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            height: 150.h,
                            width: 150.h,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/Icons/gallery.png",
                            height: 100.h,
                            color: Colors.grey,
                            width: 100.h,
                            fit: BoxFit.cover,
                          ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/Icons/gallery.png",
                      height: 100.h,
                      width: 100.h,
                      color: Colors.grey,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showTextField = true;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(42, 202, 234, 1),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Continue",
            style: GoogleFonts.gluten(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
        if (_showTextField)
          Container(
            padding: EdgeInsets.all(12.dg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color.fromRGBO(42, 202, 234, 1)),
            ),
            child: Text(
              "lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet",
              style: TextStyles.blackBoldText,
            ),
          ),
      ],
    );
  }
}
