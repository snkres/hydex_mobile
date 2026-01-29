import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hydex/core/cache/cache_helper.dart';

class RecentlyViewedItem {
  final String id;
  final String name;
  final String type; // 'vendor' or 'event'

  RecentlyViewedItem({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory RecentlyViewedItem.fromJson(Map<String, dynamic> json) {
    return RecentlyViewedItem(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class RecentlyViewedHelper {
  static const String _cacheKey = 'recently_viewed_items';
  static const int _maxItems = 5;

  static Future<void> addRecentlyViewed({
    required String id,
    required String name,
    required String type,
  }) async {
    try {
      final items = await getRecentlyViewed();

      // Remove if already exists to avoid duplicates
      items.removeWhere((item) => item.id == id);

      // Add new item at the beginning
      items.insert(
        0,
        RecentlyViewedItem(id: id, name: name, type: type),
      );

      // Keep only the last 5 items
      if (items.length > _maxItems) {
        items.removeRange(_maxItems, items.length);
      }

      // Save to cache
      final jsonList = items.map((item) => jsonEncode(item.toJson())).toList();
      await CacheHelper.setList(_cacheKey, jsonList);
    } catch (e) {
      if (kDebugMode) {
        print('Error adding recently viewed item: $e');
      }
    }
  }

  static Future<List<RecentlyViewedItem>> getRecentlyViewed() async {
    try {
      final cachedList = CacheHelper.getList(_cacheKey) ?? [];
      return cachedList
          .map((item) => RecentlyViewedItem.fromJson(
                jsonDecode(item) as Map<String, dynamic>,
              ))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting recently viewed items: $e');
      }
      return [];
    }
  }

  static Future<void> clearRecentlyViewed() async {
    try {
      await CacheHelper.remove(_cacheKey);
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing recently viewed items: $e');
      }
    }
  }
}
