import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {'name': 'Classics', 'icon': Icons.menu_book, 'color': Color(0xFF6A11CB)},
    {'name': 'Sci-Fi', 'icon': Icons.rocket_launch, 'color': Color(0xFF2575FC)},
    {'name': 'Adventure', 'icon': Icons.explore, 'color': Color(0xFFFF5F6D)},
    {'name': 'Finance', 'icon': Icons.account_balance_wallet, 'color': Color(0xFFFFC371)},
    {'name': 'Business', 'icon': Icons.business_center, 'color': Color(0xFF11998E)},
    {'name': 'Self-Help', 'icon': Icons.psychology, 'color': Color(0xFF38EF7D)},
    {'name': 'History', 'icon': Icons.history_edu, 'color': Color(0xFFF093FB)},
    {'name': 'Others', 'icon': Icons.more_horiz, 'color': Color(0xFF50C9C3)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: const Text(
                'Explore by Category',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: index * 50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: cat['color'].withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'], size: 40, color: cat['color']),
                          const SizedBox(height: 12),
                          Text(
                            cat['name'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
