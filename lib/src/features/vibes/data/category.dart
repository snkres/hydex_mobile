class ExperienceCategory {
  final String heading;
  final String description;
  final String imagePath;
  final String?
  actionText; // Optional action text like "Own the", "Discover", etc.

  ExperienceCategory({
    required this.heading,
    required this.description,
    required this.imagePath,
    this.actionText,
  });
}
