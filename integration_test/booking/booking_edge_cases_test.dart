import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/network.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/form_guest.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/features/booking/ui/components/guest_form.dart';
import 'package:hydex/src/features/booking/ui/summary.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/event_notifier.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// ---------------------------------------------------------------------------
// Shared fake data
// ---------------------------------------------------------------------------

final _fakePass = Passes(
  id: 'pass-001',
  name: 'General Admission',
  benefits: 'Access to all areas',
  price: 500,
  discountPercentage: 0,
);

/// Pure event: startTime set, operatingHours empty → isEvent == true
final _fakeEvent = Event(
  id: 'event-001',
  name: 'Test Night Out',
  description: 'An amazing night.',
  startTime: DateTime(2026, 6, 15, 21, 0),
  endTime: DateTime(2026, 6, 15, 23, 0),
  media: [],
  location: Location(
    address: '12 Test St, Cairo',
    coordinates: Coordinates(lat: 30.0, lng: 31.0),
  ),
  details: [],
  tags: ['nightlife'],
  category: CategoryNoDesc(id: 'cat-1', name: 'Nightlife'),
  experiences: [],
  vendor: Vendor(
    id: 'vendor-001',
    name: 'Test Venue',
    description: 'A cool venue',
    logo: null,
    location: Location(
      address: '12 Test St, Cairo',
      coordinates: Coordinates(lat: 30.0, lng: 31.0),
    ),
    operatingHours: {},
    experiences: [],
    media: [],
    gallery: [],
    thingsToKnow: [],
  ),
  createdAt: DateTime(2024, 1, 1),
  bookingExperience: BookingExperience(
    id: 'exp-001',
    passes: [_fakePass],
    requireReservationApproval: false,
  ),
);

/// Hybrid: startTime set AND operatingHours non-empty → isVendor == true
final _fakeHybridEvent = Event(
  id: 'event-002',
  name: 'Hybrid Night',
  description: 'Both startTime and operatingHours are set.',
  startTime: DateTime(2026, 6, 15, 21, 0),
  endTime: DateTime(2026, 6, 15, 23, 0),
  media: [],
  location: Location(
    address: '12 Test St, Cairo',
    coordinates: Coordinates(lat: 30.0, lng: 31.0),
  ),
  details: [],
  tags: ['nightlife'],
  category: CategoryNoDesc(id: 'cat-1', name: 'Nightlife'),
  experiences: [],
  vendor: Vendor(
    id: 'vendor-002',
    name: 'Hybrid Venue',
    description: 'A cool venue',
    logo: null,
    location: Location(
      address: '12 Test St, Cairo',
      coordinates: Coordinates(lat: 30.0, lng: 31.0),
    ),
    operatingHours: {'Saturday': OperatingHours(open: '20:00', close: '02:00')},
    experiences: [],
    media: [],
    gallery: [],
    thingsToKnow: [],
  ),
  createdAt: DateTime(2024, 1, 1),
  bookingExperience: BookingExperience(
    id: 'exp-002',
    passes: [_fakePass],
    requireReservationApproval: false,
  ),
);

final _fakeUser = User(
  id: 'user-001',
  email: 'test@hydex.com',
  phone: '+201234567890',
  fullName: 'Test User',
  gender: 'male',
  status: UserStatus.active,
  role: Role.seeker,
  createdAt: DateTime(2024, 1, 1),
  dateOfBirth: DateTime(2000, 1, 1),
);

// ---------------------------------------------------------------------------
// Fake notifiers
// ---------------------------------------------------------------------------

class FakeEventNotifier extends EventNotifier {
  FakeEventNotifier(this._event);
  final Event _event;

  @override
  FutureOr<Event> build(String id) async => _event;
}

class FakeGuestFormNotifier extends GuestFormNotifier {
  FakeGuestFormNotifier(this._initialState);
  final GuestFormState _initialState;

  @override
  Future<GuestFormState> build(int totalGuests) async => _initialState;
}

class _InitialCreateBookNotifier extends CreateBookNotifier {
  _InitialCreateBookNotifier(this._initial);
  final CreateBook _initial;

  @override
  CreateBook? build() => _initial;
}

// ---------------------------------------------------------------------------
// Helper — build a minimal ProviderScope + router scoped to the summary screen
// ---------------------------------------------------------------------------

