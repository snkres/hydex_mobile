import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:smooth_corner/smooth_corner.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key, required this.gallery, required this.clickedPhoto});
  final List<String> gallery;
  final String clickedPhoto;

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int? selectedIndex;
  String? selectedPhoto;

  @override
  void initState() {
    super.initState();
    selectedPhoto = widget.clickedPhoto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBackButton(),
            Center(
              child: CachedNetworkImage(
                imageUrl: selectedPhoto ?? widget.clickedPhoto,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                "< ${selectedIndex ?? 0 + 1} / ${widget.gallery.length} >",
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  bool isSelected = selectedPhoto == widget.gallery[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index + 1;
                        selectedPhoto = widget.gallery[index];
                      });
                    },
                    child: SmoothClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      side: isSelected
                          ? BorderSide(
                              color: AppColors.signalBrandSolid,
                              width: 2,
                            )
                          : BorderSide.none,
                      smoothness: 1,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            imageUrl: widget.gallery[index],
                          ),
                          isSelected
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  color: AppColors.signalBrandTint.withValues(
                                    alpha: 0.7,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemCount: widget.gallery.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
