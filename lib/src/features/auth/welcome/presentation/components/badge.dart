import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.text, required this.onDelete});
  final String text;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 73,
          width: double.infinity,
          color: Color(0xff01271F),
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset("img/svg/shape.svg", package: "assets"),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
