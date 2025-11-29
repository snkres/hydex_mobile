// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EventNotifier)
const eventProvider = EventNotifierFamily._();

final class EventNotifierProvider
    extends $AsyncNotifierProvider<EventNotifier, Event> {
  const EventNotifierProvider._({
    required EventNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventNotifierHash();

  @override
  String toString() {
    return r'eventProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventNotifier create() => EventNotifier();

  @override
  bool operator ==(Object other) {
    return other is EventNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventNotifierHash() => r'5f5edf7a26c665ffffb843ef73bd035e285613d4';

final class EventNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EventNotifier,
          AsyncValue<Event>,
          Event,
          FutureOr<Event>,
          String
        > {
  const EventNotifierFamily._()
    : super(
        retry: null,
        name: r'eventProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventNotifierProvider call(String id) =>
      EventNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'eventProvider';
}

abstract class _$EventNotifier extends $AsyncNotifier<Event> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<Event> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Event>, Event>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Event>, Event>,
              AsyncValue<Event>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