Widget _buildSummaryApp({
  required List<Override> overrides,
  CreateBook? initialBook,
}) {
  final router = GoRouter(
    initialLocation: '/summary',
    routes: [
      GoRoute(path: '/summary', builder: (_, __) => const SummaryBooking()),
      GoRoute(
        path: '/',
        builder: (_, __) => const Scaffold(body: Text('Home')),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      if (initialBook != null)
        createBookProvider.overrideWith(
          () => _InitialCreateBookNotifier(initialBook),
        ),
      ...overrides,
    ],
    child: MaterialApp.router(routerConfig: router, theme: ThemeData.dark()),
  );
}

// ---------------------------------------------------------------------------
// Helper — build the guest-form widget in isolation
// ---------------------------------------------------------------------------

Widget _buildGuestFormApp({required List<Override> overrides}) {
  final controller = PageController();

  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: GuestForm(
            controller: controller,
            guestNumber: 2,
            totalGuests: 3,
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ── 1. Double-tap "Proceed to Payment" must not fire two requests ────────

  group('Double-tap Confirm', () {
    testWidgets('tapping Proceed to Payment twice fires the API exactly once', (
      tester,
    ) async {
      int callCount = 0;
      final completer = Completer<bool>();

      final guestFormState = GuestFormState(
        guests: [
          Guest(
            name: 'Test User',
            email: 'test@hydex.com',
            phoneNumber: '+201234567890',
            gender: 'male',
            age: 26,
          ),
        ],
        currentIndex: 0,
      );

      final initialBook = CreateBook(
        name: 'Test Night Out',
        passes: [_fakePass],
        image: '',
        location: '12 Test St, Cairo',
        startTime: DateTime(2026, 6, 15, 21, 0),
        selectedDate: DateTime(2026, 6, 15, 21, 0),
        selectedSlot: DateTime(2026, 6, 15, 21, 0),
        selectedPasses: _fakePass,
      );

      final app = ProviderScope(
        overrides: [
          currentUserProvider.overrideWith((_) async => _fakeUser),
          guestFormProvider(
            1,
          ).overrideWith(() => FakeGuestFormNotifier(guestFormState)),
          // Slow fake so both taps arrive before the first resolves
          createBookingProvider.overrideWith((_) {
            callCount++;
            return completer.future;
          }),
          getUpcomingEventsProvider.overrideWith((_) async => []),
          createBookProvider.overrideWith(() => _InitialCreateBookNotifier(initialBook)),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/summary',
            routes: [
              GoRoute(
                path: '/summary',
                builder: (_, __) => const SummaryBooking(),
              ),
              GoRoute(
                path: '/',
                builder: (_, __) => const Scaffold(body: Text('Home')),
              ),
            ],
          ),
          theme: ThemeData.dark(),
        ),
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final btn = find.text('Proceed to Payment');
      expect(btn, findsOneWidget);

      // Tap twice in quick succession before the first resolves.
      // After the first tap + pump the label swaps to a loading indicator,
      // so use the FAB widget itself for the second tap attempt.
      final fab = find.byType(FloatingActionButton);
      await tester.tap(btn);
      await tester.pump();
      await tester.tap(fab, warnIfMissed: false);
      await tester.pump();

      completer.complete(true);
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));

      expect(
        callCount,
        1,
        reason: 'Button should be disabled after first tap — only one API call',
      );
    });
  });

  // ── 2. Network failure — form state must remain intact for retry ─────────

  group('Network failure mid-flow', () {
    testWidgets('createBookProvider state is intact after API error', (
      tester,
    ) async {
      final initialBook = CreateBook(
        name: 'Test Night Out',
        passes: [_fakePass],
        image: '',
        location: '12 Test St, Cairo',
        startTime: DateTime(2026, 6, 15, 21, 0),
        selectedDate: DateTime(2026, 6, 15, 21, 0),
        selectedSlot: DateTime(2026, 6, 15, 21, 0),
        selectedPasses: _fakePass,
      );

      final guestFormState = GuestFormState(
        guests: [
          Guest(
            name: 'Test User',
            email: 'test@hydex.com',
            phoneNumber: '+201234567890',
            gender: 'male',
            age: 26,
          ),
        ],
        currentIndex: 0,
      );

      int callCount = 0;

      final app = ProviderScope(
        overrides: [
          currentUserProvider.overrideWith((_) async => _fakeUser),
          guestFormProvider(
            1,
          ).overrideWith(() => FakeGuestFormNotifier(guestFormState)),
          createBookingProvider.overrideWith((_) async {
            callCount++;
            throw ApiException('Network error');
          }),
          getUpcomingEventsProvider.overrideWith((_) async => []),
          createBookProvider.overrideWith(() => _InitialCreateBookNotifier(initialBook)),
        ],
        child: MaterialApp.router(
          routerConfig: GoRouter(
            initialLocation: '/summary',
            routes: [
              GoRoute(
                path: '/summary',
                builder: (_, __) => const SummaryBooking(),
              ),
              GoRoute(
                path: '/',
                builder: (_, __) => const Scaffold(body: Text('Home')),
              ),
            ],
          ),
          theme: ThemeData.dark(),
        ),
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Summary screen still shows booking details
      expect(find.text('Review your booking'), findsOneWidget);
      expect(find.text('Total Price'), findsOneWidget);

      // Tap the button — API throws
      expect(find.text('Proceed to Payment'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      await tester.ensureVisible(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Error snackbar visible
      expect(find.text('Network error'), findsOneWidget);

      // Button is re-enabled so the user can retry
      expect(find.text('Proceed to Payment'), findsOneWidget);

      // Booking data is still present (summary screen did NOT pop)
      expect(find.text('Review your booking'), findsOneWidget);

      // Second tap succeeds — verify the retry path works
      callCount = 0; // reset counter

      // Override with success for the retry
      // (Re-tap will re-read the provider; we just verify count is 1 after retry)
      await tester.tap(find.text('Proceed to Payment'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Still failed (same override), but the key assertion is that loading
      // returned to false after the first failure, enabling the retry tap.
      expect(
        callCount,
        1,
        reason: 'Retry should fire exactly one more request',
      );
    });
  });

  // ── 3. Event vs Vendor distinction (hybrid case) ─────────────────────────

  group('Event vs Vendor distinction', () {
    test('pure event: isEvent==true, isVendor==false', () {
      final book = CreateBook(
        name: 'Event',
        passes: [_fakePass],
        image: '',
        location: 'Cairo',
        startTime: DateTime(2026, 6, 15, 21, 0),
        operatingHours: [],
      );

      expect(book.isEvent, isTrue);
      expect(book.isVendor, isFalse);
    });

    test('pure vendor: isEvent==false, isVendor==true', () {
      final book = CreateBook(
        name: 'Venue',
        passes: [_fakePass],
        image: '',
        location: 'Cairo',
        operatingHours: [DateTime(2026, 6, 15, 21, 0)],
      );

      expect(book.isEvent, isFalse);
      expect(book.isVendor, isTrue);
    });

    test(
      'hybrid (startTime + operatingHours both set): isVendor wins, isEvent is false',
      () {
        final book = CreateBook(
          name: 'Hybrid',
          passes: [_fakePass],
          image: '',
          location: 'Cairo',
          startTime: DateTime(2026, 6, 15, 21, 0),
          operatingHours: [DateTime(2026, 6, 15, 21, 0)],
        );

        // operatingHours.isNotEmpty → isVendor == true
        expect(book.isVendor, isTrue);
        // startTime != null but operatingHours NOT empty → isEvent == false
        expect(
          book.isEvent,
          isFalse,
          reason:
              'When operatingHours is non-empty, the vendor path wins even if startTime is set',
        );
      },
    );
  });

  // ── 4. Instagram field validation messages ───────────────────────────────

  group('Instagram field validation', () {
    final overrides = <Override>[
      currentUserProvider.overrideWith((_) async => _fakeUser),
      guestFormProvider(3).overrideWith(
        () => FakeGuestFormNotifier(
          GuestFormState(guests: List.filled(3, null), currentIndex: 0),
        ),
      ),
    ];

    testWidgets('empty Instagram shows "Instagram is not correct"', (
      tester,
    ) async {
      await tester.pumpWidget(_buildGuestFormApp(overrides: overrides));
      await tester.pumpAndSettle();

      // Fill all other required fields to isolate Instagram validation
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'Jane Doe',
      );
      await tester.enterText(find.widgetWithText(TextFormField, 'Age'), '25');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'jane@test.com',
      );

      // Leave Instagram blank and submit
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Instagram is not correct'), findsOneWidget);
    });

    testWidgets('non-Instagram URL shows "Must be a valid Instagram URL"', (
      tester,
    ) async {
      await tester.pumpWidget(_buildGuestFormApp(overrides: overrides));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'Jane Doe',
      );
      await tester.enterText(find.widgetWithText(TextFormField, 'Age'), '25');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'jane@test.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Instagram'),
        'https://twitter.com/user',
      );

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Must be a valid Instagram URL'), findsOneWidget);
    });

    testWidgets('valid Instagram URL passes validation', (tester) async {
      await tester.pumpWidget(_buildGuestFormApp(overrides: overrides));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'Jane Doe',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Instagram'),
        'https://www.instagram.com/janedoe',
      );
      await tester.enterText(find.widgetWithText(TextFormField, 'Age'), '25');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'jane@test.com',
      );

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // Neither instagram-specific error should appear
      expect(find.text('Instagram is not correct'), findsNothing);
      expect(find.text('Must be a valid Instagram URL'), findsNothing);
      expect(find.text('Invalid URL'), findsNothing);
    });

    testWidgets('plain username (no URL) is rejected with "Invalid URL"', (
      tester,
    ) async {
      await tester.pumpWidget(_buildGuestFormApp(overrides: overrides));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'Jane Doe',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Instagram'),
        'janedoe',
      );
      await tester.enterText(find.widgetWithText(TextFormField, 'Age'), '25');
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'jane@test.com',
      );

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      // A bare username has no scheme → Uri.hasAbsolutePath check fails
      expect(find.text('Invalid URL'), findsOneWidget);
    });
  });
}
