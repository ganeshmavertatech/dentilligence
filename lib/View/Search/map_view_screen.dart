import 'package:flutter/material.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Map Image
          Image.network(
            'https://c.animaapp.com/mauqwo0xg4Xj2B/img/map-image.png',
            width: 390,
            height: 768,
            fit: BoxFit.cover,
          ),

          // Top status bar indicator
          Positioned(
            top: 18,
            left: 18,
            child: Image.network(
              'https://c.animaapp.com/mauqwo0xg4Xj2B/img/group-1.png',
              width: 354,
              height: 12,
            ),
          ),

          // Search bar
          Positioned(
            top: 71,
            left: 20,
            child: Container(
              width: 350,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 6,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Image.network(
                    'https://c.animaapp.com/mauqwo0xg4Xj2B/img/iconamoon-search.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 7),
                  const Text(
                    'Search doctors by name/categories',
                    style: TextStyle(
                      color: Color(0xFF909090),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom navigation bar
          Positioned(
            bottom: 0,
            child: Container(
              width: 390,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 6,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Home
                  Positioned(
                    bottom: 23,
                    left: 26,
                    child: Column(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://c.animaapp.com/mauqwo0xg4Xj2B/img/vector.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Home',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Consult (active)
                  Positioned(
                    bottom: 23,
                    left: 90,
                    child: Column(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://c.animaapp.com/mauqwo0xg4Xj2B/img/mask-group.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Consult',
                          style: TextStyle(
                            color: Color(0xFF2A2A2A),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Edutainment
                  Positioned(
                    bottom: 23,
                    left: 161,
                    child: Column(
                      children: [
                        Image.network(
                          'https://c.animaapp.com/mauqwo0xg4Xj2B/img/hugeicons-online-learning-01.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Edutainment',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Findings
                  Positioned(
                    bottom: 23,
                    left: 251,
                    child: Column(
                      children: [
                        Image.network(
                          'https://c.animaapp.com/mauqwo0xg4Xj2B/img/uil-analysis.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Findings',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Account
                  Positioned(
                    bottom: 23,
                    left: 326,
                    child: Column(
                      children: [
                        Image.network(
                          'https://c.animaapp.com/mauqwo0xg4Xj2B/img/group.png',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Account',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Active tab indicator
                  Positioned(
                    top: 0,
                    left: 92,
                    child: Container(
                      width: 38,
                      height: 3,
                      color: const Color(0xFF469BFF),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Location markers
          Positioned(
            top: 214,
            left: 267,
            child: Image.network(
              'https://c.animaapp.com/mauqwo0xg4Xj2B/img/location-image.png',
              width: 44,
              height: 51,
            ),
          ),

          Positioned(
            top: 281,
            left: 84,
            child: Image.network(
              'https://c.animaapp.com/mauqwo0xg4Xj2B/img/location-image-1.png',
              width: 44,
              height: 51,
            ),
          ),

          // Doctor profile images
          Positioned(
            top: 219,
            left: 272,
            child: Image.network(
              'https://c.animaapp.com/mauqwo0xg4Xj2B/img/image-2.png',
              width: 34,
              height: 34,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 286,
            left: 89,
            child: Image.network(
              'https://c.animaapp.com/mauqwo0xg4Xj2B/img/image-1.png',
              width: 34,
              height: 34,
              fit: BoxFit.cover,
            ),
          ),

          // Doctor card
          Positioned(
            bottom: 120,
            left: 20,
            child: Container(
              width: 350,
              height: 126,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Doctor image
                  Positioned(
                    top: 13,
                    left: 35,
                    child: Image.network(
                      'https://c.animaapp.com/mauqwo0xg4Xj2B/img/image-2.png',
                      width: 82,
                      height: 82,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Doctor name
                  const Positioned(
                    top: 13,
                    left: 137,
                    child: Text(
                      'Dr. Ritu Bose',
                      style: TextStyle(
                        color: Color(0xFF2A2A2A),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Verified icon
                  Positioned(
                    top: 14,
                    left: 245,
                    child: Image.network(
                      'https://c.animaapp.com/mauqwo0xg4Xj2B/img/material-symbols-verified-rounded.png',
                      width: 20,
                      height: 20,
                    ),
                  ),

                  // Doctor specialties
                  const Positioned(
                    top: 40,
                    left: 137,
                    child: Text(
                      'Dentist, Orthodontics, Dental surgeon',
                      style: TextStyle(
                        color: Color(0xFF909090),
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  // Experience
                  Positioned(
                    bottom: 49,
                    left: 137,
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://c.animaapp.com/mauqwo0xg4Xj2B/img/group-2.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '15 Yrs Exp',
                          style: TextStyle(
                            color: Color(0xFF2A2A2A),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Patients
                  Positioned(
                    bottom: 49,
                    left: 241,
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://c.animaapp.com/mauqwo0xg4Xj2B/img/group-3.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '125 Patients',
                          style: TextStyle(
                            color: Color(0xFF2A2A2A),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Rating
                  Positioned(
                    bottom: 18,
                    left: 54,
                    child: Container(
                      width: 45,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF189958),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 8,
                            top: 4,
                            child: Row(
                              children: [
                                Image.network(
                                  'https://c.animaapp.com/mauqwo0xg4Xj2B/img/vector-3.svg',
                                  width: 10,
                                  height: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  '5.0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Fees
                  const Positioned(
                    bottom: 18,
                    left: 138,
                    child: Text(
                      '\$50 Fees',
                      style: TextStyle(
                        color: Color(0xFF2A2A2A),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Listing view button
          Positioned(
            bottom: 166,
            left: 138,
            child: Container(
              width: 115,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://c.animaapp.com/mauqwo0xg4Xj2B/img/si-grid-fill.svg',
                    width: 14,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Listing View',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

