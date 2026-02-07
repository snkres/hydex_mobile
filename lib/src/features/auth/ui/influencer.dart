import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class InfluencerScreen extends StatefulWidget {
  const InfluencerScreen({super.key});

  @override
  State<InfluencerScreen> createState() => _InfluencerScreenState();
}

class _InfluencerScreenState extends State<InfluencerScreen> {
  List<String> contentNiche = [
    'Luxury',
    'Nightlife',
    'Food & Travel',
    'Tech',
    'Yoga & Wellness',
    'Fashion',
  ];
  Set<String> selectedContent = {};

  List<String> audienceSizeRange = [
    '1K – 5K',
    '5K – 20K',
    '20K – 100K',
    '100K – 500K',
    '500K – 1M',
    '1M+',
  ];
  String? selectedSize;

  final countryActivityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "img/gradient.png",
            package: "assets",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBackButton(),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your influencer story",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Tell us about your work as a content creator so we can tailor the right opportunities for you.",
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          14,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    "Choose your content niches",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: contentNiche
                                        .map(
                                          (e) => CustomChip(
                                            title: e,
                                            isSelected: selectedContent
                                                .contains(e),
                                            onTap: () {
                                              setState(() {
                                                if (selectedContent.contains(
                                                  e,
                                                )) {
                                                  selectedContent.remove(e);
                                                } else {
                                                  selectedContent.add(e);
                                                }
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    "Audience size range",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: audienceSizeRange
                                        .map(
                                          (e) => CustomChip(
                                            title: e,
                                            isSelected: e == selectedSize,
                                            onTap: () {
                                              if (selectedSize == e) {
                                                setState(() {
                                                  selectedSize = null;
                                                });
                                              } else {
                                                setState(() {
                                                  selectedSize = e;
                                                });
                                              }
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 24),
                                  TextFormField(
                                    controller: countryActivityController,
                                    decoration: InputDecoration(
                                      labelText: "City of primary activity",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "City of primary activity is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    return PrimaryButton(
                                      onTap: selectedSize != null
                                          ? () async {
                                              ref
                                                  .read(userProvider.notifier)
                                                  .create(
                                                    preferredCountry:
                                                        countryActivityController
                                                            .text,
                                                    contentNiches:
                                                        selectedContent
                                                            .toList(),
                                                    audienceSizeRange:
                                                        selectedSize,
                                                  );
                                              await ref
                                                  .read(authServiceProvider)
                                                  .createProfile();
                                              if (!context.mounted) return;

                                              context.go("/waitlist");
                                            }
                                          : null,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
