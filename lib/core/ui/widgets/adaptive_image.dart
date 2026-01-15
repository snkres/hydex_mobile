import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A cache for storing decoded base64 images to avoid repeated decoding
final Map<String, Uint8List> _imageCache = {};

/// A reusable widget that displays images from various sources:
/// - Base64 encoded images (with or without data URI prefix)
/// - Network URLs (http/https)
///
/// The widget automatically detects the image source type and uses
/// the appropriate rendering method. Base64 images are cached to
/// improve performance.
class AdaptiveImage extends StatelessWidget {
  const AdaptiveImage({
    super.key,
    required this.imageData,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  /// The image data - can be a URL or base64 encoded string
  final String imageData;

  /// How the image should be inscribed into the space allocated
  final BoxFit fit;

  /// Optional width constraint
  final double? width;

  /// Optional height constraint
  final double? height;

  /// Optional custom placeholder widget for network images
  final Widget? placeholder;

  /// Optional custom error widget
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final child = _buildImageContent();

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: child);
    }

    return child;
  }

  Widget _buildImageContent() {
    if (imageData.startsWith('data:image') ||
        (!imageData.startsWith('http://') &&
            !imageData.startsWith('https://'))) {
      // Base64 image - decode once and cache
      return _buildBase64Image();
    } else {
      // Network URL image
      return _buildNetworkImage();
    }
  }

  Widget _buildBase64Image() {
    try {
      // Check cache first
      if (!_imageCache.containsKey(imageData)) {
        String base64String = imageData;
        if (imageData.contains(',')) {
          base64String = imageData.split(',')[1];
        }
        _imageCache[imageData] = base64Decode(base64String);
      }

      return Image.memory(
        _imageCache[imageData]!,
        fit: fit,
        width: width,
        height: height,
        gaplessPlayback: true, // Prevents flickering during rebuilds
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultErrorWidget(),
      );
    } catch (e) {
      return errorWidget ?? _defaultErrorWidget();
    }
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageData,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ?? const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          errorWidget ?? _defaultErrorWidget(),
    );
  }

  Widget _defaultErrorWidget() {
    return const Center(
      child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
    );
  }
}
