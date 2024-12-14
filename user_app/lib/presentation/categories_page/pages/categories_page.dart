import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int activeIndex = 0;
  List<String> categories = [
    "Pain Relief",
    "Vitamins",
    "Cold & Flu",
    "Allergy",
    "First Aid",
  ];

  List<String> images = [
    'assets/images/stomach-health.png',
    'assets/images/pain-injury.png',
    'assets/images/eye-health.png',
    'assets/images/cough-cold.png',
    'assets/images/image 10.png',
    'assets/images/first-aid.png',
    'assets/images/immunity.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Medicine Categories"),
        backgroundColor: const Color.fromARGB(255, 0, 200, 83), // Green theme
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 200, 83),
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 150, // Increased height for better visibility
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 12,
                      childAspectRatio:
                          1.2, // Adjusted aspect ratio for better layout
                    ),
                    itemCount: 5, // Number of items in each category
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle item tap
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white, // Changed background to white
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green
                                    .withOpacity(0.3), // Green shadow
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                images[
                                    index % images.length], // Use random images
                                height: 60, // Increased image size
                                width: 60,
                              ),
                              const SizedBox(height: 10.0),
                              Center(
                                child: Text(
                                  '$category Item $index',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12, // Increased font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28.0),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
