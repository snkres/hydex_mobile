import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hydex/src/features/vibes/data/category.dart';

class ExperienceCategoryList extends StatelessWidget {
  // Sample data based on your image
  final List<ExperienceCategory> categories = [
    ExperienceCategory(
      actionText: "Own the",
      heading: "Night",
      description: "Unique experiences",
      imagePath: "assets/images/night.jpg",
    ),
    ExperienceCategory(
      actionText: "Discover",
      heading: "Sports",
      description: "Book courts, arenas, and more",
      imagePath: "assets/images/sports.jpg",
    ),
    ExperienceCategory(
      actionText: "Find an",
      heading: "Adventure",
      description: "Unique experiences",
      imagePath: "assets/images/adventure.jpg",
    ),
    ExperienceCategory(
      actionText: "Discover",
      heading: "Shows",
      description: "Unique experiences",
      imagePath: "assets/images/shows.jpg",
    ),
    ExperienceCategory(
      actionText: "Taste",
      heading: "Luxury",
      description: "Unique experiences",
      imagePath: "assets/images/luxury.jpg",
    ),
  ];

  ExperienceCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(category.imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.overlay,
              ),
            ),
          ),
        );
      },
    );
  }
}
