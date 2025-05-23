import 'package:dentilligence/View/Search/dental_search.dart';
import 'package:dentilligence/constance/colors_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Note: You'll need to add the file_picker package to your pubspec.yaml:
// file_picker: ^5.5.0

class ConsultFormScreen extends StatefulWidget {
  const ConsultFormScreen({Key? key}) : super(key: key);

  @override
  _ConsultFormScreenState createState() => _ConsultFormScreenState();
}

class _ConsultFormScreenState extends State<ConsultFormScreen> {
  String? _selectedProblem;
  List<String> _selectedDoctorTypes = [];
  String? _selectedConsultationMethod;
  String? _selectedTimeFrame;
  List<String> _selectedFiles = [];
  final List<String> _problems = ['Tooth Ache', 'Bleeding', 'Gums', 'Advice'];
  final List<String> _doctorTypes = [
    'General Dentist',
    'Specialist',
    'Orthodontics',
    'Periodontist'
  ];
  final List<String> _consultationMethods = [
    'In-Person',
    'Video Call',
    'Phone Call'
  ];
  final List<String> _timeFrames = [
    'As soon as possible',
    'Within a week',
    'Within a month',
    'Not urgent'
  ];

  @override
  void initState() {
    super.initState();
    // Hide the status bar for this screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  void dispose() {
    // Restore the status bar when leaving this screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  // Add this method to handle file picking
  Future<void> _pickFiles() async {
    // This is a placeholder for file picking functionality
    // To implement actual file picking, you'll need to add the file_picker package
    // and use it like this:
    /*
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
      );
      
      if (result != null) {
        setState(() {
          _selectedFiles = result.paths
              .map((path) => path!.split('/').last)
              .toList();
        });
        
        // Show a snackbar to confirm files were selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${_selectedFiles.length} files selected')),
        );
      }
    } catch (e) {
      // Handle any errors
      print('Error picking files: $e');
    }
    */

    // For now, we'll just show a snackbar indicating the feature
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File picker will be implemented here'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 196, 32, 0.2),
          elevation: 0,
          toolbarHeight: 80, // Increased height
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 196, 32,0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black87),
                ),
                child: const Icon(Icons.arrow_back,
                    color: Colors.black87, size: 20),
              ),
            ),
          ),
          title: const Text(
            'Consult Form',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gluten',
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 196, 32, 0.2),
                  Color.fromRGBO(245, 103, 253, 0.1),
                  Color.fromRGBO(245, 103, 253, 0.2),
                  Color.fromRGBO(42, 202, 234, 0.1),
                  Colors.white.withOpacity(0.4)
                ],
                // stops: [0.0, 0.55, 0.65, 0.95, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionSection(
                  'What is your pressing problem?',
                  _buildProblemOptions(),
                ),
                const SizedBox(height: 24),
                _buildQuestionSection(
                  'What kind of doctor are you seeking?',
                  _buildDoctorTypeOptions(),
                ),
                const SizedBox(height: 24),
                _buildQuestionSection(
                  'Preferred consultation method?',
                  _buildConsultationMethodOptions(),
                ),
                const SizedBox(height: 24),
                _buildQuestionSection(
                  'How urgently do you need an appointment?',
                  _buildTimeFrameOptions(),
                ),
                if (_selectedFiles.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildAttachedFilesSection(),
                ],
                const SizedBox(height: 40),
                // Extra space at the bottom for scrolling content above the fixed buttons
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(22.0),
          child: ElevatedButton(
            onPressed: () {
              // Handle choose doctors action
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>SearchScreen())
            );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(42, 202, 234, 1),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Choose Doctors',
              style: TextStyle(
                fontFamily: 'Gluten',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ));
  }

  Widget _buildAttachedFilesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attached Files',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Gluten',
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _selectedFiles
              .map((file) => Chip(
                    label: Text(
                      file,
                      style: const TextStyle(fontSize: 12),
                    ),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _selectedFiles.remove(file);
                      });
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildQuestionSection(String question, Widget options) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorsConstants.yellowGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q. $question',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Gluten',
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          options,
        ],
      ),
    );
  }

  Widget _buildProblemOptions() {
    return Column(
      children: _problems.map((problem) {
        bool isSelected = _selectedProblem == problem;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsConstants.blueGradient : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            minTileHeight: 48,
            title: Text(
              problem,
              style: TextStyle(
                fontFamily: 'Gluten',
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.white)
                : null,
            onTap: () {
              setState(() {
                _selectedProblem = problem;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDoctorTypeOptions() {
    return Column(
      children: _doctorTypes.map((type) {
        bool isSelected = _selectedDoctorTypes.contains(type);
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          height: 48.h,
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsConstants.blueGradient : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: CheckboxListTile(
            title: Text(
              type,
              style: TextStyle(
                fontFamily: 'Gluten',
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            value: isSelected,
            activeColor: Colors.white,
            checkColor: const Color(0xFF4A55DA),
            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  _selectedDoctorTypes.add(type);
                } else {
                  _selectedDoctorTypes.remove(type);
                }
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConsultationMethodOptions() {
    return Column(
      children: _consultationMethods.map((method) {
        bool isSelected = _selectedConsultationMethod == method;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsConstants.blueGradient : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            minTileHeight: 48,
            title: Text(
              method,
              style: TextStyle(
                fontFamily: 'Gluten',
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.white)
                : null,
            onTap: () {
              setState(() {
                _selectedConsultationMethod = method;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimeFrameOptions() {
    return Column(
      children: _timeFrames.map((timeFrame) {
        bool isSelected = _selectedTimeFrame == timeFrame;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsConstants.blueGradient : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            minTileHeight: 48,
            title: Text(
              timeFrame,
              style: TextStyle(
                fontFamily: 'Gluten',
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.white)
                : null,
            onTap: () {
              setState(() {
                _selectedTimeFrame = timeFrame;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  // Widget _buildBottomButtons() {
  //   return Row(
  //     children: [
  //       // Add File button (moved to far left)
  //       Container(
  //         margin: const EdgeInsets.only(right: 16),
  //         child: SizedBox(
  //           height: 48, // Match the height of the other buttons
  //           width: 48, // Equal width and height makes it perfectly round
  //           child: ElevatedButton(
  //             onPressed: _pickFiles,
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0xFF4A55DA),
  //               padding: EdgeInsets.zero,
  //               shape: const CircleBorder(), // Perfectly round shape
  //             ),
  //             child: const Icon(Icons.add, color: Colors.white, size: 26),
  //           ),
  //         ),
  //       ),
  //       // Manual Reason button

  //       const SizedBox(width: 16),
  //       Expanded(
  //         child: ElevatedButton(
  //           onPressed: () {
  //             // Handle choose doctors action
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xFF4A55DA),
  //             padding: const EdgeInsets.symmetric(vertical: 16),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //           ),
  //           child: const Text(
  //             'Choose Doctors',
  //             style: TextStyle(
  //               fontFamily: 'Gluten',
  //               color: Colors.white,
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
