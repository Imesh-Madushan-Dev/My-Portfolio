import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_portfolio/constants/colors.dart';
import 'package:new_portfolio/pages/sections/about_section.dart';
import 'package:new_portfolio/pages/sections/hero_section.dart';
import 'package:new_portfolio/pages/sections/projects_section.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import '../widgets/animated_balls.dart';
import '../widgets/header.dart';
import 'sections/skill_section.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // Controllers
  late final ScrollController _scrollController;
  late final AnimationController _animationController;

  // Section keys for navigation
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();

  late final Map<String, GlobalKey> _sectionKeys;

  // Memoized footer widget
  late final Widget _footer;

  /// [Generate random balls]
  final List<Ball> balls = List.generate(15, (_) => Ball());

  @override
  void initState() {
    super.initState();

    /// [Initialize scroll controller]
    _scrollController = ScrollController();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Initialize section keys
    _sectionKeys = {
      'hero': _heroKey,
      'about': _aboutKey,
      'skills': _skillsKey,
      'projects': _projectsKey,
    };

    // Initialize footer
    _footer = _buildFooter();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: kBlack,
      body: Stack(
        children: [
          // Animated Background
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return CustomPaint(
                  size: size,
                  painter: AnimatedBackgroundPainter(
                    balls: balls,
                    animationValue: _animationController.value,
                  ),
                );
              },
            ),
          ),
          // Frosted Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Content
          Positioned.fill(
            child: _buildContent(isDesktop, size),
          ),
          // Fixed Header
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Header(
                scrollController: _scrollController,
                sectionKeys: _sectionKeys,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isDesktop, Size size) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroSection(key: _heroKey),
        AboutSection(key: _aboutKey),
        SkillSection(key: _skillsKey),
        ProjectsSection(key: _projectsKey),
        _footer,
      ],
    );

    if (!isDesktop) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: content,
        ),
      );
    }

    return WebSmoothScroll(
      controller: _scrollController,
      scrollOffset: 100,
      animationDuration: 500,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: size.width * 0.1,
          ),
          child: content,
        ),
      ),
    );
  }
}

Widget _buildFooter() {
  return Column(
    children: [
      const SizedBox(height: 50),
      Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Made with Flutter ',
                style: GoogleFonts.poppins(
                  color: kWhite.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: '💖',
                style: GoogleFonts.notoColorEmoji(
                  color: kWhite.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 30),
    ],
  );
}
