import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Explore.",
              style: TextStyle(
                fontSize: 50,
                height: 0.3,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Book.",
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              "Enjoy.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.white,

                height: 0.3,
              ),
            ),
            SizedBox(height: 35),
            Text(
              "For Experience Seekers.",
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
            SizedBox(height: 4),

            Text(
              "Enjoy priority bookings, hidden gems, and exclusive perks. All in one place.",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 70),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50,
              ),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(minHeight: 500),
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          top: 16,
                          left: 16,
                          right: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Access the city’s most coveted spots, luxury deals, and curated experiences.",
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 16),
                                InternationalPhoneNumberInput(
                                  autoFocus: true,
                                  onInputChanged: (PhoneNumber number) {
                                    print(number.phoneNumber);
                                  },
                                  // Set initial country to Egypt
                                  initialValue: PhoneNumber(isoCode: 'EG'),
                                  selectorConfig: const SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                    // You can use this to show the flag and code
                                  ),
                                  textFieldController: TextEditingController(),
                                  keyboardType: TextInputType.phone,

                                  inputDecoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.auto,

                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "By continuing, you agree to to Hyde’x Privacy and Terms",
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: PrimaryButton(
                                onTap: () {
                                  context.push("/otp");
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
