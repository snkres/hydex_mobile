import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/boarding/ui/tellus.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class NationalityTellUs extends StatefulWidget {
  const NationalityTellUs({super.key});

  @override
  State<NationalityTellUs> createState() => _NationalityTellUsState();
}

class _NationalityTellUsState extends State<NationalityTellUs> {
  String? type;
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            TextFormField(
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Nationality",
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                CustomChip(
                                  title: "Self Employed",
                                  isSelected: type == "Self",
                                  onTap: () {
                                    setState(() {
                                      type = "Self";
                                    });
                                  },
                                ),
                                CustomChip(
                                  title: "Student",
                                  isSelected: type == "Student",
                                  onTap: () {
                                    setState(() {
                                      type = "Student";
                                    });
                                  },
                                ),
                                CustomChip(
                                  title: "Employed",
                                  isSelected: type == "Employed",
                                  onTap: () {
                                    setState(() {
                                      type = "Employed";
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: "Instagram",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelText: "Facebook",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: "Invitation Code",
                              ),
                            ),
                            Text(
                              "if you don’t have an invite code just skip it.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(122, 127, 153, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: PrimaryButton(
                      onTap: () => context.push("/describe"),
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
