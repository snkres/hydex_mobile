import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/provider/cities_service.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/location/ui/location_required.dart';
import 'package:hydex/src/features/vibes/domain/vibes_repository.dart';
import 'package:smooth_corner/smooth_corner.dart';

class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  final List<String> countries = ["Egypt", "UAE"];

  final List<String> images = ["img/svg/egypt.svg", "img/svg/dubai.svg"];

  String selectedCountry = "Egypt";

  final Map<String, List<String>> countryCities = {
    "Egypt": Cities.egyptAreas,
    "UAE": Cities.uaeAreas,
  };

  @override
  void initState() {
    super.initState();
    // Initialize from GPS-based provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedCountryProvider.future).then((country) {
        if (mounted) {
          setState(() {
            selectedCountry = country == "EGYPT" ? "Egypt" : "UAE";
          });
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(currentAddressProvider, (previous, next) {
      next.whenData((addressData) {
        final gpsCountry = addressData['country'];
        if (gpsCountry != null && mounted) {
          String newCountry = "Egypt";
          if (gpsCountry.toLowerCase().contains('egypt')) {
            newCountry = "Egypt";
          } else if (gpsCountry.toLowerCase().contains('arab') ||
              gpsCountry.toLowerCase().contains('uae') ||
              gpsCountry.toLowerCase().contains('emirates')) {
            newCountry = "UAE";
          }
          setState(() => selectedCountry = newCountry);
          ref
              .read(selectedCountryProvider.notifier)
              .setCountry(newCountry == "Egypt" ? "EGYPT" : "UAE");
        }
      });
    });

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
        child: LocationRequired(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final currentAddressAsync = ref.watch(
                      currentAddressProvider,
                    );

                    return GestureDetector(
                      onTap: () {
                        ref.invalidate(currentAddressProvider);
                      },
                      child: SmoothContainer(
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Use current location',
                                    style: TextStyle(
                                      fontSize:
                                          AppTextStyles(context).accumulator *
                                          14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  currentAddressAsync.when(
                                    data: (addressData) {
                                      final address =
                                          addressData['fullAddress'] ??
                                          'Unable to get address';
                                      return Text(
                                        address,
                                        style: TextStyle(
                                          fontSize:
                                              AppTextStyles(
                                                context,
                                              ).accumulator *
                                              12,
                                          color: AppColors.textSecondary,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    },
                                    loading: () => Text(
                                      'Getting your location...',
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    error: (error, stack) => Text(
                                      'Tap to retry',
                                      style: TextStyle(
                                        fontSize:
                                            AppTextStyles(context).accumulator *
                                            12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
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
                          // Update the provider
                          ref
                              .read(selectedCountryProvider.notifier)
                              .setCountry(
                                countries[index] == "Egypt" ? "EGYPT" : "UAE",
                              );
                          ref.refresh(getEventsProvider());
                          ref.refresh(getVendorsProvider());
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
                                          AppTextStyles(context).accumulator *
                                          12,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
