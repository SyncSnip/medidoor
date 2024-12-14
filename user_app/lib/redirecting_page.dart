import 'package:flutter/material.dart';
import 'package:user_app/data/model/navigation_bar_model.dart';
import 'package:user_app/presentation/cart/pages/cart_page.dart';
import 'package:user_app/presentation/categories_page/pages/categories_page.dart';
import 'package:user_app/presentation/homepage/pages/homepage.dart';
import 'package:user_app/presentation/profile_page/pages/profile_page.dart';

class RedirectingPage extends StatefulWidget {
  const RedirectingPage({super.key});

  @override
  State<RedirectingPage> createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage> {
  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: const Homepage(),
    ),
    NavigationItem(
      label: 'Categories',
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      page: const CategoriesPage(),
    ),
    NavigationItem(
      label: 'Consultation',
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      page: const CartPage(),
    ),
    NavigationItem(
      label: 'Profile',
      icon: Icons.person_pin,
      selectedIcon: Icons.person_pin,
      page: const ProfilePage(),
    ),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationItems[_selectedIndex].page,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 1.2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navigationItems.length,
              (index) => _buildNavigationItem(index),
            ),
          ),
        ),
      ),
      extendBody: true,
    );
  }

  Widget _buildNavigationItem(int index) {
    final item = _navigationItems[index];
    final isSelected = index == _selectedIndex;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? item.selectedIcon : item.icon,
            color: isSelected ? Colors.black : Colors.grey,
          ),
          const SizedBox(height: 4),
          if (index == _selectedIndex)
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}
