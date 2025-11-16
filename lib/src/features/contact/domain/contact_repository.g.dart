// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getContacts)
const getContactsProvider = GetContactsProvider._();

final class GetContactsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Contact>>,
          List<Contact>,
          FutureOr<List<Contact>>
        >
    with $FutureModifier<List<Contact>>, $FutureProvider<List<Contact>> {
  const GetContactsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getContactsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getContactsHash();

  @$internal
  @override
  $FutureProviderElement<List<Contact>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Contact>> create(Ref ref) {
    return getContacts(ref);
  }
}

String _$getContactsHash() => r'743fec898a70a18507f999d9af8b5930970c3d4c';
