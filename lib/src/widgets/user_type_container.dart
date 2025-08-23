import 'package:flutter/material.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/custom_radio.dart';

class UserTypeContainer<T> extends StatelessWidget {
  const UserTypeContainer({
    super.key,
    required this.title,
    required this.description,
    required this.emoji,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title, description, emoji;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(emoji, style: TextStyle(fontSize: 20)),
                CustomRadio(isSelected: value == groupValue),
              ],
            ),
            Text(title, style: AppTextStyles(context).smallSemibold),
            SizedBox(height: 6),
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
