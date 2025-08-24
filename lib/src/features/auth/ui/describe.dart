import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class Describe extends StatefulWidget {
  const Describe({super.key});

  @override
  State<Describe> createState() => _DescribeState();
}

class _DescribeState extends State<Describe> {
  String? describeType;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            Text(
                              "What describes you best?",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    AppTextStyles(context).accumulator * 26,
                              ),
                            ),
                            DescribeItem(
                              title: "🏢 I have a venue to rent",
                              description:
                                  "List your space and start getting bookings.",
                              isSelected: describeType == "venue",
                              onTap: () {
                                setState(() {
                                  describeType = "venue";
                                });
                              },
                            ),

                            DescribeItem(
                              title: "🎉 I’m organizing an event",
                              description:
                                  "Book exclusive venues and promote your event.",
                              isSelected: describeType == "event",
                              onTap: () {
                                setState(() {
                                  describeType = "event";
                                });
                              },
                            ),
                            DescribeItem(
                              title: "📣 I want more exposure for my business",
                              description:
                                  "Get discovered by high value guests.",
                              isSelected: describeType == "exposure",
                              onTap: () {
                                setState(() {
                                  describeType = "exposure";
                                });
                              },
                            ),
                            DescribeItem(
                              title: "🧩 Other",
                              description: "Let’s explore how we can help.",
                              isSelected: describeType == "other",
                              onTap: () {
                                setState(() {
                                  describeType = "other";
                                });
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: PrimaryButton(
                            onTap: describeType != null
                                ? () => context.push("/waitlist")
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
    );
  }
}

class DescribeItem extends StatelessWidget {
  const DescribeItem({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    this.isSelected = false,
  });
  final String title, description;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: MediaQuery.sizeOf(context).width,
        height: 66,
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? BoxBorder.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles(context).smallMedium),
            Text(
              description,
              style: AppTextStyles(context).captionRegular.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
