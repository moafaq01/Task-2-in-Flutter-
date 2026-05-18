import 'package:flutter/material.dart';
import '../constants/assets_manager.dart';

import 'category_details_screen.dart';

class CategoryItem {
  final String title;
  final String imageUrl;
  final IconData icon;

  CategoryItem({
    required this.title,
    required this.imageUrl,
    required this.icon,
  });
}

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static final List<CategoryItem> categories = [
    CategoryItem(
      title: 'Fiction',
      imageUrl: AppAssets.fiction,
      icon: Icons.auto_stories_rounded,
    ),
    CategoryItem(
      title: 'Science',
      imageUrl: AppAssets.science,
      icon: Icons.science_rounded,
    ),
    CategoryItem(
      title: 'History',
      imageUrl: AppAssets.history,
      icon: Icons.history_edu_rounded,
    ),
    CategoryItem(
      title: 'Design',
      imageUrl: AppAssets.design,
      icon: Icons.brush_rounded,
    ),
    CategoryItem(
      title: 'Self-Help',
      imageUrl: AppAssets.selfhelp,
      icon: Icons.psychology_rounded,
    ),
    CategoryItem(
      title: 'Biography',
      imageUrl: AppAssets.biography,
      icon: Icons.person_search_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EXPLORE GENRES')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            height: 140,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: cat.imageUrl.startsWith('assets/profile.jpg')
                        ? Image.network(cat.imageUrl, fit: BoxFit.cover)
                        : Image.asset(cat.imageUrl, fit: BoxFit.cover),
                  ),
                  // Gradient Overlay for readability and premium look
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoryDetailsScreen(categoryName: cat.title),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                cat.icon,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              cat.title.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
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
        },
      ),
    );
  }
}
