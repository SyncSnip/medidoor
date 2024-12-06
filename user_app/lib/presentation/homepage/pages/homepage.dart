import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_app/config/extensions/extensions.dart';

import '../../../config/assets/app_images.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int activeindex = 0;
  List<String> images = [
    AppImages.banner1,
    AppImages.banner1,
    AppImages.banner1
  ];
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 82, 142, 47),
                              radius: 16,
                              child: Icon(Icons.location_on_outlined),
                            ),
                            10.aw,
                            const Text(
                              "New Delhi",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 100,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 82, 142, 47),
                                radius: 16,
                                child: Image.asset(AppImages.cart),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 82, 142, 47),
                                  radius: 16,
                                  child: Icon(
                                    Icons.notifications,
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CarouselSlider.builder(
                    options: CarouselOptions(
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        padEnds: true,
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height * 0.2,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeindex = index;
                          });
                        }),
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) {
                      // final res = wallpaperImage[index];
                      return Container(
                        // height: 140,
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage(images[index]))),
                          padding: const EdgeInsets.all(16),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
                Center(child: buildIndicator()),
                20.ah,
                Text("Welcome, Piyush!",
                    style: GoogleFonts.sourceSans3(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                20.ah,
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 2.18,
                  children: [
                    _buildQuickActionCard(
                      'Order medicines',
                      'Delivered within 15 \nminutes',
                      const Color.fromARGB(255, 174, 222, 238),
                      AppImages.requestMedicine,
                    ),
                    _buildQuickActionCard(
                      'Consult a Doctor',
                      'Get on a 1 on-1 Call \nwith doctors',
                      const Color.fromARGB(255, 201, 235, 174),
                      AppImages.consultDoctor,
                    ),
                    _buildQuickActionCard(
                      'Request a medicine',
                      'Request currently \nunavailable medicines',
                      const Color.fromARGB(255, 240, 178, 128),
                      AppImages.orderMedicine,
                    ),
                    _buildQuickActionCard(
                      'Lab testing',
                      'Book an appointment\nfor lab tests',
                      const Color.fromARGB(255, 235, 185, 212),
                      AppImages.labTest,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                ),
                Text(
                  'Trending Products',
                  style: GoogleFonts.sourceSans3(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return _buildProductCard();
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Daily Health Essentials',
                  style: GoogleFonts.sourceSans3(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(8, (index) {
                    return Container(
                      color: Colors.grey[200],
                      child: Center(child: Text('Item ${index + 1}')),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Want to consult a doctor ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Book a 1-on-1 session with our doctors.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Book Now'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Personal Care',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: List.generate(8, (index) {
                    return Container(
                      color: Colors.grey[200],
                      child: Center(child: Text('Item ${index + 1}')),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
      String title, String subtitle, Color color, String img) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              offset: Offset(2, 2),
              spreadRadius: 2,
              color: Color.fromARGB(255, 217, 217, 217))
        ],
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image(
              image: AssetImage(img),
              height: 60,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.sourceSans3(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black),
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style:
                    GoogleFonts.sourceSans3(fontSize: 10, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 145,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(AppImages.vicksVaporub)),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(
                      0,
                      2,
                    ),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Multivitamin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  '₹199',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        onDotClicked: (index) {
          activeindex = index;
        },
        activeIndex: activeindex,
        count: 3,
        effect: JumpingDotEffect(
          spacing: 16,
          dotColor: Theme.of(context).colorScheme.primary,
          activeDotColor: const Color.fromARGB(255, 54, 152, 233),
          dotHeight: 8,
          dotWidth: 8,
        ));
  }
}
