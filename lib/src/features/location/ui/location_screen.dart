import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/cities_service.dart';
import 'package:smooth_corner/smooth_corner.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final List<String> countries = ["Egypt", "UAE"];

  final List<String> images = ["img/svg/egypt.svg", "img/svg/dubai.svg"];

  String selectedCountry = "Egypt";

  final Map<String, List<String>> countryCities = {
    "Egypt": Cities.egyptAreas,
    "UAE": Cities.uaeAreas,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.keyboard_arrow_down),
        ),

        title: Text(
          'Location',
          style: TextStyle(
            fontSize: AppTextStyles(context).accumulator * 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmoothContainer(
                height: 64,
                width: double.infinity,
                color: AppColors.signalBrandTint,
                borderRadius: BorderRadius.circular(16),
                smoothness: 1,
                padding: EdgeInsets.symmetric(horizontal: 16),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'img/svg/location_outline.svg',
                      package: "assets",
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Use current location',
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Maadi Saryaat,  Maadi Cairo Egypt",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Text(
                "Country",
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),

              SizedBox(
                height: 100,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCountry = countries[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selectedCountry == countries[index]
                                ? AppColors.borderBrand
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: SmoothClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          smoothness: 1,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: selectedCountry == countries[index]
                                  ? AppColors.signalBrandTint
                                  : Color(0xff2C2C2E),
                            ),
                            width: 120,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  images[index],
                                  package: "assets",
                                  height: 52,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  countries[index],
                                  style: TextStyle(
                                    fontSize:
                                        AppTextStyles(context).accumulator * 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: countries.length,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(width: 12),
                ),
              ),
              SizedBox(height: 16),

              Text(
                "City",
                style: TextStyle(
                  fontSize: AppTextStyles(context).accumulator * 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: MediaQuery.heightOf(context),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            countryCities[selectedCountry]?[index] ?? "",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined, size: 16),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12);
                  },
                  itemCount: countryCities[selectedCountry]?.length ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
