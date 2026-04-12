import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydex/src/features/vibes/ui/vibes_screen.dart';

Widget buildSubject({
  String heading = 'Test Venue',
  String date = 'Free Entry',
  String? image,
  String? tag,
  String? description,
  String? avatarImage,
  int? discount,
  VoidCallback? onView,
}) {
  return MaterialApp(
    home: Scaffold(
      body: EventContainer(
        heading: heading,
        date: date,
        image: image,
        tag: tag,
        description: description,
        avatarImage: avatarImage,
        discount: discount,
        onView: onView,
      ),
    ),
  );
}

void main() {
  group('EventContainer nullable values', () {
    testWidgets('renders without errors when all nullable fields are null',
        (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('always shows heading and date', (tester) async {
      await tester.pumpWidget(buildSubject(
        heading: 'The Grand Hall',
        date: 'Premium',
      ));
      await tester.pump();

      expect(find.text('The Grand Hall'), findsOneWidget);
      expect(find.text('Premium'), findsOneWidget);
    });

    // image ---------------------------------------------------------------

    testWidgets('shows broken_image placeholder when image is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(image: null));
      await tester.pump();

      // The placeholder Container holds a broken_image icon (size 40)
      final icons = tester.widgetList<Icon>(find.byIcon(Icons.broken_image));
      expect(icons.any((i) => i.size == 40), isTrue);
    });

    testWidgets('shows ImageOrVideoWidget when image is provided',
        (tester) async {
      await tester.pumpWidget(
          buildSubject(image: 'https://example.com/photo.jpg'));
      await tester.pump();

      expect(find.byType(ImageOrVideoWidget), findsOneWidget);
    });

    // tag -----------------------------------------------------------------

    testWidgets('does not show tag badge when tag is null', (tester) async {
      await tester.pumpWidget(buildSubject(tag: null));
      await tester.pump();

      expect(find.text('Nightlife'), findsNothing);
    });

    testWidgets('shows tag badge when tag is provided', (tester) async {
      await tester.pumpWidget(buildSubject(tag: 'Nightlife'));
      await tester.pump();

      expect(find.text('Nightlife'), findsOneWidget);
    });

    // avatarImage ---------------------------------------------------------

    testWidgets(
        'shows fallback CircleAvatar with broken_image icon when avatarImage is null and tag is provided',
        (tester) async {
      await tester.pumpWidget(buildSubject(tag: 'Music', avatarImage: null));
      await tester.pump();

      expect(
        find.widgetWithIcon(CircleAvatar, Icons.broken_image),
        findsOneWidget,
      );
    });

    testWidgets(
        'does not show fallback CircleAvatar icon when avatarImage is provided',
        (tester) async {
      await tester.pumpWidget(buildSubject(
        tag: 'Music',
        avatarImage: 'https://example.com/logo.png',
      ));
      await tester.pump();

      expect(
        find.widgetWithIcon(CircleAvatar, Icons.broken_image),
        findsNothing,
      );
    });

    // description ---------------------------------------------------------

    testWidgets('does not show description when description is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(description: null));
      await tester.pump();

      expect(find.text('123 Main Street'), findsNothing);
    });

    testWidgets('shows description text when description is provided',
        (tester) async {
      await tester.pumpWidget(buildSubject(description: '123 Main Street'));
      await tester.pump();

      expect(find.text('123 Main Street'), findsOneWidget);
    });

    // discount ------------------------------------------------------------

    testWidgets('does not show discount banner when discount is null',
        (tester) async {
      await tester.pumpWidget(buildSubject(discount: null));
      await tester.pump();

      // Visibility(visible: false) removes the child from the tree entirely
      expect(find.textContaining('OFF Entry Fees'), findsNothing);
    });

    testWidgets('shows discount banner when discount is provided',
        (tester) async {
      await tester.pumpWidget(buildSubject(discount: 25));
      await tester.pump();

      expect(find.text('25% OFF Entry Fees'), findsOneWidget);
    });

    // onView --------------------------------------------------------------

    testWidgets('tapping with null onView does not throw', (tester) async {
      await tester.pumpWidget(buildSubject(onView: null));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('tapping calls onView when provided', (tester) async {
      var called = false;
      await tester.pumpWidget(buildSubject(onView: () => called = true));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(called, isTrue);
    });
  });
}
