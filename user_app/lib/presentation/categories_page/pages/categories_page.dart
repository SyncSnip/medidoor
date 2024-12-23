import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/config/assets/app_images.dart';
import 'package:user_app/config/extensions/extensions.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> categories = [
    "Daily Health Essentials",
    "Personal Care",
    "Prescription Required",
    "Vitamins and Nutrition",
  ];
  List<Color> bluepink = [
    const Color.fromARGB(255, 161, 196, 224), // Start Color
    const Color(0xFFC7E5E9), // First Middle Color
    const Color.fromARGB(255, 209, 235, 245), // Second Middle Color
    const Color.fromARGB(255, 250, 214, 235), // Third Middle Color
    const Color.fromARGB(255, 245, 183, 208),
  ];
  List<Color> bluegreen = [
    const Color.fromARGB(255, 121, 170, 235),
    const Color.fromARGB(255, 112, 184, 194),
    const Color.fromARGB(255, 106, 197, 152),
    const Color.fromARGB(255, 130, 192, 142),
    const Color.fromARGB(255, 153, 188, 133)
  ];

  List<String> images = [
    AppImages.diabetes,
    'assets/images/stomach-health.png',
    'assets/images/pain-injury.png',
    'assets/images/eye-health.png',
    'assets/images/cough-cold.png',
    'assets/images/first-aid.png',
    'assets/images/immunity.png',
    'assets/images/image 10.png'
  ];

  List<String> titles = [
    'Diabetes',
    'Stomach health',
    'Pain & injury',
    'Eye Health',
    'Cough & Cold',
    'First aid',
    'Immunity boost',
    'Skin health'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            35.ah,
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.87,
                height: MediaQuery.of(context).size.height * 0.05,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 185, 183, 183),
                          width: 0.2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ...categories.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w500, // Reduced boldness
                      color: Colors.black, // Changed color to black
                    ),
                  ),
                  // const SizedBox(height: 8.0),
                  (category == "Daily Health Essentials" ||
                          category == "Prescription Required")
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            // mainAxisSpacing: 12,
                            // crossAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Handle item tap
                              },
                              child: _buildCategoryCard(
                                  images[index % images.length],
                                  titles[index % titles.length],
                                  bluepink),
                            );
                          },
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            // mainAxisSpacing: 12,
                            // crossAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Handle item tap
                              },
                              child: _buildCategoryCard(
                                  images[index % images.length],
                                  titles[index % titles.length],
                                  bluegreen),
                            );
                          },
                        ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      String imagePath, String title, List<Color> clrlist) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: clrlist,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(
            imagePath,
            height: 40,
            width: 40,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceSans3(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
