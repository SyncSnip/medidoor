import 'package:flutter/material.dart';
import 'package:user_app/presentation/categories_page/pages/categories_page.dart';
import 'package:user_app/presentation/homepage/homepage.dart';

class RedirectingPage extends StatefulWidget {
  const RedirectingPage({super.key});

  @override
  State<RedirectingPage> createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage> {
  final List<Widget> _pages = <Widget>[
    const Homepage(),
    const CategoriesPage(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.amber,
        child: Row(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _index = index;
                    });
                  },
                  child: const Column(
                    children: [
                      Text('Homepage'),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
