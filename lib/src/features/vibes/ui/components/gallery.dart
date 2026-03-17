import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;

  bool _isVideo(String url) => url.toLowerCase().endsWith('.mp4');

  @override
  void initState() {
    super.initState();
    selectedPhoto = widget.clickedPhoto;
    _initVideoIfNeeded(selectedPhoto!);
  }

  void _initVideoIfNeeded(String url) {
    _videoController?.dispose();
    _videoController = null;
    _isVideoInitialized = false;

    if (_isVideo(url)) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..setLooping(true)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isVideoInitialized = true;
              _videoController!.play();
            });
          }
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
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
            Expanded(
              child: Center(
                child: _buildMainContent(),
              ),
            ),
            Center(
              child: Text(
                "${selectedIndex ?? 0 + 1} / ${widget.gallery.length}",
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final url = widget.gallery[index];
                  bool isSelected = selectedPhoto == url;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index + 1;
                        selectedPhoto = url;
                      });
                      _initVideoIfNeeded(url);
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
                          _isVideo(url)
                              ? _buildVideoThumbnail(url)
                              : url.endsWith(".avif")
                                  ? CachedNetworkAvifImage(
                                      url,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      imageUrl: url,
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

  Widget _buildMainContent() {
    if (_isVideo(selectedPhoto!)) {
      if (_isVideoInitialized) {
        return AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_videoController!),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _videoController!.value.isPlaying
                        ? _videoController!.pause()
                        : _videoController!.play();
                  });
                },
                child: AnimatedOpacity(
                  opacity: _videoController!.value.isPlaying ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Center(child: CircularProgressIndicator());
    }

    if (selectedPhoto!.endsWith(".avif")) {
      return CachedNetworkAvifImage(selectedPhoto!);
    }
    return CachedNetworkImage(
      imageUrl: selectedPhoto!,
      fit: BoxFit.cover,
    );
  }

  Widget _buildVideoThumbnail(String url) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.black,
      child: Center(
        child: Icon(
          Icons.play_circle_outline,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
