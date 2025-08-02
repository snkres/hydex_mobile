import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class Tellus extends StatefulWidget {
  const Tellus({super.key});

  @override
  State<Tellus> createState() => _TellusState();
}

class _TellusState extends State<Tellus> {
  String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tell us about yourself",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Help us get to know you and tailor your experience.",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Form(
                        child: Column(
                          spacing: 12,
                          children: [
                            TextFormField(
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Full Name",
                              ),
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(labelText: "Email"),
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: "Date of Birth",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        spacing: 8,
                        children: [
                          CustomChip(
                            title: "Male",
                            isSelected: gender == "Male",
                            onTap: () {
                              setState(() {
                                gender = "Male";
                              });
                            },
                          ),
                          CustomChip(
                            title: "Female",
                            isSelected: gender == "Female",
                            onTap: () {
                              setState(() {
                                gender = "Female";
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PrimaryButton(
                      onTap: () => context.push("/nationality"),
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

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 32,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Color.fromRGBO(247, 247, 247, 1),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
