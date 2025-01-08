import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../data/project_data.dart';
import '../../widgets/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Container(
      width: size.width,
      constraints: BoxConstraints(minHeight: size.height * 0.9),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? size.width * 0.1 : 20,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "PORTFOLIO",
                style: TextStyle(
                  color: kMainColor,
                  fontSize: isDesktop ? 16 : 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Featured Projects",
              style: isDesktop ? headingD : headingM,
            ),
            const SizedBox(height: 30),
            _buildFilterChips(),
            const SizedBox(height: 40),
            _buildProjects(isDesktop, size),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final categories = ["All", "Mobile", "Web", "Desktop"];

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: kWhite.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: kWhite.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          return InkWell(
            onTap: () => setState(() => selectedCategory = category),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? kMainColor : kWhite.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? kMainColor : kWhite.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? kBlack : kWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjects(bool isDesktop, Size size) {
    final filteredProjects = selectedCategory == "All"
        ? projects
        : projects.where((p) => p.category == selectedCategory).toList();

    // Calculate card width based on screen size
    final cardWidth = isDesktop
        ? (size.width > 1200
            ? (size.width * 0.8 - 60) / 3 // 3 cards for large screens
            : (size.width * 0.8 - 30) / 2) // 2 cards for medium screens
        : size.width - 40; // Full width for mobile

    return SingleChildScrollView(
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.start,
        children: filteredProjects.map((project) {
          return SizedBox(
            width: cardWidth,
            child: ProjectCard(project: project),
          );
        }).toList(),
      ),
    );
  }
}
