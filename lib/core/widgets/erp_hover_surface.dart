import 'package:flutter/material.dart';

class ERPHoverSurface extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final Duration duration;
  final Color? hoverBorderColor;
  final Color? normalBorderColor;
  final Color? hoverShadowColor;
  final double lift;

  const ERPHoverSurface({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(22)),
    this.duration = const Duration(milliseconds: 180),
    this.hoverBorderColor,
    this.normalBorderColor,
    this.hoverShadowColor,
    this.lift = 3,
  });

  @override
  State<ERPHoverSurface> createState() => _ERPHoverSurfaceState();
}

class _ERPHoverSurfaceState extends State<ERPHoverSurface> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _hover ? -widget.lift : 0,
          0,
        ),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: Border.all(
            color: _hover
                ? (widget.hoverBorderColor ??
                Colors.white.withValues(alpha: .18))
                : (widget.normalBorderColor ??
                Colors.white.withValues(alpha: .05)),
            width: _hover ? 1.3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (widget.hoverShadowColor ?? Colors.black).withValues(
                alpha: _hover ? .35 : .20,
              ),
              blurRadius: _hover ? 20 : 12,
              offset: Offset(0, _hover ? 10 : 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: widget.borderRadius,
          child: InkWell(
            borderRadius: widget.borderRadius,
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}