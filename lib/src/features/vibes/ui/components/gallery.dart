import 'package:flutter/material.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class Gallery extends StatelessWidget {
  Gallery({super.key});
  int total = 9;
  int current = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBackButton(),
            Center(child: Container(color: Colors.red, height: 400)),
            Spacer(),
            Center(child: Text("< $current / $total >")),
            SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return SmoothContainer(
                    borderRadius: BorderRadius.circular(16),
                    smoothness: 1,
                    color: index % 2 == 0 ? Colors.amber : Colors.red,
                    height: 100,
                    width: 100,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
