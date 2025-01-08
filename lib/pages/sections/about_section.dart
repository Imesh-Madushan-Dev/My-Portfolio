import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../constants/colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "About Me",
                    style: TextStyle(
                      color: kMainColor,
                      fontSize: isDesktop ? 16 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Who am I?",
              style: isDesktop ? headingD : headingM,
            ),
            const SizedBox(height: 30),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildAboutMe()),
                  const SizedBox(width: 30),
                  Expanded(child: _buildEducation()),
                ],
              )
            else
              Column(
                children: [
                  _buildAboutMe(),
                  const SizedBox(height: 30),
                  _buildEducation(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutMe() {
    return _buildGlassBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, color: kMainColor, size: 24),
              SizedBox(width: 10),
              Text(
                "Personal Info",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoItem(
            icon: Icons.location_on_outlined,
            label: "Based in",
            value: "Colombo, Sri Lanka",
          ),
          _buildInfoItem(
            icon: Icons.school_outlined,
            label: "Studying",
            value: "Software Engineering at NIBM",
          ),
          _buildInfoItem(
            icon: Icons.work_outline,
            label: "Experience",
            value: "2+ Years in Flutter Development",
          ),
          const SizedBox(height: 20),
          const Text(
            "I am a passionate software engineer specializing in Flutter development. With a strong foundation in mobile and web development, I create elegant, user-friendly applications that solve real-world problems. My journey in tech is driven by continuous learning and innovation.",
            style: TextStyle(
              color: kWhite,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducation() {
    return _buildGlassBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.school_outlined, color: kMainColor, size: 24),
              SizedBox(width: 10),
              Text(
                "Education",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildExpandableTimelineItem(
            status: "Pending",
            title: "BSc in Software Engineering",
            institution: "NIBM Campus",
            description:
                "Specializing in Software Engineering with focus on modern development practices and technologies.",
            isPending: true,
          ),
          _buildExpandableTimelineItem(
            status: "Present",
            title: "Higher National Diploma in Software Engineering",
            institution: "NIBM Campus",
            description:
                "Completed with distinction, focusing on software development and design principles.",
            isActive: true,
          ),
          _buildExpandableTimelineItem(
            status: "Done",
            title: "Diploma in Software Engineering",
            institution: "NIBM Campus",
            description:
                "Foundation in programming, database management, and web development.",
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableTimelineItem({
    required String status,
    required String title,
    required String institution,
    required String description,
    bool isActive = false,
    bool isPending = false,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 45, right: 15),
      leading: Container(
        width: 3,
        height: 24,
        color: isPending
            ? Colors.grey.withOpacity(0.3)
            : isActive
                ? kMainColor
                : kMainColor.withOpacity(0.3),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isPending
                  ? Colors.grey.withOpacity(0.1)
                  : isActive
                      ? kMainColor.withOpacity(0.2)
                      : kMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isPending
                    ? Colors.grey
                    : isActive
                        ? kMainColor
                        : kMainColor.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: kWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          Text(
            institution,
            style: TextStyle(
              color: kMainColor.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      iconColor: kMainColor,
      collapsedIconColor: kMainColor.withOpacity(0.5),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 45, right: 15, bottom: 15),
          child: Text(
            description,
            style: TextStyle(
              color: kWhite.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kMainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: kMainColor, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: kWhite.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassBox({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: kWhite.withOpacity(0.1),
            border: Border.all(
              color: kWhite.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: child,
        ),
      ),
    );
  }
}
