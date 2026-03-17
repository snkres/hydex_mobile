import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/type.dart';

class BackContainer extends StatelessWidget {
  const BackContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .symmetric(horizontal: 16),
      width: .infinity,
      height: 200,
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: Color.fromARGB(255, 44, 40, 50),
            offset: Offset(0.5, -2.5),
          ),
        ],
        shape: RoundedSuperellipseBorder(borderRadius: .circular(20)),
        gradient: RadialGradient(
          radius: 3,
          center: .topLeft,
          colors: [Color(0xff511C96), Color(0xff101010)],
        ),
      ),
      child: Stack(
        alignment: .center,
        children: [
          Positioned.fill(
            left: 100,
            child: Align(
              alignment: .centerRight,
              child: SvgPicture.asset(
                "img/svg/ticket_logo.svg",
                package: "assets",
                height: .infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  "HYDEX MEMBERSHIP",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 20,
                    fontWeight: .w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "For the exceptional.",
                  style: TextStyle(
                    fontSize: AppTextStyles(context).accumulator * 11,
                    color: Colors.white.withValues(alpha: 0.5),
                    fontWeight: .w400,
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
