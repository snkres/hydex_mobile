import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/src/features/scan/data/scan_response.dart';
import 'package:hydex/src/features/scan/domain/scan_providers.dart';
import 'package:hydex/src/features/scan/ui/scan.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

ScanResponse _makeResponse({
  required String status,
  DateTime? bookingDate,
}) {
  return ScanResponse(
    id: 'booking-123',
    bookingDate: bookingDate ?? DateTime.now(),
    fullName: 'Test User',
    email: 'test@example.com',
    status: status,
    pass: ScanPass(name: 'General'),
  );
}

String _qr({String source = 'EVENT', String bookingId = 'booking-123'}) =>
    jsonEncode({'bookingSource': source, 'bookingId': bookingId});

/// Fires a fake barcode detect on the [MobileScanner] found in the tree.
///
/// [MobileScanner] exposes its [onDetect] callback publicly, so we reach it
/// through the widget's callback property.
Future<void> _fireBarcode(WidgetTester tester, String raw) async {
  final scanner = tester.widget<MobileScanner>(find.byType(MobileScanner));
  final capture = BarcodeCapture(
    barcodes: [Barcode(rawValue: raw)],
  );
  scanner.onDetect?.call(capture);
}

GoRouter _router({List<GoRoute> extra = const []}) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const ScanScreen(),
        ),
        GoRoute(
          path: '/owner/scan/output',
          builder: (_, __) => const Scaffold(body: Text('ScanOutput')),
        ),
        GoRoute(
          path: '/owner/rsv/output',
          builder: (_, __) => const Scaffold(body: Text('RsvOutput')),
        ),
        ...extra,
      ],
    );

Widget _wrap({
  required GoRouter router,
  List<Override> overrides = const [],
}) =>
    ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(routerConfig: router),
    );

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('ScanScreen._onDetect', () {
    testWidgets('shows "Invalid QR code" for malformed JSON', (tester) async {
      final router = _router();
      await tester.pumpWidget(_wrap(router: router));
      await tester.pump();

      await _fireBarcode(tester, 'not-valid-json');
      await tester.pump();

      expect(find.text('Invalid QR code'), findsOneWidget);

      // After 2 s delay the state resets to idle
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Point at guest\'s QR code'), findsOneWidget);
    });

    testWidgets('shows "Event is not active" when bookingDate is not today',
        (tester) async {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final response = _makeResponse(status: 'PENDING', bookingDate: yesterday);

      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123')
                .overrideWith((_) async => response),
          ],
        ),
      );
      await tester.pump();

      await _fireBarcode(tester, _qr());
      await tester.pump();
      await tester.pump(); // let the async provider resolve

      expect(find.text('Event is not active'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Point at guest\'s QR code'), findsOneWidget);
    });

    testWidgets(
        'shows "Already scanned" for EVENT source when status is not PENDING',
        (tester) async {
      final response = _makeResponse(status: 'ENTERED');

      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123')
                .overrideWith((_) async => response),
          ],
        ),
      );
      await tester.pump();

      await _fireBarcode(tester, _qr(source: 'EVENT'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Already scanned'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Point at guest\'s QR code'), findsOneWidget);
    });

    testWidgets(
        'shows "Already scanned" for RSV source when status is not CONFIRMED',
        (tester) async {
      final response = _makeResponse(status: 'PENDING');

      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123')
                .overrideWith((_) async => response),
          ],
        ),
      );
      await tester.pump();

      await _fireBarcode(tester, _qr(source: 'RSV'));
      await tester.pump();
      await tester.pump();

      expect(find.text('Already scanned'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Point at guest\'s QR code'), findsOneWidget);
    });

    testWidgets('navigates to /owner/scan/output for valid EVENT scan',
        (tester) async {
      final response = _makeResponse(status: 'PENDING');

      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123')
                .overrideWith((_) async => response),
          ],
        ),
      );
      await tester.pump();

      await _fireBarcode(tester, _qr(source: 'EVENT'));
      await tester.pump();
      await tester.pump();

      expect(find.text('ScanOutput'), findsOneWidget);
    });

    testWidgets('navigates to /owner/rsv/output for valid RSV scan',
        (tester) async {
      final response = _makeResponse(status: 'CONFIRMED');

      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123')
                .overrideWith((_) async => response),
          ],
        ),
      );
      await tester.pump();

      await _fireBarcode(tester, _qr(source: 'RSV'));
      await tester.pump();
      await tester.pump();

      expect(find.text('RsvOutput'), findsOneWidget);
    });

    testWidgets('shows error message from ApiException on provider failure',
        (tester) async {
      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123').overrideWith(
              (_) async => throw Exception('Network error'),
            ),
          ],
        ),
      );
      await tester.pump();

      await _fireBarcode(tester, _qr());
      await tester.pump();
      await tester.pump();

      // Generic exception → shows the fallback "Something went wrong" message.
      expect(find.text('Something went wrong'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Point at guest\'s QR code'), findsOneWidget);
    });

    testWidgets('ignores second scan while first is still in-flight',
        (tester) async {
      var callCount = 0;
      final completer = Future<ScanResponse>.delayed(
        const Duration(milliseconds: 500),
        () {
          callCount++;
          return _makeResponse(status: 'PENDING');
        },
      );

      final router = _router();
      await tester.pumpWidget(
        _wrap(
          router: router,
          overrides: [
            getScanDetailsProvider(id: 'booking-123')
                .overrideWith((_) => completer),
          ],
        ),
      );
      await tester.pump();

      // Fire two scans in rapid succession.
      await _fireBarcode(tester, _qr());
      await _fireBarcode(tester, _qr());
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump();

      // Provider should only have been read once.
      expect(callCount, 1);
    });
  });
}
