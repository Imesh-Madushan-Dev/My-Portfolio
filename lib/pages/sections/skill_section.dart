import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../constants/colors.dart';

class SkillSection extends StatelessWidget {
  const SkillSection({super.key});

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
              child: Text(
                "SKILLS",
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
              "Technologies I Work With",
              style: isDesktop ? headingD : headingM,
            ),
            const SizedBox(height: 50),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: _buildSkillCategory(
                          "Frontend", _getFrontendSkills())),
                  const SizedBox(width: 30),
                  Expanded(
                      child:
                          _buildSkillCategory("Backend", _getBackendSkills())),
                  const SizedBox(width: 30),
                  Expanded(
                      child: _buildSkillCategory("Tools", _getToolsSkills())),
                ],
              )
            else
              Column(
                children: [
                  _buildSkillCategory("Frontend", _getFrontendSkills()),
                  const SizedBox(height: 30),
                  _buildSkillCategory("Backend", _getBackendSkills()),
                  const SizedBox(height: 30),
                  _buildSkillCategory("Tools", _getToolsSkills()),
                ],
              ),
          ],
        ),
      ),
    );
  }

  List<(String, String)> _getFrontendSkills() => [
        ("Flutter", Brands.flutter),
        ("React", Brands.react_native),
        ("HTML5", Brands.html_5),
        ("CSS3", Brands.css3),
        ("JavaScript", Brands.javascript),
        ("Dart", Brands.dart),
      ];

  List<(String, String)> _getBackendSkills() => [
        ("Node.js", Brands.nodejs),
        ("Python", Brands.python),
        ("Firebase", Brands.firebase),
        ("MongoDB", Brands.mongodb),
        ("MySQL", Brands.my_sql),
        ("PostgreSQL", Brands.postgresql),
      ];

  List<(String, String)> _getToolsSkills() => [
        ("Git", Brands.git),
        ("GitHub", Brands.github),
        ("Figma", Brands.figma),
        ("VS Code", Brands.github),
        ("Postman", Brands.github),
        ("Docker", Brands.github),
      ];

  Widget _buildSkillCategory(String title, List<(String, String)> skills) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: kMainColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills
                .map((skill) => _buildSkillChip(skill.$2, skill.$1))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String icon, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          Brand(
            icon,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              color: kWhite,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
