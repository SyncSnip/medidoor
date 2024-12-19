import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/presentation/cart/pages/document_page.dart';

import '../../../config/assets/app_images.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming you have a backend service to fetch cart items and total
    final cartItems = fetchCartItems(); // Fetch items from backend
    final totalAmount =
        calculateTotal(cartItems); // Calculate total from backend

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length, // Use dynamic item count
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        item.imageUrl, // Use image from assets
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item.name, // Use product name from backend
                        style: GoogleFonts.sourceSans3(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '₹${item.price}', // Use price from backend
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          removeItemFromCart(item.id); // Remove item action
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8), // Reduced space to move up
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: GoogleFonts.sourceSans3(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹$totalAmount', // Use dynamic total
                  style: GoogleFonts.sourceSans3(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Reduced space to move up
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  proceedToDocumentPage(
                      context); // Pass context to document page function
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Proceed to Document Page',
                  style: GoogleFonts.sourceSans3(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 380),
          ],
        ),
      ),
    );
  }

  // Mock functions to simulate backend interaction
  List<CartItem> fetchCartItems() {
    // Replace with actual backend call
    return [
      CartItem(
          id: 1, name: 'Diabetes', price: 105, imageUrl: AppImages.diabetes),
      CartItem(
          id: 2,
          name: 'Stomach health',
          price: 105,
          imageUrl: 'assets/images/stomach-health.png'),
      CartItem(
          id: 3,
          name: 'Pain & injury',
          price: 105,
          imageUrl: 'assets/images/pain-injury.png'),
    ];
  }

  double calculateTotal(List<CartItem> items) {
    // Calculate total price
    return items.fold(0, (sum, item) => sum + item.price);
  }

  void removeItemFromCart(int id) {
    // Implement item removal logic
  }

  void proceedToDocumentPage(BuildContext context) {
    // Add context parameter
    // Implement document page logic
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const DocumentPage()), // Add const
    );
  }
}

class CartItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  CartItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});
}
