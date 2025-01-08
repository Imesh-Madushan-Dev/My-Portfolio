import 'package:flutter/material.dart';

class HoverableIconButton extends StatefulWidget {
  final IconData icon;
  final Function() onPressed;
  final Color hoverColor;
  final Color defaultColor;

  const HoverableIconButton({
    required this.icon,
    required this.onPressed,
    this.hoverColor = const Color(0xFFFFD700), // Example hover color
    this.defaultColor = Colors.white,
    super.key,
  });

  @override
  State<HoverableIconButton> createState() => _HoverableIconButtonState();
}

class _HoverableIconButtonState extends State<HoverableIconButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: IconButton(
        icon: Icon(
          widget.icon,
          color: isHovered ? widget.hoverColor : widget.defaultColor,
        ),
        onPressed: widget.onPressed,
        iconSize: 20, // Adjust as needed
      ),
    );
  }
}
