import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/country_picker_provider.dart';
import 'package:hydex/src/features/auth/ui/components/country_picker.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/booking/ui/components/guest_form.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

final guestsListProvider = StateProvider<List<Guest>>((ref) => []);

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "3 Passes",
                style: AppTextStyles(context).smallMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: AppTextStyles(context).accumulator * 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$5,100 ",
                      style: AppTextStyles(context).secondaryBold.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppTextStyles(context).accumulator * 16,
                      ),
                    ),
                    TextSpan(
                      text: "EGP",
                      style: AppTextStyles(context).smallMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: AppTextStyles(context).accumulator * 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Wrap(
                    children: [
                      Column(
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
                            animationDuration: Duration(milliseconds: 250),
                            physics: const NeverScrollableScrollPhysics(),
                            children: [GuestForm(controller: pageController)],
                          ),
                        ],
                      ),
                    ],
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
    );
  }
}
