import 'dart:math';

import 'package:camera/camera.dart';
import 'package:dentilligence/View/Video%20file/get_consultation_ready.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class FindingsScreenTwo extends StatefulWidget {
  const FindingsScreenTwo({super.key});

  @override
  State<FindingsScreenTwo> createState() => _FindingsScreenTwoState();
}

class _FindingsScreenTwoState extends State<FindingsScreenTwo> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  List<XFile> _capturedImages = [];
  int _currentStep = 0;
  List<bool> _verifiedSteps = [false, false, false];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      // Fix mirroring for front camera
      if (frontCamera.lensDirection == CameraLensDirection.front) {
        _cameraController!.setFlashMode(FlashMode.off);
        await _cameraController!.setExposureMode(ExposureMode.auto);
        await _cameraController!.setFocusMode(FocusMode.auto);
      }

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile image = await _cameraController!.takePicture();
      setState(() {
        _capturedImages.add(image);
        _verifiedSteps[_currentStep] = true;

        if (_currentStep < 2) {
          _currentStep++;
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const GetConsultationPage()));
        }
      });
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _openGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _capturedImages.add(image);
          _verifiedSteps[_currentStep] = true;

          if (_currentStep < 2) {
            _currentStep++;
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GetConsultationPage()));
          }
        });
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
    }
  }

  void _navigateBackToDashboard() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Widget _buildVerifiedOverlay(int index) {
    if (!_verifiedSteps[index]) return const SizedBox.shrink();

    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 24.r,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: 390.w,
          height: 844.h,
          child: Stack(
            children: [
              Positioned(
                top: 66.h,
                left: 20.w,
                child: SizedBox(
                  width: 350.w,
                  height: 80.h,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 42.h,
                        left: 84.w,
                        child: Image.asset(
                          'assets/Images/Vector 73.png',
                          width: 61.w,
                          height: 1.h,
                        ),
                      ),
                      Positioned(
                        top: 42.h,
                        left: 206.w,
                        child: Image.asset(
                          'assets/Images/Vector 73.png',
                          width: 61.w,
                          height: 1.h,
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: _currentStep == 0
                            ? 0.w
                            : (_currentStep == 1 ? 127.w : 254.w),
                        child: Container(
                          width: 96.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5FAFF),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: const Color(0xFF469BFF),
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),

                      // Tooth icon in selected tab
                      Positioned(
                        top: 17.h,
                        left: _currentStep == 0
                            ? 25.w
                            : (_currentStep == 1 ? 152.w : 279.w),
                        child: SizedBox(
                          width: 45.w,
                          height: 29.h,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/Images/Group (5).png',
                                width: 45.w,
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Unselected tabs
                      if (_currentStep != 0)
                        Positioned(
                          top: 0,
                          left: 0.w,
                          child: Container(
                            width: 96.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0x8F8F8FB2),
                                width: 0.5.w,
                              ),
                            ),
                          ),
                        ),
                      if (_currentStep != 1)
                        Positioned(
                          top: 0,
                          left: 127.w,
                          child: Container(
                            width: 96.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0x8F8F8FB2),
                                width: 0.5.w,
                              ),
                            ),
                          ),
                        ),
                      if (_currentStep != 2)
                        Positioned(
                          top: 0,
                          left: 254.w,
                          child: Container(
                            width: 96.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0x8F8F8FB2),
                                width: 0.5.w,
                              ),
                            ),
                          ),
                        ),

                      // Tab labels
                      Positioned(
                        top: 51.h,
                        left: 31.w,
                        child: Text(
                          'Front',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: _currentStep == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentStep == 0
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFF909090),
                            fontSize: 13.sp,
                            height: 1.0,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 51.h,
                        left: 145.w,
                        child: Text(
                          'Upper Jaw',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: _currentStep == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentStep == 1
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFF909090),
                            fontSize: 13.sp,
                            height: 1.0,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 51.h,
                        left: 272.w,
                        child: Text(
                          'Lower Jaw',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: _currentStep == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentStep == 2
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFF909090),
                            fontSize: 13.sp,
                            height: 1.0,
                          ),
                        ),
                      ),

                      // Right icon button
                      Positioned(
                        top: 15.h,
                        left: 277.w,
                        child: SizedBox(
                          width: 51.w,
                          height: 32.h,
                          child: Image.asset(
                            'assets/Images/Frame.png',
                            width: 50.w,
                            height: 27.h,
                          ),
                        ),
                      ),

                      // Center icon button
                      Positioned(
                        top: 15.h,
                        left: 150.w,
                        child: SizedBox(
                          width: 50.w,
                          height: 32.h,
                          child: Image.asset(
                            'assets/Images/Frame (1).png',
                            width: 47.w,
                            height: 22.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main content area - camera preview with overlay
              Positioned(
                top: 200.h,
                left: 33.w,
                child: SizedBox(
                  width: 390.w,
                  height: 526.h,
                  child: Stack(
                    children: [
                      _isCameraInitialized
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(pi),
                              child: CameraPreview(_cameraController!),
                            )
                          : Container(
                              color: Colors.black,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: const Color(0xFF469BFF),
                                  strokeWidth: 2.w,
                                ),
                              ),
                            ),

                      // Overlay for front view verification
                      if (_currentStep == 0) _buildVerifiedOverlay(0),

                      // Add specific overlays for upper and lower jaw as needed
                    ],
                  ),
                ),
              ),

              // Green button
              Positioned(
                top: 620.h,
                left: 45.w,
                child: Container(
                  width: 300.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF189958).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      _currentStep == 0
                          ? 'Take Front Photo'
                          : _currentStep == 1
                              ? 'Take Upper Jaw Photo'
                              : 'Take Lower Jaw Photo',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                        height: 1.125,
                      ),
                    ),
                  ),
                ),
              ),

              // Circular camera button
              Positioned(
                top: 680.h,
                left: 136.w,
                child: GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    width: 118.w,
                    height: 118.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF469BFF),
                        width: 3.w,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 86.w,
                        height: 86.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFF469BFF),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Left gallery icon
              Positioned(
                top: 740.h,
                left: 40.w,
                child: GestureDetector(
                  onTap: _openGallery,
                  child: SizedBox(
                    width: 36.w,
                    height: 36.h,
                    child: Image.asset(
                      'assets/Images/solar_gallery-linear.png',
                      width: 32.w,
                      height: 32.h,
                    ),
                  ),
                ),
              ),

              // Right gallery icon (close button)
              Positioned(
                top: 740.h,
                left: 314.w,
                child: GestureDetector(
                  onTap: _navigateBackToDashboard,
                  child: SizedBox(
                    width: 36.w,
                    height: 36.h,
                    child: Image.asset(
                      'assets/Images/solar_gallery-linear (1).png',
                      width: 32.w,
                      height: 32.h,
                    ),
                  ),
                ),
              ),

              // Instruction text
              Positioned(
                top: 160.h,
                left: 59.w,
                child: Text(
                  _currentStep == 0
                      ? 'Look straight, Smile wide & align your teeth\nwith overlay. Keep ready'
                      : _currentStep == 1
                          ? 'Please show your upper teeth clearly'
                          : 'Please show your lower teeth clearly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2A2A2A),
                    fontSize: 14.sp,
                    height: 1.285,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
