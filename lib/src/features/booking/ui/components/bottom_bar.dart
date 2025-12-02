import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/features/booking/ui/components/access_container.dart';

import 'package:hydex/src/features/booking/ui/components/guest_form.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl/intl.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalGuests = ref.watch(guestsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: ref.watch(selectedPassProvider) == null
            ? PrimaryButton(
                onTap: null,
                title: "RSVP",
                frColor: Colors.black,
                bgColor: AppColors.buttonPrimaryDisabled,
              )
            : Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$totalGuests Passes",
                        style: AppTextStyles(context).smallMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: AppTextStyles(context).accumulator * 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TotalPriceDisplay(),
                    ],
                  ),
                  Spacer(),

                  FloatingActionButton.extended(
                    onPressed: () {
                      if (totalGuests == 1) {
                        context.push("/summary");
                        return;
                      }
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,

                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 12),
                                  Center(
                                    child: Container(
                                      height: 4,
                                      width: 44,
                                      decoration: BoxDecoration(
                                        color: Color(0xffDEDEDE),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 22),
                                  ExpandablePageView(
                                    controller: pageController,
                                    animationCurve: Curves.easeIn,
                                    animationDuration: Duration(
                                      milliseconds: 250,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                      totalGuests - 1,
                                      (index) => GuestForm(
                                        controller: pageController,
                                        guestNumber: index + 1,
                                        totalGuests: totalGuests,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    extendedPadding: EdgeInsets.all(75),
                    label: Text(
                      "Continue",
                      style: AppTextStyles(context).secondaryBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class TotalPriceDisplay extends ConsumerWidget {
  const TotalPriceDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finalPriceText = ref.watch(formattedTotalPriceProvider);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "\$$finalPriceText ",
            style: AppTextStyles(context).secondaryBold.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: AppTextStyles(context).accumulator * 16,
            ),
          ),
          TextSpan(
            text: "EGP", // Displays the currency
            style: AppTextStyles(
              context,
            ).captionMedium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
