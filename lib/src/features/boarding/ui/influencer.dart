import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/boarding/ui/tellus.dart';
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
  String? selectedContent;

  List<String> audienceSizeRange = [
    '1K – 5K',
    '5K – 20K',
    '20K – 100K',
    '100K – 500K',
    '500K – 1M',
    '1M+',
  ];
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Tell us about your work as a content creator so we can tailor the right opportunities for you.",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 16),
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
                                        isSelected: e == selectedContent,
                                        onTap: () {
                                          setState(() {
                                            selectedContent = e;
                                          });
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(height: 16),
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
                                          setState(() {
                                            selectedSize = e;
                                          });
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "City of primary activity",
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: PrimaryButton(
                              onTap:
                                  selectedContent != null &&
                                      selectedSize != null
                                  ? () => context.go("/waitlist")
                                  : null,
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
    );
  }
}
