import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:confetti/confetti.dart';
import '../../constants/colors.dart';
import '../../widgets/hoverable_iconbutton.dart.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (math.pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * math.cos(step),
          halfWidth + externalRadius * math.sin(step));
      path.lineTo(
          halfWidth + internalRadius * math.cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * math.sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Stack(
      children: [
        Container(
          width: size.width,
          constraints: BoxConstraints(minHeight: size.height * 0.9),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? size.width * 0.1 : 20,
              vertical: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: kMainColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Hello, World!",
                        style: TextStyle(
                          color: kMainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Let's Build Something",
                  style: isDesktop ? headingD : headingM,
                ),
                const SizedBox(height: 30),
                _buildGlassBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "I am ",
                            style: TextStyle(
                              fontSize: 24,
                              color: kWhite,
                              height: 1.5,
                            ),
                          ),
                          const Text(
                            "Imesh Madushan",
                            style: TextStyle(
                              fontSize: 24,
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20,
                          color: kWhite,
                          height: 1.5,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Flutter Developer',
                              speed: const Duration(milliseconds: 100),
                            ),
                            TypewriterAnimatedText(
                              'UI/UX Designer',
                              speed: const Duration(milliseconds: 100),
                            ),
                            TypewriterAnimatedText(
                              'Web Developer',
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // const Text(
                      //   "Passionate about creating elegant, user-friendly applications that combine clean code with exceptional design. Specializing in Flutter development and modern UI/UX solutions.",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: kWhite,
                      //     height: 1.6,
                      //   ),
                      // ),
                      const SizedBox(height: 30),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            _confettiController.play();
                            _launchURL('YOUR_CV_URL_HERE');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: kMainColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Bootstrap.download,
                                  color: kBlack,
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Download CV',
                                  style: TextStyle(
                                    color: kBlack,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildSocialButton(
                            icon: Bootstrap.envelope,
                            url: 'mailto:imeshmadushan1333@gmail.com',
                          ),
                          _buildSocialButton(
                            icon: Bootstrap.whatsapp,
                            url: 'https://wa.me/94741020250',
                          ),
                          _buildSocialButton(
                            icon: Bootstrap.github,
                            url: 'https://github.com/Imesh-Madushan-Dev',
                          ),
                          _buildSocialButton(
                            icon: Bootstrap.linkedin,
                            url:
                                'https://www.linkedin.com/in/imesh-madushan-dev',
                          ),
                          _buildSocialButton(
                            icon: Bootstrap.youtube,
                            url: 'https://www.youtube.com/@Code_FOXX',
                          ),
                          _buildSocialButton(
                            icon: Bootstrap.medium,
                            url: 'https://medium.com/@imesh-madushan',
                          ),
                          _buildSocialButton(
                            icon: Bootstrap.instagram,
                            url: 'https://www.instagram.com/___imesh____/',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.2,
            shouldLoop: false,
            colors: const [
              kMainColor,
              Colors.white,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            createParticlePath: drawStar,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
  }) {
    return HoverableIconButton(
      icon: icon,
      onPressed: () => _launchURL(url),
      hoverColor: kMainColor,
      defaultColor: kWhite.withOpacity(0.6),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
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
