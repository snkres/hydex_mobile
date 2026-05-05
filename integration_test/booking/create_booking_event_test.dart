import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydex/core/network/auth_service.dart';
import 'package:hydex/core/network/user/user.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/form_guest.dart';
import 'package:hydex/src/features/booking/data/guest.dart';
import 'package:hydex/src/features/booking/domain/booking_repository.dart';
import 'package:hydex/src/features/booking/domain/guests_repo.dart';
import 'package:hydex/src/features/booking/ui/create_booking.dart';
import 'package:hydex/src/features/booking/ui/summary.dart';
import 'package:hydex/src/features/profile/domain/profile_providers.dart';
import 'package:hydex/src/features/vibes/data/coordinates.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/features/vibes/data/location.dart';
import 'package:hydex/src/features/vibes/data/vendor.dart';
import 'package:hydex/src/features/vibes/domain/event_notifier.dart';
import 'package:hydex/src/features/vibes/ui/components/event_details.dart';
import 'package:integration_test/integration_test.dart';

// ---------------------------------------------------------------------------
// Fake data
// ---------------------------------------------------------------------------

final _fakePass = Passes(
  id: 'pass-001',
  name: 'General Admission',
  benefits: 'Access to all areas',
  price: 500,
  discountPercentage: 0,
);

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
// Test router — only the 3 screens involved in the booking flow
// ---------------------------------------------------------------------------

GoRouter _buildTestRouter() {
  return GoRouter(
    initialLocation: '/event/event-001',
    routes: [
      GoRoute(
        path: '/event/:id',
        builder: (context, state) =>
            EventDetailScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/create-booking',
        builder: (context, state) =>
            CreateBooking(book: state.extra! as CreateBook),
      ),
      GoRoute(
        path: '/summary',
        builder: (context, state) => const SummaryBooking(),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Provider overrides
// ---------------------------------------------------------------------------

List<dynamic> _buildOverrides() {
  final fakeGuestFormState = GuestFormState(
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

  return [
    // Fake event — no network call
    eventProvider('event-001').overrideWith(() => FakeEventNotifier()),

    // Fake current user
    currentUserProvider.overrideWith((_) async => _fakeUser),

    // Fake guest form (single guest = current user, no form needed)
    guestFormProvider(
      1,
    ).overrideWith(() => FakeGuestFormNotifier(fakeGuestFormState)),

    // Fake POST /bookings — always succeeds
    createBookingProvider.overrideWith((_) async => true),

    // Stub out providers that are invalidated after booking success
    getUpcomingEventsProvider.overrideWith((_) async => []),
  ];
}

// ---------------------------------------------------------------------------
// Fake notifiers
// ---------------------------------------------------------------------------

class FakeEventNotifier extends EventNotifier {
  @override
  FutureOr<Event> build(String id) async => _fakeEvent;
}

class FakeGuestFormNotifier extends GuestFormNotifier {
  FakeGuestFormNotifier(this._initialState);
  final GuestFormState _initialState;

  @override
  Future<GuestFormState> build(int totalGuests) async => _initialState;
}

// ---------------------------------------------------------------------------
// Test
// ---------------------------------------------------------------------------

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Single-guest event booking — happy path', (tester) async {
    final router = _buildTestRouter();

    await tester.pumpWidget(
      ProviderScope(
        overrides: _buildOverrides().cast(),
        child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData.dark(),
        ),
      ),
    );

    // Wait for event data to load
    await tester.pumpAndSettle();

    // ── Step 1: EventDetailScreen ─────────────────────────────────────────
    final rsvpBtn = find.text('RSVP');
    expect(rsvpBtn, findsOneWidget);
    await tester.tap(rsvpBtn);
    await tester.pumpAndSettle();

    final time = find.text('9:00 PM');
    expect(time, findsOneWidget);
    await tester.tap(time);
    await tester.pumpAndSettle();

    // ── Step 2: CreateBooking screen ──────────────────────────────────────
    expect(find.text('Number of Guests'), findsOneWidget);
    expect(find.text('Choose Your Access'), findsOneWidget);

    expect(find.text('General Admission'), findsOneWidget);
    final addBtn = find.text('Add');
    expect(addBtn, findsOneWidget);
    await tester.tap(addBtn);
    await tester.pumpAndSettle();

    final continueBtn = find.text('Continue');
    expect(continueBtn, findsOneWidget);

    await tester.tap(continueBtn);
    await tester.pumpAndSettle();

    // ── Step 3: SummaryBooking screen ─────────────────────────────────────
    expect(find.text('Review your booking'), findsOneWidget);
    expect(find.text('Total Price'), findsOneWidget);

    final proceedBtn = find.text('Proceed to Payment');
    expect(proceedBtn, findsOneWidget);
    await tester.tap(proceedBtn);
    // Pump manually — pumpAndSettle hangs because the success Lottie loops.
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 500));

    // ── Step 4: Success modal ─────────────────────────────────────────────
    expect(find.text('Your booking is confirmed'), findsOneWidget);
    expect(find.text('View my Bookings'), findsOneWidget);
  });
}
