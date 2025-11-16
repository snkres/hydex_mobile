import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:smooth_corner/smooth_corner.dart';

final guestsProvider = StateProvider<int>((ref) => 3);

class GuestsContainer extends StatelessWidget {
  const GuestsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Consumer(
              builder: (context, ref, _) {
                final selectedGuests = ref.watch(guestsProvider);
                return Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Container(
                            height: 4,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Color(0xffDEDEDE),
                              borderRadius: .circular(4),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        Padding(
                          padding: const .symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                "Select number of guests",
                                style: AppTextStyles(context).smallBold,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Total number of guests, you included.",
                                style: AppTextStyles(context).smallRegular
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 60,
                          child: ListView.separated(
                            scrollDirection: .horizontal,
                            padding: const .symmetric(horizontal: 16),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  ref.read(guestsProvider.notifier).state =
                                      index + 1;
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  width: 59,
                                  height: 60,
                                  curve: Curves.easeInOut,
                                  decoration: ShapeDecoration(
                                    shape: SmoothRectangleBorder(
                                      side: BorderSide(
                                        color: selectedGuests == index + 1
                                            ? AppColors.borderBrand
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      smoothness: 1,
                                    ),
                                    color: selectedGuests == index + 1
                                        ? AppColors.signalBrandTint
                                        : AppColors.surfaceContainerLighter,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: AppTextStyles(context).smallBold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const .symmetric(
                            horizontal: 16,
                            vertical: 24,
                          ),
                          child: PrimaryButton(
                            bgColor: Colors.white,
                            frColor: Colors.black,
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            title: "Continue",
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Consumer(
        builder: (context, ref, _) {
          final selectedGuests = ref.watch(guestsProvider);

          return Container(
            height: 56,
            margin: .symmetric(horizontal: 16),
            padding: .symmetric(horizontal: 16),
            width: .infinity,
            decoration: BoxDecoration(
              color: Color(0xff1E1E20),
              border: .all(color: AppColors.borderDefault),
              borderRadius: .circular(100),
            ),
            child: Row(
              children: [
                SvgPicture.asset("img/svg/guests.svg", package: "assets"),
                SizedBox(width: 8),
                Text(
                  "Number of Guests",
                  style: AppTextStyles(context).smallMedium,
                ),
                Spacer(),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: Offset(0, 0.5),
                          end: .zero,
                        ).animate(animation);
                        return ClipRect(
                          child: SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ),
                        );
                      },
                  child: Text(
                    selectedGuests.toString(),
                    key: ValueKey<int>(selectedGuests),
                    style: AppTextStyles(context).smallMedium,
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
              ],
            ),
          );
        },
      ),
    );
  }
}
