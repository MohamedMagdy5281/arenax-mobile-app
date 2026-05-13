import 'package:flutter/material.dart';

class CustomBottomNavBarButton extends StatefulWidget {
  const CustomBottomNavBarButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.iconColor,
    required this.iconContainerColor,
    this.size,
    this.animateFill = false,
    this.animationColor,
    this.isMic,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final Color iconColor;
  final Color iconContainerColor;
  final double? size;
  final bool animateFill;
  final Color? animationColor;
  final bool? isMic;

  @override
  State<CustomBottomNavBarButton> createState() =>
      _CustomBottomNavBarButtonState();
}

class _CustomBottomNavBarButtonState extends State<CustomBottomNavBarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    if (widget.animateFill) {
      _animationController.repeat(reverse: false);
    }
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavBarButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animateFill != oldWidget.animateFill) {
      if (widget.animateFill) {
        _animationController.repeat(reverse: false);
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: widget.iconContainerColor,
            ),
            width: 56,
            height: 56,
          ),
          if (widget.animateFill)
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 56,
                      height: 56 * _animationController.value,
                      color: widget.animationColor ?? Colors.blue,
                    ),
                  );
                },
              ),
            ),
          // Use iconBuilder if provided, otherwise default to Icon widget
          Icon(
            widget.icon,
            color: widget.iconColor,
            size: widget.size ?? 32,
          ),
        ],
      ),
    );
  }
}
