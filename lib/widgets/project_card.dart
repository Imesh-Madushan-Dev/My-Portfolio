import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: kWhite.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              project.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 220,
                  color: kWhite.withOpacity(0.05),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kMainColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  color: kWhite.withOpacity(0.05),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: kMainColor,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to load image',
                          style: TextStyle(
                            color: kWhite.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Project Details
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Title
                Text(
                  project.title,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
                // Project Description
                Text(
                  project.description,
                  style: TextStyle(
                    color: kWhite.withOpacity(0.7),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                // Technologies Used
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: project.technologies
                      .map((tech) => _buildTechChip(tech))
                      .toList(),
                ),
                const SizedBox(height: 25),
                // Project Links
                Row(
                  children: [
                    if (project.githubUrl != null) ...[
                      _buildLinkButton(
                        "View Code",
                        Icons.code,
                        project.githubUrl!,
                      ),
                      const SizedBox(width: 15),
                    ],
                    if (project.liveUrl != null)
                      _buildLinkButton(
                        "Live Demo",
                        Icons.launch_rounded,
                        project.liveUrl!,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kMainColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: kMainColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        tech,
        style: TextStyle(
          color: kMainColor,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLinkButton(String label, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // TODO: Implement URL launcher
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: kWhite.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: kWhite.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: kWhite,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: kWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
