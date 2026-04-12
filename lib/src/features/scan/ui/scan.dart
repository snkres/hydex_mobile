import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/blur_app_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smooth_corner/smooth_corner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlurAppBar(title: "QR Scanner", scrollController: controller),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 62.5),
            // SmoothContainer(
            //   alignment: .center,
            //   borderRadius: .circular(50),
            //   smoothness: 1,
            //   color: Color(0xff1e1e2040),
            //   height: 250,
            //   width: 250,
            //   child: SvgPicture.asset(
            //     "img/svg/scan.svg",
            //     width: 219,
            //     package: "assets",
            //   ),
            // ),
            SmoothClipRRect(
              borderRadius: .circular(50),
              smoothness: 1,
              child: SizedBox(
                height: 250,
                width: 250,
                child: MobileScanner(
                  
                  onDetect: (result) {
                    print(result.barcodes.first.rawValue);
                  },
                ),
              ),
            ),

            SizedBox(height: 42),
            Text(
              "Point at guest's QR code",
              style: TextStyle(
                fontSize: AppTextStyles(context).accumulator * 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
