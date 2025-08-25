import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/custom_radio.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class WhereWeGOScreen extends StatefulWidget {
  const WhereWeGOScreen({super.key});

  @override
  State<WhereWeGOScreen> createState() => _WhereWeGOScreenState();
}

class _WhereWeGOScreenState extends State<WhereWeGOScreen> {
  final List<String> countries = ["Egypt", "Dubai"];
  final countryController = TextEditingController();
  String? selectedCountry;

  String? selectedSize;
  List<String> groupSizes = ["Solo", "2–3", "4–6", "Large group 7+"];

  String? selectedArea;
  List<String> egyptAreas = [
    "Gouna",
    "North Coast",
    "Sheikh Zayed",
    "Heliopolis",
    "Zamalek",
    "Maadi",
    "New Cairo",
    "Sharm El Sheikh",
  ];
  List<String> uaeAreas = [
    "Dubai",
    "Abu Dhabi ",
    "Sharjah",
    "Northern Emirates ",
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
                                  TextFormField(
                                    controller: countryController,
                                    enableInteractiveSelection: false,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Wrap(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 40,
                                                        height: 4,
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey
                                                              .shade300,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                2,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),

                                                    // Title
                                                    const Text(
                                                      'Select Country',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      leading: Text(
                                                        '🇪🇬',
                                                        style: const TextStyle(
                                                          fontSize: 26,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        'Egypt',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      trailing: CustomRadio(
                                                        isSelected:
                                                            selectedCountry ==
                                                            "EG",
                                                      ),
                                                      onTap: () {
                                                        _selectCountry(
                                                          "Egypt",
                                                          "EG",
                                                        );
                                                        context.pop();
                                                      },
                                                    ),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      leading: Text(
                                                        '🇦🇪',
                                                        style: const TextStyle(
                                                          fontSize: 26,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        'United Arab Emirates (UAE)',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      trailing: CustomRadio(
                                                        isSelected:
                                                            selectedCountry ==
                                                            "UAE",
                                                      ),
                                                      onTap: () {
                                                        _selectCountry(
                                                          "United Arab Emirates (UAE)",
                                                          "UAE",
                                                        );

                                                        context.pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please choose your country";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hint: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                          top: 3,
                                          left: 16,
                                        ),
                                        child: Text(
                                          "Country",
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurfaceVariant,
                                            fontSize:
                                                AppTextStyles(
                                                  context,
                                                ).accumulator *
                                                15,
                                          ),
                                        ),
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,

                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ),
                                  _buildInlineAreaSelector(),
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

  Widget _buildInlineAreaSelector() {
    if (selectedCountry == null) return const SizedBox.shrink();

    final areas = selectedCountry == "EG" ? egyptAreas : uaeAreas;

    return Column(
      children: [
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: areas
              .map(
                (area) => CustomChip(
                  title: area,
                  isSelected: area == selectedArea,
                  onTap: () => setState(() => selectedArea = area),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void _selectCountry(String displayText, String countryCode) {
    setState(() {
      selectedCountry = countryCode;
      countryController.text = displayText;
    });
  }
}
