import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nationality_provider.g.dart';

@Riverpod(keepAlive: true)
class NationalityNotifier extends _$NationalityNotifier {
  @override
  String? build() {
    return null;
  }

  void change(String value) => state = value;
}

class NationalityService {
  static Future<List<String>> getNationalities() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'packages/assets/json/nationalities.json',
      );

      final jsonList = json.decode(jsonString);

      if (jsonList is List) {
        final result = jsonList.map((e) => e.toString()).toList();
        return result;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
