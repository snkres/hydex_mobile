import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({super.key, this.isSelected = false});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 24,
      height: 24,
      duration: Duration(milliseconds: 300),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: BoxBorder.all(
          width: isSelected ? 1 : 2,
          color: isSelected ? Color(0xff0A7AFF) : Color(0xffE1EBED),
        ),
      ),
      child: isSelected
          ? Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff0A7AFF),
              ),
            )
          : null,
    );
  }
}
