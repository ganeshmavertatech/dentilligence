import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TeethChartScreen extends StatefulWidget {
  @override
  _TeethChartScreenState createState() => _TeethChartScreenState();
}

class _TeethChartScreenState extends State<TeethChartScreen> {
  Map<int, Color> toothColors = {};
  Map<int, String> toothNotes = {};
  Map<int, String?> toothAudioPaths = {};
  double _scale = 1.0;
  final _scaleNotifier = ValueNotifier(1.0);
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyRecordingForTooth;
  bool _isRecording = false;
  bool _showTextInput = false;
  final TextEditingController _noteController = TextEditingController();
  List<double> _audioWaveData = [];
  Timer? _waveTimer;

  @override
  void dispose() {
    _audioPlayer.dispose();
    _waveTimer?.cancel();
    _audioPlayer.dispose();
    _noteController.dispose();
    super.dispose();
  }



  void _startRecording(int toothIndex) {
    setState(() {
      _isRecording = true;
      _currentlyRecordingForTooth = toothIndex;
      _showTextInput = false;
      _audioWaveData = List.filled(30, 0.0); // Initialize with zeros
    });

    // Simulate more natural audio wave data
    _waveTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        // Remove the oldest value
        _audioWaveData.removeAt(0);
        
        // Add new value with some randomness and smoothing
        double lastValue = _audioWaveData.isNotEmpty ? _audioWaveData.last : 0.0;
        double newValue = lastValue + (Random().nextDouble() * 2 - 1) * 0.5;
        newValue = newValue.clamp(-1.0, 1.0);
        _audioWaveData.add(newValue);
      });
    });
  }


  void _stopRecording(int toothIndex) {
    _waveTimer?.cancel();
    setState(() {
      _isRecording = false;
      _currentlyRecordingForTooth = null;
      // Store a dummy path since we're not actually saving files
      toothAudioPaths[toothIndex] = 'recording_${DateTime.now().millisecondsSinceEpoch}';
      _audioWaveData = [];
    });
  }

  List<Map<String, dynamic>> _getRecentNotes() {
    List<Map<String, dynamic>> allNotes = [];
    
    toothNotes.forEach((toothIndex, note) {
      if (note.isNotEmpty) {
        allNotes.add({
          'type': 'text',
          'tooth': toothIndex + 1,
          'content': note,
          'time': DateTime.now(),
        });
      }
    });
    
    toothAudioPaths.forEach((toothIndex, path) {
      if (path != null) {
        allNotes.add({
          'type': 'audio',
          'tooth': toothIndex + 1,
          'path': path,
          'time': DateTime.now(),
        });
      }
    });
    
    allNotes.sort((a, b) => b['time'].compareTo(a['time']));
    return allNotes.take(5).toList();
  }

  Widget _buildNoteItem(Map<String, dynamic> note) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            "T${note['tooth']}",
            style: TextStyle(color: Colors.blue[800]),
          ),
        ),
        title: note['type'] == 'text'
            ? Text(note['content'], maxLines: 1, overflow: TextOverflow.ellipsis)
            : Text("Audio Recording", style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          "Tooth ${note['tooth']} • ${DateFormat('MMM d, h:mm a').format(note['time'])}",
          style: TextStyle(fontSize: 12),
        ),
        trailing: note['type'] == 'audio'
            ? IconButton(
                icon: Icon(Icons.play_arrow, color: Colors.blue),
                onPressed: () {
                  // Play a dummy sound since we're not using actual files
                  _audioPlayer.play(AssetSource('assets/Bade_Miyan.mp3'));
                },
              )
            : null,
        onTap: () {
          if (note['type'] == 'text') {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Note for Tooth ${note['tooth']}"),
                content: Text(note['content']),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

void _showToothDialog(int toothIndex) {
  _noteController.text = toothNotes[toothIndex] ?? "";
  
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Tooth ${toothIndex + 1}"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Color Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildColorButton(toothIndex, Colors.red, setState),
                      _buildColorButton(toothIndex, Colors.yellow, setState),
                      _buildColorButton(toothIndex, Colors.green, setState),
                    ],
                  ),
                  SizedBox(height: 20),
                  
                  // Show either text input or mic based on selection
                  if (!_isRecording && !_showTextInput)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_note, size: 32),
                          color: Colors.blue,
                          onPressed: () {
                            setState(() {
                              _showTextInput = true;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: Icon(Icons.mic_none, size: 32),
                          color: Colors.blue,
                          onPressed: () {
                            _startRecording(toothIndex);
                            setState(() {
                              _showTextInput = false;
                            });
                          },
                        ),
                      ],
                    ),
                  
                  // Recording UI
                  if (_isRecording)
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedWaveEffect(
                              waveData: _audioWaveData,
                              color: Colors.blue.withOpacity(0.6),
                            ),
                            Icon(
                              Icons.mic,
                              size: 48,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Recording...",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.stop, color: Colors.white),
                          label: Text("Stop Recording"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            _stopRecording(toothIndex);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  
                  // Text Input UI
                  if (_showTextInput)
                    Column(
                      children: [
                        TextField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            hintText: "Enter notes about this tooth",
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _showTextInput = false;
                            });
                          },
                          child: Text("Cancel Text Input"),
                        ),
                      ],
                    ),
                  
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_isRecording) {
                    _stopRecording(toothIndex);
                  }
                  Navigator.pop(context);
                },
                child: Text("Close", style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Save note if in text input mode
                  if (_showTextInput && _noteController.text.isNotEmpty) {
                    setState(() {
                      toothNotes[toothIndex] = _noteController.text;
                    });
                  }
                  // Audio is already saved when stop is pressed
                  Navigator.pop(context);
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          );
        },
      );
    },
  ).then((_) {
    if (_isRecording) {
      _stopRecording(toothIndex);
    }
    _showTextInput = false;
    _isRecording = false;
    _currentlyRecordingForTooth = null;
  });
}

  Widget _buildColorButton(int index, Color color, StateSetter setState) {
    return GestureDetector(
      onTap: () {
        setState(() {
          toothColors[index] = color;
        });
        if (mounted) {
          setState(() {});
        }
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: 20,
        child: toothColors[index] == color 
            ? Icon(Icons.check, color: Colors.white) 
            : null,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIrcie_dE2wg4FjVKrZqEZI1CT00i-qtnqNg&s", width: 25),
            SizedBox(width: 4),
            Text("Dentelligence",style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.teal,
                ),
              ),
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.search), onPressed: () {}),
                        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Dr. Smith", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/41.jpg"),
                       ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 40, right: 40),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/41.jpg"),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Dr. John Smith",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),               
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Doctor of Dental Surgery",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          Icon(Icons.star_half, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            "4.5",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.verified, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                
                List<Offset> upperLeftPositions = _calculateHalfArchPositions(8, width, height, true, true);
                List<Offset> upperRightPositions = _calculateHalfArchPositions(8, width, height, true, false);
                List<Offset> lowerLeftPositions = _calculateHalfArchPositions(8, width, height, false, true);
                List<Offset> lowerRightPositions = _calculateHalfArchPositions(8, width, height, false, false);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 1.2,
                        child: GestureDetector(
                          onScaleUpdate: (ScaleUpdateDetails details) {
                            _scaleNotifier.value = _scale * details.scale;
                          },
                          onScaleEnd: (ScaleEndDetails details) {
                            _scale = _scaleNotifier.value;
                          },
                          child: ValueListenableBuilder(
                            valueListenable: _scaleNotifier,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ...List.generate(8, (index) {
                                      Offset position = upperLeftPositions[index];
                                      return Positioned(
                                        left: position.dx - 20,
                                        top: position.dy - 20,
                                        child: GestureDetector(
                                          onLongPress: () => _showToothDialog(index),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: toothColors[index] ?? Color.fromRGBO(245, 183, 177, 1),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage("https://cdn.pixabay.com/photo/2016/07/06/20/50/tooth-1501321_640.png"),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    ...List.generate(8, (index) {
                                      Offset position = upperRightPositions[index];
                                      return Positioned(
                                        left: position.dx - 20,
                                        top: position.dy - 20,
                                        child: GestureDetector(
                                          onLongPress: () => _showToothDialog(index + 8),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: toothColors[index + 8] ?? Color.fromRGBO(245, 183, 177, 1),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage("https://cdn.pixabay.com/photo/2016/07/06/20/50/tooth-1501321_640.png"),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    ...List.generate(8, (index) {
                                      Offset position = lowerLeftPositions[index];
                                      return Positioned(
                                        left: position.dx - 20,
                                        top: position.dy - 20,
                                        child: GestureDetector(
                                          onLongPress: () => _showToothDialog(index + 16),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: toothColors[index + 16] ?? Color.fromRGBO(245, 183, 177, 1),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage("https://cdn.pixabay.com/photo/2016/07/06/20/50/tooth-1501321_640.png"),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    ...List.generate(8, (index) {
                                      Offset position = lowerRightPositions[index];
                                      return Positioned(
                                        left: position.dx - 20,
                                        top: position.dy - 20,
                                        child: GestureDetector(
                                          onLongPress: () => _showToothDialog(index + 24),
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: toothColors[index + 24] ?? Color.fromRGBO(245, 183, 177, 1),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage("https://cdn.pixabay.com/photo/2016/07/06/20/50/tooth-1501321_640.png"),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        color: Colors.grey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, color: Colors.blue, size: 20),
                            SizedBox(width: 6),
                            Text(
                              "Recent Notes & Recordings",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          children: _getRecentNotes().map((note) => 
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tooth ${note['tooth']}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                      Text(
                                        DateFormat('MMM d, h:mm a').format(note['time']),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  if (note['type'] == 'text')
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.note, color: Colors.blue, size: 18),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              note['content'],
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.green[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.mic, color: Colors.green, size: 18),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              "Audio Recording",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.play_arrow, color: Colors.green, size: 20),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                            _audioPlayer.play(AssetSource('paisa.mp3'));

                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                      if (_getRecentNotes().isEmpty)
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(Icons.note_add, size: 36, color: Colors.grey[400]),
                              SizedBox(height: 8),
                              Text(
                                "No recent notes or recordings",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Offset> _calculateHalfArchPositions(int count, double width, double height, bool isUpper, bool isLeft) {
    List<Offset> positions = [];
    double centerX = width / 2;
    double centerY = height / 2;
    double verticalOffset = isUpper ? -height * 0.1 : height * 0.1;
    double curveHeight = height * 0.2;
    double horizontalGap = width * 0.1;
    
    for (int i = 0; i < count; i++) {
      double ratio = i / (count - 1);
      double x = isLeft ? 
          -1 + ratio - (horizontalGap / width) : 
          ratio + (horizontalGap / width);
      
      double curveDirection = isUpper ? -1 : 1;
      double posX = centerX + (x * width * 0.35);
      double posY = centerY + verticalOffset + (curveDirection * curveHeight * (1 - (x * x).abs()));
      
      positions.add(Offset(posX, posY));
    }
    
    return positions;
  }
}


class AnimatedWaveEffect extends StatefulWidget {
  final List<double> waveData;
  final Color color;
  
  const AnimatedWaveEffect({
    required this.waveData,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedWaveEffectState createState() => _AnimatedWaveEffectState();
}

class _AnimatedWaveEffectState extends State<AnimatedWaveEffect> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(150, 150),
          painter: _WavePainter(
            waveData: widget.waveData,
            color: widget.color,
            animationValue: _animation.value,
          ),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final List<double> waveData;
  final Color color;
  final double animationValue;
  
  _WavePainter({
    required this.waveData,
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final paint = Paint()..color = color;
    
    // Draw multiple concentric waves that pulse outward
    for (int i = 0; i < 3; i++) {
      final progress = (animationValue + i * 0.2) % 1.0;
      final radius = maxRadius * progress;
      
      if (radius > 0) {
        // Adjust opacity based on distance from center
        final opacity = 1.0 - progress;
        paint.color = color.withOpacity(opacity * 0.6);
        
        // Draw wave shapes based on audio data
        final path = Path();
        final angleStep = 2 * pi / waveData.length;
        
        for (int j = 0; j < waveData.length; j++) {
          final angle = j * angleStep;
          final waveFactor = 1.0 + waveData[j] * 0.3;
          final pointRadius = radius * waveFactor;
          
          final x = center.dx + pointRadius * cos(angle);
          final y = center.dy + pointRadius * sin(angle);
          
          if (j == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        
        path.close();
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) {
    return oldDelegate.waveData != waveData || 
           oldDelegate.animationValue != animationValue;
  }
}
