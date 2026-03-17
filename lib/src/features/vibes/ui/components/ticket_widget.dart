import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:smooth_corner/smooth_corner.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.shadow,
  });

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: TicketClipper(),
          child: SmoothClipRRect(
            smoothness: 1,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: widget.padding,
              margin: widget.margin,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff100166), Color(0xff8B4CF0)],
                ),
              ),
              child: widget.child,
            ),
          ),
        ),
        Positioned(
          right: 70, // Adjust based on your notch position
          top: 0,
          bottom: 0,
          child: CustomPaint(painter: DashedLinePainter()),
        ),
        Positioned(
          right: (MediaQuery.widthOf(context) / 375) * -90,
          bottom: 0,
          top: 0,
          left: 0,
          child: SvgPicture.asset("img/svg/ticket_logo.svg", package: "assets"),
        ),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Define the radius for the rounded corners and the cutout notches
    const cornerRadius = 16.0;
    const notchRadius = 16.0;

    // Define the X position of the perforation line
    final perforationX = size.width * 0.75;

    // Start from the top-left, after the corner curve
    path.moveTo(cornerRadius, 0);

    // Draw the top edge and the top notch
    path.lineTo(perforationX - notchRadius, 0);
    path.arcToPoint(
      Offset(perforationX + notchRadius, 0),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    // Draw to the top-right corner
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Draw the right edge
    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );

    // Draw the bottom edge and the bottom notch
    path.lineTo(perforationX + notchRadius, size.height);
    path.arcToPoint(
      Offset(perforationX - notchRadius, size.height),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    // Draw to the bottom-left corner
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    // Draw the left edge
    path.lineTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.backgroundBase.withValues(alpha: 0.5)
      ..strokeWidth = 1;

    final double dashHeight = 5;
    final double dashSpace = 3;
    final double startY = 0;
    final double endY = size.height;
    final double startX = size.width * 0.75; // Must match perforationX

    double currentY = startY;
    while (currentY < endY) {
      canvas.drawRect(
        Rect.fromCenter(center: Offset(startX, currentY), width: 4, height: 4),
        paint,
      );
      currentY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
