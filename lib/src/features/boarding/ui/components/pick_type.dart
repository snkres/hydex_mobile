import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/boarding/data/usertype.dart';
import 'package:hydex/src/features/boarding/provider/usertype_provider.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:hydex/src/widgets/user_Type_container.dart';

class PickUserType extends StatelessWidget {
  const PickUserType({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentType = ref.watch(userTypeNotifierProvider);
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What brings you to Hydex?",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                SizedBox(height: 8),
                Text(
                  "Help us tailor your experience.",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                UserTypeContainer<UserType>(
                  emoji: "👩‍🎤",
                  onChanged: (v) {
                    ref.read(userTypeNotifierProvider.notifier).change(v);
                  },
                  value: UserType.seeker,
                  groupValue: currentType,
                  title: "I’m an Experience Seeker",
                  description:
                      "Discover luxury events, nightlife, and adventures",
                ),
                SizedBox(height: 16),

                UserTypeContainer<UserType>(
                  emoji: "💫",
                  onChanged: (v) {
                    ref.read(userTypeNotifierProvider.notifier).change(v);
                  },
                  value: UserType.ambassador,
                  groupValue: currentType,

                  title: "I’m an Influencer or Ambassador",
                  description: "Promote venues, host events, earn money",
                ),
                SizedBox(height: 16),
                UserTypeContainer<UserType>(
                  emoji: "💼",
                  onChanged: (v) {
                    ref.read(userTypeNotifierProvider.notifier).change(v);
                  },
                  value: UserType.owner,

                  groupValue: currentType,

                  title: "I’m a business owner",
                  description: "Boost bookings, attract guests, grow exposure",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PrimaryButton(
                onTap: currentType != UserType.none
                    ? () {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
