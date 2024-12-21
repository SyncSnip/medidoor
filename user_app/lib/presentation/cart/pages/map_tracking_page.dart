import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/redirecting_page.dart';

class MapTrackingPage extends StatelessWidget {
  const MapTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const RedirectingPage()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Track Your Order',
          style: GoogleFonts.sourceSans3(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product Details Section
            Expanded(
              flex: 2,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final List<Map<String, dynamic>> products = [
                      {
                        'name': 'Vicks VapoRub',
                        'description':
                            'Topical cough suppressant for relief from cold & congestion',
                        'price': '₹85',
                        'image': 'assets/images/vicks-vaporub.png'
                      },
                      {
                        'name': 'Dolo 650mg',
                        'description':
                            'Paracetamol tablet for fever & mild pain relief',
                        'price': '₹30',
                        'image': 'assets/images/medicine.png'
                      },
                      {
                        'name': 'Moov Balm',
                        'description':
                            'Ayurvedic pain relief balm for headache & body pain',
                        'price': '₹45',
                        'image': 'assets/images/pain-injury.png'
                      }
                    ];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            products[index]['image'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          products[index]['name']!,
                          style: GoogleFonts.sourceSans3(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          products[index]['description']!,
                          style: GoogleFonts.sourceSans3(fontSize: 14),
                        ),
                        trailing: Text(
                          products[index]['price']!,
                          style: GoogleFonts.sourceSans3(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Map Section
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        'https://miro.medium.com/v2/resize:fit:2000/0*O8GfPtggZCun7Zie.jpeg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated Delivery Time',
                                style: GoogleFonts.sourceSans3(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Reaching in 10 mins',
                                style: GoogleFonts.sourceSans3(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
