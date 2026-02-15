import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/extensions/date_time_extension.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';

class FrontContainer extends StatelessWidget {
  const FrontContainer({
    super.key,
    required this.name,
    required this.nationality,
    required this.createdAt,
    required this.id,
  });

  final String name, nationality, id;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .symmetric(horizontal: 16),
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
        children: [
          Positioned.fill(
            left: 110,
            child: Align(
              alignment: .centerRight,
              child: SvgPicture.asset(
                "img/svg/ticket_logo.svg",
                package: "assets",
                height: .infinity,
                fit: BoxFit.contain,
                colorFilter: .mode(Colors.black, .srcIn),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: ShapeDecoration(
                        color: Colors.transparent,
                        shape: RoundedSuperellipseBorder(
                          borderRadius: .circular(8),
                        ),
                      ),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset(
                          "img/svg/correct.svg",
                          package: "assets",
                        ),
                        Text(
                          "Hydex Member",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 11,
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 20,
                              fontWeight: .w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "$nationality • Member since ${createdAt.toMonthYear()}",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 12,
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 69),
                    Column(
                      crossAxisAlignment: .end,
                      children: [
                        Text(
                          "#$id",
                          style: TextStyle(
                            fontWeight: .w700,
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "Membership Card",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textPrimary.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
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
