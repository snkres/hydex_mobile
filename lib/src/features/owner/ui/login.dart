import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/components/password_checker.dart';
import 'package:hydex/src/widgets/primary_btn.dart';

class OwnerLogin extends ConsumerStatefulWidget {
  const OwnerLogin({super.key, required this.token});
  final String token;

  @override
  ConsumerState<OwnerLogin> createState() => _OwnerLoginState();
}

class _OwnerLoginState extends ConsumerState<OwnerLogin> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  double _strength = 0;
  String _strengthText = '';
  Color _strengthColor = Color.fromRGBO(231, 231, 231, 1);

  final RegExp _hasUpperCase = RegExp(r'[A-Z]');
  final RegExp _hasLowerCase = RegExp(r'[a-z]');
  final RegExp _hasNumber = RegExp(r'[0-9]');
  final RegExp _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  void _checkPasswordStrength(String password) {
    double currentStrength = 0;
    String currentStrengthText = '';
    Color currentStrengthColor = Colors.grey;

    if (password.isEmpty) {
      currentStrength = 0;
      currentStrengthText = '';
    } else if (password.length < 8) {
      currentStrength = 0.25;
      currentStrengthText = 'Weak';
      currentStrengthColor = Colors.red;
    } else {
      int criteriaMet = 0;
      if (_hasLowerCase.hasMatch(password)) criteriaMet++;
      if (_hasUpperCase.hasMatch(password)) criteriaMet++;
      if (_hasNumber.hasMatch(password)) criteriaMet++;
      if (_hasSpecialChar.hasMatch(password)) criteriaMet++;

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
          currentStrengthColor = Colors.blue;
          break;
        default:
          currentStrength = 0.25;
          currentStrengthText = 'Weak';
          currentStrengthColor = Colors.red;
      }
    }

    _strength = currentStrength;
    _strengthText = currentStrengthText;
    _strengthColor = currentStrengthColor;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  bool _shouldDisableButton() {
    return _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _passwordController.text != _confirmPasswordController.text ||
        _strengthText == 'Weak' ||
        _strengthText == '';
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  void _onPasswordChanged() {
    setState(() {
      _checkPasswordStrength(_passwordController.text);
    });
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final fullName = user?.fullName ?? '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "img/svg/home.svg",
                    package: "assets",
                    width: 44,
                    colorFilter: ColorFilter.mode(
                      AppColors.borderBrand,
                      .srcIn,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await ref.read(authServiceProvider).logout();
                      if (context.mounted) {
                        context.go("/boarding");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.borderDefault,
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Mahmoud ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: "👋\n",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: "Welcome to Hydex!",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 28,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Congratulations! Your business is now live on Hydex",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 13,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Create password section
                    Text(
                      "Create your password",
                      style: TextStyle(
                        fontSize: AppTextStyles(context).accumulator * 15,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 10,
                        children: [
                          TextFormField(
                            focusNode: _passwordFocus,
                            controller: _passwordController,
                            obscureText: _hidePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: _validatePassword,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_confirmPasswordFocus);
                            },
                            decoration: InputDecoration(
                              labelText: "Enter password",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                  focusNode: FocusNode(canRequestFocus: false),
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  },
                                  icon: SvgPicture.asset(
                                    _hidePassword
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
                            focusNode: _confirmPasswordFocus,
                            controller: _confirmPasswordController,
                            obscureText: _hideConfirmPassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: _validateConfirmPassword,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                  focusNode: FocusNode(canRequestFocus: false),
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _hideConfirmPassword =
                                          !_hideConfirmPassword;
                                    });
                                  },
                                  icon: SvgPicture.asset(
                                    _hideConfirmPassword
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
                          PasswordStrengthIndicator(
                            strength: _strength,
                            strengthText: _strengthText,
                            strengthColor: _strengthColor,
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Bottom button
                    PrimaryButton(
                      title: "Confirm password",
                      onTap: _shouldDisableButton()
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await ref
                                    .read(authServiceProvider)
                                    .resetPassword(
                                      _confirmPasswordController.text,
                                      widget.token,
                                    );
                                // TODO: navigate after password creation
                              }
                            },
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
