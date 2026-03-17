import 'package:flutter/material.dart';

class TicketContainer extends StatelessWidget {
  final Widget upperChild;
  final Widget lowerChild;
  final Color backgroundColor;
  final double borderRadius;
  final double notchRadius;
  final double width;

  const TicketContainer({
    super.key,
    required this.upperChild,
    required this.lowerChild,
    this.backgroundColor = const Color(0xFF1C1C2E),
    this.borderRadius = 20,
    this.notchRadius = 20,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ClipPath(
        clipper: TicketClipper(
          borderRadius: borderRadius,
          notchRadius: notchRadius,
          notchPositionRatio: 0.6,
        ),
        child: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Upper section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                child: upperChild,
              ),
              // Dashed divider row
              _buildDashedDivider(),
              // Lower section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: lowerChild,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: notchRadius + 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dashWidth = 5.0;
          final dashSpace = 4.0;
          final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
              .floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(dashCount, (_) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: dashSpace / 2),
                child: Container(
                  width: dashWidth,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: .circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

/// Custom clipper that creates the ticket shape:
/// rounded rectangle with two circular notches on left & right edges.
class TicketClipper extends CustomClipper<Path> {
  final double borderRadius;
  final double notchRadius;
  final double notchPositionRatio;

  TicketClipper({
    required this.borderRadius,
    required this.notchRadius,
    required this.notchPositionRatio,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final notchY = size.height * notchPositionRatio;
    final r = borderRadius;
    final nr = notchRadius;

    // Start top-left corner (after radius)
    path.moveTo(0, r);
    // Top-left corner
    path.quadraticBezierTo(0, 0, r, 0);
    // Top edge
    path.lineTo(size.width - r, 0);
    // Top-right corner
    path.quadraticBezierTo(size.width, 0, size.width, r);

    // Right edge down to notch
    path.lineTo(size.width, notchY - nr);
    // Right notch (semicircle inward)
    path.arcToPoint(
      Offset(size.width, notchY + nr),
      radius: Radius.circular(nr),
      clockwise: false,
    );

    // Right edge down to bottom-right corner
    path.lineTo(size.width, size.height - r);
    // Bottom-right corner
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );
    // Bottom edge
    path.lineTo(r, size.height);
    // Bottom-left corner
    path.quadraticBezierTo(0, size.height, 0, size.height - r);

    // Left edge up to notch
    path.lineTo(0, notchY + nr);
    // Left notch (semicircle inward)
    path.arcToPoint(
      Offset(0, notchY - nr),
      radius: Radius.circular(nr),
      clockwise: false,
    );

    // Left edge back up to start
    path.lineTo(0, r);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant TicketClipper oldClipper) {
    return oldClipper.borderRadius != borderRadius ||
        oldClipper.notchRadius != notchRadius ||
        oldClipper.notchPositionRatio != notchPositionRatio;
  }
}

// ─── Example usage ───────────────────────────────────────────

class TicketExampleScreen extends StatelessWidget {
  const TicketExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E1A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TicketContainer(
            upperChild: _buildUpperContent(),
            lowerChild: _buildLowerContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildUpperContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with poster thumbnail
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EVENT TITLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Subtitle Here',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Poster placeholder
            Container(
              width: 70,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.image,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.white.withValues(alpha: 0.1)),
        const SizedBox(height: 16),
        // Guest info
        _label('Guest Name'),
        const SizedBox(height: 4),
        Text(
          'Full Name Here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'email@example.com - Gender',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.45),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),
        // Date & Time row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Date'),
                  const SizedBox(height: 4),
                  Text(
                    'Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '01 Jan 2025',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Time'),
                  const SizedBox(height: 4),
                  Text(
                    '00:00 PM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Doors open 1h before',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLowerContent() {
    return Column(
      children: [
        // QR placeholder
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(Icons.qr_code_2, size: 140, color: Colors.black87),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Scan at entrance',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}
