import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/usertype_provider.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:hydex/src/widgets/user_type_container.dart';

class PickUserType extends StatelessWidget {
  const PickUserType({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentType = ref.watch(userTypeProvider);
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What brings you to Hydex?",
                  style: AppTextStyles(context).primaryBold,
                ),
                SizedBox(height: 8),
                Text(
                  "Help us tailor your experience.",
                  style: AppTextStyles(context).smallRegular.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 15),
                UserTypeContainer<Role>(
                  emoji: "👩‍🎤",
                  onChanged: (v) {
                    ref.read(userTypeProvider.notifier).change(v);
                  },
                  value: Role.seeker,
                  groupValue: currentType,
                  title: "I’m an Experience Seeker",
                  description:
                      "Discover luxury events, nightlife, and adventures",
                ),
                SizedBox(height: 15),

                UserTypeContainer<Role>(
                  emoji: "💫",
                  onChanged: (v) {
                    ref.read(userTypeProvider.notifier).change(v);
                  },
                  value: Role.ambassador,
                  groupValue: currentType,

                  title: "I’m an Influencer or Ambassador",
                  description: "Promote venues, host events, earn money",
                ),
                SizedBox(height: 15),
                UserTypeContainer<Role>(
                  emoji: "💼",
                  onChanged: (v) {
                    ref.read(userTypeProvider.notifier).change(v);
                  },
                  value: Role.owner,

                  groupValue: currentType,

                  title: "I’m a business owner",
                  description: "Boost bookings, attract guests, grow exposure",
                ),
                SizedBox(height: 16),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Consumer(
                builder: (context, ref, child) {
                  return PrimaryButton(
                    bgColor: AppColors.textBrand,
                    frColor: AppColors.textPrimary,
                    nullbgColor: Color(0xff080808),
                    nullfrColor: AppColors.surfaceContainer,
                    onTap: currentType != Role.none
                        ? () async {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            ref
                                .read(userTypeProvider.notifier)
                                .change(currentType.toValue());
                          }
                        : null,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
