import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/components/password_checker.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool dontShow = true;
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  double _strength = 0;
  String _strengthText = '';
  Color _strengthColor = Color.fromRGBO(231, 231, 231, 1);

  // Regular expressions for character validation
  final RegExp _hasUpperCase = RegExp(r'[A-Z]');
  final RegExp _hasLowerCase = RegExp(r'[a-z]');
  final RegExp _hasNumber = RegExp(r'[0-9]');
  final RegExp _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  String? _validatePasswordConfirmation(String? value) {
    if (value!.isEmpty) {
      return "Please confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    }

    return null;
  }

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    passwordController.removeListener(_onPasswordChanged);
    passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    final password = passwordController.text;
    setState(() {
      _checkPasswordStrength(password);
    });
  }

  /// Calculates password strength and updates UI state
  void _checkPasswordStrength(String password) {
    // Initialize with default values
    double currentStrength = 0;
    String currentStrengthText = '';
    Color currentStrengthColor = Colors.grey;

    if (password.isEmpty) {
      // If the password is empty, reset to default state
      currentStrength = 0;
      currentStrengthText = '';
    } else if (password.length < 8) {
      // If password is less than 8 characters, it's always weak
      currentStrength = 0.25;
      currentStrengthText = 'Weak';
      currentStrengthColor = Colors.red;
    } else {
      // Password is long enough, let's check its complexity
      int criteriaMet = 0;
      if (_hasLowerCase.hasMatch(password)) criteriaMet++;
      if (_hasUpperCase.hasMatch(password)) criteriaMet++;
      if (_hasNumber.hasMatch(password)) criteriaMet++;
      if (_hasSpecialChar.hasMatch(password)) criteriaMet++;

      // Determine strength based on how many criteria were met
      switch (criteriaMet) {
        case 1:
          currentStrength = 0.25;
          currentStrengthText = 'Weak';
          currentStrengthColor = Colors.red;
          break;
        case 2:
          currentStrength = 0.5;
          currentStrengthText = 'Medium';
          currentStrengthColor = Colors.orange;
          break;
        case 3:
          currentStrength = 0.75;
          currentStrengthText = 'Strong';
          currentStrengthColor = Colors.green;
          break;
        case 4:
          currentStrength = 1.0;
          currentStrengthText = 'Secure';
          currentStrengthColor = Colors.blue; // New color for the highest level
          break;
        default:
          // This case should ideally not be reached if length > 8
          currentStrength = 0.25;
          currentStrengthText = 'Weak';
          currentStrengthColor = Colors.red;
      }
    }

    // Update the state variables that control the UI
    // Make sure to call setState() where this function is used
    _strength = currentStrength;
    _strengthText = currentStrengthText;
    _strengthColor = currentStrengthColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create your password",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "This is your key to the good life. Make it strong.",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 16),
                        Form(
                          key: formKey,
                          child: Column(
                            spacing: 10,
                            children: [
                              TextFormField(
                                controller: passwordController,
                                obscureText: hidePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: _validatePassword,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                        hidePassword
                                            ? "img/svg/eye_off.svg"
                                            : "img/svg/eye_on.svg",
                                        package: "assets",
                                        width: 24,
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: passwordConfirmController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: hideConfirmPassword,
                                onChanged: (value) {
                                  bool hasError =
                                      _validatePasswordConfirmation(value) !=
                                      null;
                                  setState(() {
                                    dontShow = hasError;
                                  });
                                },
                                validator: _validatePasswordConfirmation,
                                textInputAction: TextInputAction.done,

                                decoration: InputDecoration(
                                  labelText: "Confirm Password",
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hideConfirmPassword =
                                              !hideConfirmPassword;
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                        hideConfirmPassword
                                            ? "img/svg/eye_off.svg"
                                            : "img/svg/eye_on.svg",
                                        package: "assets",
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                          BlendMode.srcIn,
                                        ),
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              PasswordStrengthIndicator(
                                strength: _strength,
                                strengthText: _strengthText,
                                strengthColor: _strengthColor,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Consumer(
                            builder: (context, ref, child) {
                              return PrimaryButton(
                                onTap: shouldDisableButton()
                                    ? null
                                    : () async{
                                        if (formKey.currentState!.validate()) {
                                          ref
                                              .read(
                                                userProvider.notifier,
                                              )
                                              .create(
                                                password:
                                                    passwordConfirmController
                                                        .text,
                                              );
                                          context.push("/tellus");
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
        ],
      ),
    );
  }

  bool shouldDisableButton() {
    // The button should be disabled if ANY of these conditions are true.
    return
    // 1. Password field is empty
    passwordController.text.isEmpty ||
        // 2. Confirm Password field is empty
        passwordConfirmController.text.isEmpty ||
        // 3. Passwords do not match
        passwordController.text != passwordConfirmController.text ||
        // 4. Password is not Strong or Secure
        (_strengthText != "Strong" && _strengthText != "Secure");
  }
}
