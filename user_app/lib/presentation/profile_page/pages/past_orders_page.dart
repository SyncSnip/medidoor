import 'package:flutter/material.dart';

class PastOrdersPage extends StatelessWidget {
  const PastOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        children: [
          _buildOrderCard(
            context,
            status: 'Arrived in 12 mins',
            statusIcon: Icons.check_circle,
            statusColor: Colors.green,
            name: 'Rohan Sharma',
            address:
                '45, Green Park, Block A, Sector 12, Gurgaon, Haryana - 122001',
            actions: ['Rate order', 'Reorder', 'View details'],
            images: [
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
            ],
          ),
          _buildOrderCard(
            context,
            status: 'Order Failed',
            statusIcon: Icons.cancel,
            statusColor: Colors.red,
            name: 'Shreya Kansal',
            address:
                '23, Eldeco Apartments, Pl, Block C2, Sector 93, Noida, Uttar Pradesh - 201301',
            actions: ['Help', 'Reorder', 'View details'],
            images: [
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
            ],
          ),
          _buildOrderCard(
            context,
            status: 'Arrived in 8 mins',
            statusIcon: Icons.check_circle,
            statusColor: Colors.green,
            name: 'Ananya Gupta',
            address:
                '12, Rosewood Apartments, Block B, Sector 45, Chandigarh - 160047',
            actions: ['Rate order', 'Reorder', 'View details'],
            images: [
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
            ],
          ),
          _buildOrderCard(
            context,
            status: 'Arrived in 15 mins',
            statusIcon: Icons.check_circle,
            statusColor: Colors.green,
            name: 'Vikram Singh',
            address:
                '78, Palm Grove, Block D, Sector 56, Pune, Maharashtra - 411045',
            actions: ['Rate order', 'Reorder', 'View details'],
            images: [
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
              'assets/images/vicks-vaporub.png',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String status,
    required IconData statusIcon,
    required Color statusColor,
    required String name,
    required String address,
    required List<String> actions,
    required List<String> images,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: images.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String image = entry.value;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          image,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      if (idx == images.length - 1)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text(
                              '+2',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6.0),
            Text(
              address,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: actions.map((action) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildCustomButton(action),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(String action) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        action,
        style: const TextStyle(color: Colors.green),
      ),
    );
  }
}
