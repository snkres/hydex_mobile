import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/src/app.dart' show MyApp;

void main() {
  runApp(ProviderScope(child: const MyApp()));
  AuthService.initialize();
}
