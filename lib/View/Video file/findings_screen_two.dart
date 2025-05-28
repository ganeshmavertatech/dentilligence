import 'dart:math';
import 'package:camera/camera.dart';
import 'package:dentilligence/Controller/findings_controller.dart';
import 'package:dentilligence/View/Video%20file/get_consultation_ready.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// TODO: Replace this with your actual FindingsController implementation or import statement.


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
  final FindingsController _findingsController = Get.put(FindingsController());

  // Face detection variables 
  FaceDetector? _faceDetector;
  bool _isFaceAligned = false;
  bool _isProcessing = false;
  bool _isTeethVisible = false;
  Size _imageSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeFaceDetector();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _faceDetector?.close();
    super.dispose();
  }

  void _initializeFaceDetector() {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
        enableLandmarks: true,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
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

      if (frontCamera.lensDirection == CameraLensDirection.front) {
        _cameraController!.setFlashMode(FlashMode.off);
        await _cameraController!.setExposureMode(ExposureMode.auto);
        await _cameraController!.setFocusMode(FocusMode.auto);
      }

      // Start image stream for face detection
      _cameraController!.startImageStream((CameraImage image) {
        if (!_isProcessing) {
          _isProcessing = true;
          _processCameraImage(image);
        }
      });

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Camera error: $e');
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final InputImageRotation rotation =
          _cameraController!.description.sensorOrientation == 90
              ? InputImageRotation.rotation90deg
              : InputImageRotation.rotation0deg;

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: InputImageFormatValue.fromRawValue(image.format.raw) ??
              InputImageFormat.nv21,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await _faceDetector!.processImage(inputImage);

      if (faces.isNotEmpty) {
        final face = faces.first;
        
        // Check if mouth is open (teeth visible) using smilingProbability as an approximation
        final isMouthOpen = (face.smilingProbability ?? 0.0) > 0.8;
        
        // Get face bounding box
        final rect = face.boundingBox;
        
        // Calculate if face is properly aligned in the oval
        final screenWidth = MediaQuery.of(context).size.width;
        final ovalWidth = screenWidth * 0.6;
        final ovalHeight = ovalWidth * 1.3;
        
        final isAligned = 
            rect.width >= ovalWidth * 0.8 && 
            rect.width <= ovalWidth * 1.2 &&
            rect.height >= ovalHeight * 0.8 &&
            rect.height <= ovalHeight * 1.2 &&
            (rect.left + rect.width/2 - screenWidth/2).abs() < 30 && // Center X
            (rect.top + rect.height/2 - ovalHeight/2).abs() < 50; // Center Y
        
        setState(() {
          _isFaceAligned = isAligned;
          _isTeethVisible = isMouthOpen;
          _imageSize = Size(image.width.toDouble(), image.height.toDouble());
        });
      } else {
        setState(() {
          _isFaceAligned = false;
          _isTeethVisible = false;
        });
      }
    } catch (e) {
      debugPrint('Face detection error: $e');
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _submitFindings() async {

    _findingsController.uploadFindings(
        smileFace: _capturedImages[0],
        lowerJaw: _capturedImages[1],
        upperJaw: _capturedImages[2],
        context: context,
      );
    if (_capturedImages.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture all three images')),
      );
      return;
    }

    try {
      await _findingsController.uploadFindings(
        smileFace: _capturedImages[0],
        lowerJaw: _capturedImages[1],
        upperJaw: _capturedImages[2],
        context: context,
      );

      // Navigate to next screen on success
      if (mounted) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const GetConsultationPage(),
        //   ),
        // );
      }
    } catch (e) {
      debugPrint('Error uploading findings: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized || !_cameraController!.value.isInitialized) {
      return;
    }

    // Only allow capture when face is aligned and teeth are visible
    if (!_isFaceAligned || !_isTeethVisible) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please align your face and show your teeth')),
      );
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
          _submitFindings(); // Call API when all images are captured
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
            _submitFindings(); // Call API when all images are selected
          }
        });
      }
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(390, 844));

    return Obx(() {
      if (_findingsController.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),

                        // Step Indicator
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: SizedBox(
                            height: 80.h,
                            child: Stack(
                              children: [
                                // Connecting lines
                                Positioned(
                                  top: 42.h,
                                  left: 96.w / 3,
                                  right: 96.w / 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 1.h,
                                          color: const Color(0x8F8F8FB2),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Divider(
                                          thickness: 1.h,
                                          color: const Color(0x8F8F8FB2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Steps
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(3, (index) {
                                    final isCurrent = _currentStep == index;
                                    final isVerified = _verifiedSteps[index];

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _currentStep = index;
                                        });
                                      },
                                      child: Container(
                                        width: 96.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          color: isCurrent
                                              ? const Color(0xFFF5FAFF)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: isCurrent
                                                ? const Color(0xFF469BFF)
                                                : const Color(0x8F8F8FB2),
                                            width: isCurrent ? 1.w : 0.5.w,
                                          ),
                                        ),
                                        child: Stack(
                                          clipBehavior: Clip
                                              .none, // Allow children to overflow
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // Tooth icon
                                                  SizedBox(
                                                    width: 45.w,
                                                    height: 29.h,
                                                    child: Image.asset(
                                                      index == 0
                                                          ? 'assets/Images/Group (5).png'
                                                          : index == 1
                                                              ? 'assets/Images/Frame.png'
                                                              : 'assets/Images/Frame (1).png',
                                                      width: 45.w,
                                                      height: 15.h,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  // Label
                                                  Text(
                                                    index == 0
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .front
                                                        : index == 1
                                                            ? AppLocalizations.of(
                                                                context)!
                                                            .upperJaw
                                                            : AppLocalizations.of(
                                                                context)!
                                                            .lowerJaw,
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontWeight: isCurrent
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      color: isCurrent
                                                          ? const Color(
                                                              0xFF2A2A2A)
                                                          : const Color(
                                                              0xFF909090),
                                                      fontSize: 13.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (isVerified)
                                              _buildVerifiedIcon(index),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Instruction text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Text(
                            _currentStep == 0
                                ? AppLocalizations.of(context)!.lookStraight
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

                        SizedBox(height: 20.h),

                        // Camera Preview with Face Alignment Guide
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Stack(
                                children: [
                                  if (_isCameraInitialized)
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(pi),
                                      child: CameraPreview(_cameraController!),
                                    )
                                  else
                                    Container(
                                      color: Colors.black,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: const Color(0xFF469BFF),
                                          strokeWidth: 2.w,
                                        ),
                                      ),
                                    ),
                                  
                                  // Face alignment guide oval
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      height: MediaQuery.of(context).size.width * 0.6 * 1.3,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(200),
                                        border: Border.all(
                                          color: _isFaceAligned && _isTeethVisible
                                              ? Colors.green
                                              : Colors.red,
                                          width: 3.w,
                                        ),
                                      ),
                                    ),
                                  ),

                                  if (_verifiedSteps[_currentStep])
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: EdgeInsets.all(16.r),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.7),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 40.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Take Photo Button
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 45.w),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isFaceAligned && _isTeethVisible
                                    ? const Color(0xFF189958)
                                    : const Color(0xFF189958).withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: _takePicture,
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Camera Button and Actions
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Gallery Button
                              IconButton(
                                icon: Image.asset(
                                  'assets/Images/solar_gallery-linear.png',
                                  width: 32.w,
                                  height: 32.h,
                                ),
                                onPressed: _openGallery,
                              ),

                              // Camera Button
                              GestureDetector(
                                onTap: _takePicture,
                                child: Container(
                                  width: 80.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _isFaceAligned && _isTeethVisible
                                          ? Colors.green
                                          : const Color(0xFF469BFF),
                                      width: 3.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 60.w,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                        color: _isFaceAligned && _isTeethVisible
                                            ? Colors.green
                                            : const Color(0xFF469BFF),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Close Button
                              IconButton(
                                icon: Image.asset(
                                  'assets/Images/solar_gallery-linear (1).png',
                                  width: 32.w,
                                  height: 32.h,
                                ),
                                onPressed: _navigateBackToDashboard,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildVerifiedIcon(int index) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  void _navigateBackToDashboard() {
    Navigator.of(context).pop();
  }
}