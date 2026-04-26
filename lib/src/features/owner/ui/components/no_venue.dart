import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';

class NoVenue extends StatelessWidget {
  const NoVenue({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No venue listed yet',
              style: TextStyle(
                fontSize: styles.accumulator * 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 330,
              child: Text(
                "To start managing a venue, reach out to our team. We'll get your space listed so you can operate it and start boosting sales through Hydex.",
                style: styles.secondaryRegular.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // TODO: open WhatsApp chat with Hydex
              },
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondaryPressed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Contact us',
                  style: TextStyle(
                    fontSize: styles.accumulator * 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.buttonText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
