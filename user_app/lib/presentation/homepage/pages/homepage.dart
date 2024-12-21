import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_app/common/pages/something_went_wrong.dart';
import 'package:user_app/common/widgets/loading.dart';
import 'package:user_app/config/extensions/extensions.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/presentation/cart/pages/map_tracking_page.dart';
import 'package:user_app/presentation/homepage/bloc/home_bloc.dart';

import '../../../config/assets/app_images.dart';
import '../../product_details_page/pages/product_details_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeBloc homeBloc = HomeBloc();
  int activeindex = 0;
  List<String> images = [
    AppImages.banner1,
    AppImages.banner1,
    AppImages.banner1,
  ];
  int value = 1;
  bool showtrackorder = false;
  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeInitFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Loading();
          } else if (state is HomeLoadedSuccessState) {
            return SingleChildScrollView(
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showtrackorder = !showtrackorder;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 82, 142, 47),
                                      radius: 16,
                                      child: Image.asset(
                                        'assets/icons/location.png',
                                        color: Colors.white,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  10.aw,
                                  const Text(
                                    "New Delhi",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
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
                                        const Color.fromARGB(255, 82, 142, 47),
                                    radius: 16,
                                    child: Image.asset(
                                      AppImages.cart,
                                      width: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 82, 142, 47),
                                    radius: 16,
                                    child: Image.asset(
                                      'assets/icons/notibell.png',
                                      color: Colors.white,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.87,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              contentPadding: const EdgeInsets.all(0),
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
                      const SizedBox(height: 16),
                      showtrackorder
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 243, 208),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    spreadRadius: 0,
                                    blurRadius: 0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/map.png',
                                    height: 80,
                                    width: 80,
                                    frameBuilder: (context, child, frame,
                                        wasSynchronouslyLoaded) {
                                      return Container(
                                        width: 73,
                                        height: 73,
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade300,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: child,
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Arriving in 8 minutes',
                                          style: GoogleFonts.sourceSans3(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          'Sudeep is your delivery partner',
                                          style: GoogleFonts.sourceSans3(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MapTrackingPage()));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              'Track Your Order here',
                                              style: GoogleFonts.sourceSans3(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      20.ah,
                      SizedBox(
                        width: double.infinity,
                        child: CarouselSlider.builder(
                            options: CarouselOptions(
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlay: true,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(child: buildIndicator()),
                      20.ah,
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, Piyush!',
                              style: GoogleFonts.sourceSans3(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
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
                              height: 263, // Adjusted height to fix overflow
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return _buildProductCard(state.productModel);
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
                              children: [
                                _buildCategoryCard(
                                  AppImages.diabetes, 'Diabetes',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/stomach-health.png',
                                  'Stomach health',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/pain-injury.png',
                                  'Pain & injury',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/eye-health.png',
                                  'Eye Health',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/cough-cold.png',
                                  'Cough & Cold',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/image 10.png',
                                  'Skin health',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/first-aid.png', 'First aid',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                                _buildCategoryCard(
                                  'assets/images/immunity.png',
                                  'Immunity boost',
                                  const Color.fromARGB(
                                      255, 161, 196, 224), // Start Color
                                  const Color(0xFFC7E5E9), // First Middle Color
                                  const Color.fromARGB(255, 209, 235,
                                      245), // Second Middle Color
                                  const Color.fromARGB(
                                      255, 250, 214, 235), // Third Middle Color
                                  const Color.fromARGB(255, 245, 183, 208),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 174, 222, 238),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Want to consult a doctor\nbefore buying medicines?',
                                          style: GoogleFonts.sourceSans3(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Book a 1-on-1 session with our doctors.',
                                          style: GoogleFonts.sourceSans3(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              'Book Now',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Image.asset(
                                    'assets/images/banner-2-mid.png',
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Personal Care',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              children: [
                                _buildCategoryCard(
                                  AppImages.diabetes,
                                  'Diabetes',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/stomach-health.png',
                                  'Stomach health',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/pain-injury.png',
                                  'Pain & injury',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/eye-health.png',
                                  'Eye Health',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/cough-cold.png',
                                  'Cough & Cold',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/image 10.png',
                                  'Skin health',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/first-aid.png',
                                  'First aid',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                                _buildCategoryCard(
                                  'assets/images/immunity.png',
                                  'Immunity boost',
                                  const Color.fromARGB(255, 121, 170, 235),
                                  const Color.fromARGB(255, 112, 184, 194),
                                  const Color.fromARGB(255, 106, 197, 152),
                                  const Color.fromARGB(255, 130, 192, 142),
                                  const Color.fromARGB(255, 153, 188, 133),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SomethingWentWrong();
        },
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

  Widget _buildProductCard(ProductModel productModel) {
    return GestureDetector(
      onTap: () => context.push(ProductDetailsPage(productModel: productModel)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 165,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        color: Color.fromARGB(255, 207, 202, 202))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/vicks-vaporub.png',
                    height: 100,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    '25 ml Balm',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 12),
                            SizedBox(width: 2),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '35 ratings',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹105',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '₹109',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '4% off',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                              ProductDetailsPage(productModel: productModel));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                  color: Colors.grey)
                            ],
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: GoogleFonts.sourceSans3(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 58, 129, 60)),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildCategoryCard(String imagePath, String title, Color clr1,
      Color clr2, Color clr3, Color clr4, Color clr5) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
//pink blue
                // const Color.fromARGB(
                //                       255, 161, 196, 224), // Start Color
                //                   const Color(0xFFC7E5E9), // First Middle Color
                //                   const Color.fromARGB(255, 209, 235,
                //                       245), // Second Middle Color
                //                   const Color.fromARGB(
                //                       255, 250, 214, 235), // Third Middle Color
                //                   const Color.fromARGB(255, 245, 183, 208),
//green blue
                // Color.fromARGB(255, 121, 170, 235),
                // Color.fromARGB(255, 112, 184, 194),
                // Color.fromARGB(255, 106, 197, 152),
                // Color.fromARGB(255, 130, 192, 142),
                // Color.fromARGB(255, 153, 188, 133)
                clr1, clr2, clr3, clr4, clr5
              ],
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
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ],
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
