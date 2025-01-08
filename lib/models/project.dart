class Project {
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
  });
}
