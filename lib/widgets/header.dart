import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Header extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const Header({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _currentSection = 'hero';
  final _debouncer = Debouncer(milliseconds: 50);

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    _debouncer.run(() {
      final scrollPosition = widget.scrollController.offset;
      String newSection = _currentSection;

      for (final entry in widget.sectionKeys.entries) {
        final context = entry.value.currentContext;
        if (context != null) {
          final box = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero);
          if (position.dy - 100 <= scrollPosition) {
            newSection = entry.key;
          }
        }
      }

      if (_currentSection != newSection) {
        setState(() => _currentSection = newSection);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: kWhite.withOpacity(0.03),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: kWhite.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: kBlack.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavItem(
                  label: "Home",
                  section: 'hero',
                  isActive: _currentSection == 'hero',
                  onTap: () => _scrollToSection('hero'),
                ),
                const SizedBox(width: 30),
                _NavItem(
                  label: "About",
                  section: 'about',
                  isActive: _currentSection == 'about',
                  onTap: () => _scrollToSection('about'),
                ),
                const SizedBox(width: 30),
                _NavItem(
                  label: "Skills",
                  section: 'skills',
                  isActive: _currentSection == 'skills',
                  onTap: () => _scrollToSection('skills'),
                ),
                const SizedBox(width: 30),
                _NavItem(
                  label: "Projects",
                  section: 'projects',
                  isActive: _currentSection == 'projects',
                  onTap: () => _scrollToSection('projects'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _scrollToSection(String section) {
    final key = widget.sectionKeys[section];
    if (key?.currentContext != null) {
      final box = key!.currentContext!.findRenderObject() as RenderBox;
      final offset = box.localToGlobal(Offset.zero);

      widget.scrollController.animateTo(
        widget.scrollController.offset + offset.dy - 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String section;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.section,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isActive ? kMainColor : kWhite.withOpacity(0.7),
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
