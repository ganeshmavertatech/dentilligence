import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DentistGridPage extends StatelessWidget {
  final List<Map<String, dynamic>> dentistTypes = [
    {"label": "General", "color": Colors.amber[50]},
    {"label": "Orthodontist", "color": Colors.blue[50]},
    {"label": "Pedodontist", "color": Colors.amber[50]},
    {"label": "Oral Surgeon", "color": Colors.blue[50]},
    {"label": "Endodontist", "color": Colors.amber[50]},
    {"label": "Periodontist", "color": Colors.blue[50]},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // Fixed height for horizontal row
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dentistTypes.length,
        itemBuilder: (context, index) {
          final item = dentistTypes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: item["color"],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/Icons/teethImage.png',height: 37,width: 37,)
                ),
                SizedBox(height: 8),
                Text(
                  item["label"],
                  style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
