import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user_app/data/sources/auth_source.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Map to store like status for each product
  Map<String, bool> likedProducts = {};

  final _razorpay = Razorpay();
  // Map to store quantities for each product
  Map<String, int> quantities = {};
  double amount = 283.0; // Set initial amount
  bool presrequired = true;
  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Initialize default quantities
    quantities['Vicks Vaporub Balm'] = 1;
    quantities['Glycomet Gp 2 Tablet 15'] = 1;

    // Calculate initial amount
    _calculateTotalAmount();
  }

  void _calculateTotalAmount() {
    double total = 0;

    // Add price for Vicks Vaporub
    total += 105 * (quantities['Vicks Vaporub Balm'] ?? 1);

    // Add price for Glycomet
    total += 146 * (quantities['Glycomet Gp 2 Tablet 15'] ?? 1);

    // Add delivery and handling charges
    total += 32; // 30 for delivery + 2 for handling

    setState(() {
      amount = total;
    });
  }

  void _incrementQuantity(String productId) {
    setState(() {
      quantities[productId] = (quantities[productId] ?? 1) + 1;
      _calculateTotalAmount();
    });
  }

  void _decrementQuantity(String productId) {
    if ((quantities[productId] ?? 1) > 1) {
      setState(() {
        quantities[productId] = (quantities[productId] ?? 1) - 1;
        _calculateTotalAmount();
      });
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Payment ID: ${response.paymentId}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            Text(
              "Track your Order on Track Page",
              style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Failed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Error: ${response.message}',
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Retry payment logic
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_balance_wallet,
              color: Colors.blue,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'External Wallet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Wallet: ${response.walletName}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Items
                _buildCartItem(
                  'Vicks Vaporub Balm',
                  '100 ml',
                  105,
                  109,
                  '4% off',
                  "https://5.imimg.com/data5/FX/JG/NN/GLADMIN-41894397/selection-013-1000x1000.png",
                ),
                const Divider(),
                _buildCartItem(
                  'Glycomet Gp 2 Tablet 15',
                  '2 MG',
                  146,
                  178,
                  '18% off',
                  "https://5.imimg.com/data5/FX/JG/NN/GLADMIN-41894397/selection-013-1000x1000.png",
                  isPrescriptionRequired: true,
                ),

                // Prescription Actions
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Prescription added',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Similar Products
                const SizedBox(height: 24),
                const Text(
                  'Add Similar products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSimilarProductCard(
                        'Vicks Vaporub Balm',
                        105,
                        '4% off',
                        "https://5.imimg.com/data5/FX/JG/NN/GLADMIN-41894397/selection-013-1000x1000.png",
                      ),
                      _buildSimilarProductCard(
                        'Dabur Chyawanprash',
                        351,
                        '11% off',
                        "https://5.imimg.com/data5/FX/JG/NN/GLADMIN-41894397/selection-013-1000x1000.png",
                      ),
                      _buildSimilarProductCard(
                        'Moov Fast Pain Relief',
                        168,
                        '18% off',
                        "https://5.imimg.com/data5/FX/JG/NN/GLADMIN-41894397/selection-013-1000x1000.png",
                      ),
                    ],
                  ),
                ),

                // Delivery Offer
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Get Free delivery',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Use FREE50',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),

                // Bill Details
                const SizedBox(height: 24),
                const Text(
                  'Bill details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildBillRow('Items total', '₹251', isStrike: true),
                _buildBillRow('Delivery charges', '₹30'),
                _buildBillRow('Handling charges', '₹2'),
                const Divider(),
                _buildBillRow('Grand total', '₹${amount.toStringAsFixed(0)}',
                    isBold: true),

                // Delivery Instructions
                const SizedBox(height: 24),
                const Text(
                  'Delivery instructions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    _buildInstructionItem(Icons.mic, 'Record'),
                    _buildInstructionItem(
                        Icons.phone_disabled, 'Avoid\ncalling'),
                    _buildInstructionItem(
                        Icons.notifications_off, 'Don\'t ring\nthe bell'),
                    _buildInstructionItem(
                        Icons.add_circle_outline, 'Add other\ninstructions'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${amount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bill Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildBillRow('Item Total', '₹287'),
                                _buildBillRow('Item Discount', '-₹38'),
                                _buildBillRow('Delivery Fee', '₹40',
                                    isStrike: true),
                                _buildBillRow('Free Delivery', '-₹40'),
                                const Divider(),
                                _buildBillRow('Total Amount',
                                    '₹${amount.toStringAsFixed(0)}',
                                    isBold: true),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'View detailed bill',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String razorpayKey = dotenv.env['razorpay_key'] ?? "";

                    final options = {
                      'key': razorpayKey,
                      'amount': (amount * 100).toInt(), // Convert to paise
                      'name': 'Medidoor',
                      'description': 'Paying',
                      'prefill': {
                        'contact': AuthSource().getPhone ?? '8888888888',
                        'email': AuthSource().getEmail ?? 'a@b.c'
                      },
                    };
                    _razorpay.open(options);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1BAC4B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Place order →',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
    String name,
    String size,
    double price,
    double originalPrice,
    String discount,
    String image, {
    bool isPrescriptionRequired = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.network(image).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Size and prescription info
                Wrap(
                  spacing: 8,
                  children: [
                    Text('Size: $size'),
                    if (isPrescriptionRequired)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '*Prescription required',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),

                // Price details
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹$originalPrice',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        discount,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => _decrementQuantity(name),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.green.shade50,
                  padding: const EdgeInsets.all(8),
                ),
                iconSize: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('${quantities[name] ?? 1}'),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _incrementQuantity(name),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.green.shade50,
                  padding: const EdgeInsets.all(8),
                ),
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProductCard(
    String name,
    double price,
    String discount,
    String image,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(image, height: 100, width: 100),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '₹$price',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  discount,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              _buildAnimatedHeartButton(name),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String title, String amount,
      {bool isStrike = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            amount,
            style: TextStyle(
              decoration: isStrike ? TextDecoration.lineThrough : null,
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedHeartButton(String productId) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          likedProducts[productId] == true
              ? Icons.favorite
              : Icons.favorite_border,
          key: ValueKey<bool>(likedProducts[productId] == true),
          size: 24,
          color: likedProducts[productId] == true ? Colors.red : Colors.black54,
        ),
      ),
      onPressed: () {
        setState(() {
          // Toggle like status for specific product
          likedProducts[productId] = !(likedProducts[productId] ?? false);
        });
      },
    );
  }
}