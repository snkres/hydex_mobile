import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/auth/ui/tellus.dart';
import 'package:hydex/src/features/profile/data/upcoming_event.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:smooth_corner/smooth_corner.dart';

class Passport extends ConsumerStatefulWidget {
  const Passport({super.key});

  @override
  ConsumerState<Passport> createState() => _PassportState();
}

class _PassportState extends ConsumerState<Passport> {
  PassportCategory selectedCategory = PassportCategory(categoryName: "All");
  static final Map<String, Color> _colorCache = {};

  void _extractColors(List<PassportCategory> categories) {
    for (final category in categories) {
      if (category.vendors == null) continue;
      for (final vendor in category.vendors!) {
        if (vendor.media.isEmpty) continue;
        final imageUrl = vendor.media.first;
        if (_colorCache.containsKey(imageUrl)) continue;
        ColorScheme.fromImageProvider(
          provider: CachedNetworkImageProvider(imageUrl),
          brightness: Brightness.dark,
        ).then((scheme) {
          if (mounted) setState(() => _colorCache[imageUrl] = scheme.primary);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final passport = ref.watch(getPassportProvider);
    return passport.when(
      data: (data) {
        _extractColors(data.categories);
        final dataWithAll = [
          PassportCategory(categoryName: "All"),
          ...data.categories,
        ];
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          data.totalExperiences.toString(),
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 30,
                            fontWeight: .w700,
                          ),
                        ),
                        Text(
                          "Total Experiences",
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset("img/svg/routing.svg", package: "assets"),
                  ],
                ),
              ),
              SizedBox(
                height: 37,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return CustomChip(
                      title: dataWithAll[index].categoryName,
                      count: dataWithAll[index].count?.toString(),
                      isSelected:
                          selectedCategory.categoryName ==
                          dataWithAll[index].categoryName,
                      onTap: () {
                        setState(() {
                          selectedCategory = dataWithAll[index];
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: dataWithAll.length,
                ),
              ),
              SizedBox(height: 16),
              ...() {
                final filteredCategories =
                    selectedCategory.categoryName == "All"
                    ? data.categories
                    : data.categories
                          .where(
                            (c) =>
                                c.categoryName == selectedCategory.categoryName,
                          )
                          .toList();

                return filteredCategories
                    .where((c) => c.vendors != null && c.vendors!.isNotEmpty)
                    .expand((category) {
                      return category.vendors!.map((vendor) {
                        final image = vendor.media.isNotEmpty
                            ? vendor.media.first
                            : null;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: PassportContainer(
                            title: vendor.vendorName,
                            id: vendor.vendorId,
                            image: image,
                            category: category.categoryName,
                            visit: vendor.visitCount.toString().padLeft(2, '0'),
                            baseColor: image != null
                                ? _colorCache[image]
                                : null,
                          ),
                        );
                      });
                    })
                    .toList();
              }(),
              SizedBox(height: 100),
            ],
          ),
        );
      },
      error: (e, s) {
        log("Passport Error", error: e, stackTrace: s);
        return Center(child: Text("Error"));
      },
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}

class PassportContainer extends StatelessWidget {
  const PassportContainer({
    super.key,
    required this.title,
    required this.category,
    required this.visit,
    this.image,
    this.baseColor,
    required this.id,
  });

  final String title, category, visit, id;
  final String? image;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    final imageProvider = image != null
        ? CachedNetworkImageProvider(image!)
        : null;
    final color = baseColor ?? AppColors.borderBrand;
    return GestureDetector(
      onTap: () =>
          context.pushNamed("vendor_detail", pathParameters: {"id": id}),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SmoothClipRRect(
          smoothness: 1,
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topCenter,
                          colors: [
                            color,
                            Color.lerp(color, Colors.black, 0.4)!,
                            Color.lerp(color, Colors.black, 0.75)!,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        "img/svg/pattern.svg",
                        package: "assets",
                        fit: BoxFit.cover,
                        color: AppColors.backgroundBase.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  SmoothContainer(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: imageProvider,
                          onBackgroundImageError: (_, _) =>
                              Center(child: Icon(Icons.broken_image)),
                        ),
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              visit,
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                              ),
                            ),
                            Text(
                              "Visit(s)",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
