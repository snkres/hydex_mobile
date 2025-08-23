import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/boarding/provider/usertype_provider.dart';
import 'package:hydex/src/features/boarding/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class SeekerScreen extends StatefulWidget {
  const SeekerScreen({super.key});

  @override
  State<SeekerScreen> createState() => _SeekerScreenState();
}

class _SeekerScreenState extends State<SeekerScreen> {
  Set<String> selectedCategories = {};
  List<String> categories = [
    "🖼️ Arts & Culture",
    "🧘 Wellness & Relaxation",
    "🏞️ Outdoor & Leisure",
    "🏇 Adventure & Sports",
    "🔥 Nightlife, Raves & Entertainment",
    "👑 Exclusive & VIP Access",
    "🍽️ Social Dining",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tell us what you like",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Pick as many as you want, we’ll tailor your experience around them.",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: categories
                              .map(
                                (e) => CustomChip(
                                  title: e,
                                  isSelected: selectedCategories.contains(e),
                                  onTap: () {
                                    setState(() {
                                      if (selectedCategories.contains(e)) {
                                        selectedCategories.remove(e);
                                      } else {
                                        selectedCategories.add(e);
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final userType = ref.read(userTypeNotifierProvider);

                          return PrimaryButton(
                            onTap: selectedCategories.isEmpty
                                ? null
                                : () {
                                    if (userType == Role.seeker) {
                                      context.push("/wego");
                                    } else {
                                      context.push("/influencer");
                                    }
                                  },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
