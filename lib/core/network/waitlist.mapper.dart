// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'waitlist.dart';

class WaitlistResponseMapper extends ClassMapperBase<WaitlistResponse> {
  WaitlistResponseMapper._();

  static WaitlistResponseMapper? _instance;
  static WaitlistResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WaitlistResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WaitlistResponse';

  static String _$referralCode(WaitlistResponse v) => v.referralCode;
  static const Field<WaitlistResponse, String> _f$referralCode =
      Field('referralCode', _$referralCode);
  static String _$originalPosition(WaitlistResponse v) => v.originalPosition;
  static const Field<WaitlistResponse, String> _f$originalPosition =
      Field('originalPosition', _$originalPosition);

  @override
  final MappableFields<WaitlistResponse> fields = const {
    #referralCode: _f$referralCode,
    #originalPosition: _f$originalPosition,
  };

  static WaitlistResponse _instantiate(DecodingData data) {
    return WaitlistResponse(
        referralCode: data.dec(_f$referralCode),
        originalPosition: data.dec(_f$originalPosition));
  }

  @override
  final Function instantiate = _instantiate;

  static WaitlistResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WaitlistResponse>(map);
  }

  static WaitlistResponse fromJson(String json) {
    return ensureInitialized().decodeJson<WaitlistResponse>(json);
  }
}

mixin WaitlistResponseMappable {
  String toJson() {
    return WaitlistResponseMapper.ensureInitialized()
        .encodeJson<WaitlistResponse>(this as WaitlistResponse);
  }

  Map<String, dynamic> toMap() {
    return WaitlistResponseMapper.ensureInitialized()
        .encodeMap<WaitlistResponse>(this as WaitlistResponse);
  }

  WaitlistResponseCopyWith<WaitlistResponse, WaitlistResponse, WaitlistResponse>
      get copyWith =>
          _WaitlistResponseCopyWithImpl<WaitlistResponse, WaitlistResponse>(
              this as WaitlistResponse, $identity, $identity);
  @override
  String toString() {
    return WaitlistResponseMapper.ensureInitialized()
        .stringifyValue(this as WaitlistResponse);
  }

  @override
  bool operator ==(Object other) {
    return WaitlistResponseMapper.ensureInitialized()
        .equalsValue(this as WaitlistResponse, other);
  }

  @override
  int get hashCode {
    return WaitlistResponseMapper.ensureInitialized()
        .hashValue(this as WaitlistResponse);
  }
}

extension WaitlistResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WaitlistResponse, $Out> {
  WaitlistResponseCopyWith<$R, WaitlistResponse, $Out>
      get $asWaitlistResponse => $base
          .as((v, t, t2) => _WaitlistResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class WaitlistResponseCopyWith<$R, $In extends WaitlistResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? referralCode, String? originalPosition});
  WaitlistResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _WaitlistResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WaitlistResponse, $Out>
    implements WaitlistResponseCopyWith<$R, WaitlistResponse, $Out> {
  _WaitlistResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WaitlistResponse> $mapper =
      WaitlistResponseMapper.ensureInitialized();
  @override
  $R call({String? referralCode, String? originalPosition}) =>
      $apply(FieldCopyWithData({
        if (referralCode != null) #referralCode: referralCode,
        if (originalPosition != null) #originalPosition: originalPosition
      }));
  @override
  WaitlistResponse $make(CopyWithData data) => WaitlistResponse(
      referralCode: data.get(#referralCode, or: $value.referralCode),
      originalPosition:
          data.get(#originalPosition, or: $value.originalPosition));

  @override
  WaitlistResponseCopyWith<$R2, WaitlistResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WaitlistResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
