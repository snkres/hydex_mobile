import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class WhereWeGOScreen extends StatefulWidget {
  const WhereWeGOScreen({super.key});

  @override
  State<WhereWeGOScreen> createState() => _WhereWeGOScreenState();
}

class _WhereWeGOScreenState extends State<WhereWeGOScreen> {
  final List<String> countries = ["Egypt", "Dubai"];

  String? selectedCountry;

  String? selectedSize;
  List<String> groupSizes = ["Solo", "2–3", "4–6", "Large group 7+"];

  String? selectedArea;
  List<String> areas = [
    "Gouna",
    "North Coast",
    "Sheikh Zayed",
    "Heliopolis",
    "Zamalek",
    "Maadi",
    "New Cairo",
  ];

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
                                    "Tell us where you go",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Pick the areas you usually visit or want to explore",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 16),
                                  DropdownButtonFormField<String>(
                                    hint: Text("Country"),
                                    initialValue: selectedCountry,
                                    items: countries
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) {
                                      setState(() {
                                        selectedCountry = v;
                                      });
                                    },
                                    icon: Icon(Icons.keyboard_arrow_down),
                                  ),
                                  selectedCountry != null
                                      ? Column(
                                          children: [
                                            SizedBox(height: 16),

                                            Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: areas
                                                  .map(
                                                    (e) => CustomChip(
                                                      title: e,
                                                      isSelected:
                                                          e == selectedArea,
                                                      onTap: () {
                                                        setState(() {
                                                          selectedArea = e;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(height: 16),

                                  Text(
                                    "Your usual group size?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 12),

                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: groupSizes
                                        .map(
                                          (e) => CustomChip(
                                            title: e,
                                            isSelected: selectedSize == e,
                                            onTap: () {
                                              setState(() {
                                                selectedSize = e;
                                              });
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: PrimaryButton(
                                  onTap: () => context.go("/waitlist"),
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
