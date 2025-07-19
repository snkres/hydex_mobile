import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeContainer<T> extends ConsumerWidget {
  const TypeContainer({
    super.key,
    this.svgPath,
    required this.title,
    required this.description,
    required this.value,
    required this.currentValue,
    required this.onTap,
  });

  final String? svgPath;
  final String title, description;
  final T value;
  final T currentValue;
  final Function(T) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = currentValue == value;
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),

        child: GestureDetector(
          onTap: () {
            onTap(value);
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    width: double.infinity,
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? BoxBorder.all(color: Color(0xff03392E), width: 2)
                          : null,
                    ),
                    padding: EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        svgPath == null
                            ? SizedBox.shrink()
                            : svgPath!.contains("svg")
                            ? SvgPicture.asset(svgPath!, package: "assets")
                            : Image.asset(svgPath!, package: "assets"),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          description,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13,
                            height: 150 / 100,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(14),
                child: Radio(
                  value: currentValue,
                  onChanged: (v) {
                    onTap(value);
                  },
                  groupValue: value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
