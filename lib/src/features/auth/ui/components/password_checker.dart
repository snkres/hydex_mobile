import 'package:flutter/material.dart';
import 'package:hydex/core/ui/type.dart';

/// UI Widget to display the password strength indicator
class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;
  final String strengthText;
  final Color strengthColor;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
    required this.strengthText,
    required this.strengthColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Min 8 Characters with a combination of letters and numbers",
          style: TextStyle(
            fontSize: AppTextStyles(context).accumulator * 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(flex: 1, child: _buildBar(strength >= 0.25)),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _buildBar(strength >= 0.5)),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _buildBar(strength >= 0.75)),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _buildBar(strength >= 1.0)),
            const SizedBox(width: 12),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5.0,
                ), // Adjust this value
                child: Text(
                  key: ValueKey<String>(strengthText),
                  strengthText,
                  style: AppTextStyles(
                    context,
                  ).captionMedium.copyWith(color: strengthColor, height: 1),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a single bar in the strength meter
  Widget _buildBar(bool filled) {
    // Use AnimatedContainer to automatically animate color changes
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // Set an animation duration
      curve: Curves.easeIn, // Optional: Add an animation curve
      height: 3,
      decoration: BoxDecoration(
        color: filled ? strengthColor : Color.fromRGBO(231, 231, 231, 1),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
