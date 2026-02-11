import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/src/features/location/domain/location_service.dart';
import 'package:hydex/src/features/vibes/data/category.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vibes_repository.g.dart';

@Riverpod(keepAlive: true)
Future<List<Banner>> getBanners(Ref ref, {required BannerType type}) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });
  try {
    final response = await DioHelper.get(
      '/banners',
      queryParameters: {"type": type.toValue()},
      cancelToken: cancelToken,
    );
    final eventsData = response.data['data'] as List<dynamic>;
    return eventsData.map((e) => BannerMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@Riverpod(keepAlive: true)
Future<List<EventCategory>> getEventCategories(Ref ref) async {
  try {
    final response = await DioHelper.get('/categories');
    final eventsData = response.data['data'] as List<dynamic>;
    return eventsData.map((e) => EventCategoryMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load event categories: $e');
  }
}

@riverpod
Future<List<Vendor>> getVendors(
  Ref ref, {
  int page = 1,
  String? categoryId,
  String? subcategoryId,
  String? country,
}) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });
  try {
    final Map<String, dynamic> data = {"page": page, "limit": 10};
    if (categoryId != null) {
      data["categoryId"] = categoryId;
    }
    if (subcategoryId != null) {
      data["subcategoryId"] = subcategoryId;
    }

    if (country == null) {
      // Get country from selected country provider (uses GPS as default)
      final selectedCountry = await ref.read(selectedCountryProvider.future);
      data["country"] = selectedCountry;
    }
    if (country != null) {
      data["country"] = country;
    }
    final response = await DioHelper.get(
      '/vendors',
      queryParameters: data,
      cancelToken: cancelToken,
    );
    final answer = response.data['data'] as List<dynamic>;

    final eventsData = answer.first as List<dynamic>;

    return eventsData.map((e) => VendorMapper.fromMap(e)).toList();
  } catch (e) {
    throw Exception('Failed to load vendors: $e');
  }
}

@riverpod
Future<List<Event>> getEvents(
  Ref ref, {
  int page = 1,
  String? categoryId,
  String? subcategoryId,
  bool? happeningTonight,
  bool? nearby,
}) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });

  final Map<String, dynamic> data = {"page": page, "limit": 10};
  if (categoryId != null) {
    data["categoryId"] = categoryId;
  }
  if (subcategoryId != null) {
    data["subcategoryId"] = subcategoryId;
  }

  if (happeningTonight != null) {
    data["happeningToday"] = happeningTonight;
  }

  if (nearby != null) {
    final userPosition = await LocationService().getCurrentPosition();
    data["lat"] = userPosition.latitude.toString();
    data["lng"] = userPosition.longitude.toString();
  }

  final selectedCountry = await ref.read(selectedCountryProvider.future);
  data["country"] = selectedCountry;

  // Get country from selected country provider (uses GPS as default)

  try {
    final response = await DioHelper.get(
      '/events',
      queryParameters: data,
      cancelToken: cancelToken,
    );
    final answer = response.data['data'] as List<dynamic>;

    final eventsData = answer.first as List<dynamic>;

    return eventsData.map((e) {
      log("Data E: $e");
      return EventMapper.fromMap(e);
    }).toList();
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@riverpod
Future<Event> getEventById(Ref ref, {required String id}) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });
  try {
    final response = await DioHelper.get(
      '/events/$id',
      cancelToken: cancelToken,
    );
    final answer = response.data['data'] as Map<String, dynamic>;
    log("Event Data: $answer");
    return EventMapper.fromMap(answer);
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

@riverpod
Future<Vendor> getVendorbyID(Ref ref, {required String id}) async {
  final link = ref.keepAlive();
  Timer? timer;
  final cancelToken = CancelToken();
  ref.onDispose(() {
    timer?.cancel();
    cancelToken.cancel();
  });
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close();
    });
  });
  ref.onResume(() {
    timer?.cancel();
  });
  try {
    final response = await DioHelper.get(
      '/vendors/$id',
      cancelToken: cancelToken,
    );
    final answer = response.data['data'] as Map<String, dynamic>;
    return VendorMapper.fromMap(answer);
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}
