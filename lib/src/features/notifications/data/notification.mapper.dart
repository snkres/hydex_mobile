// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'notification.dart';

class AppNotificationMapper extends ClassMapperBase<AppNotification> {
  AppNotificationMapper._();

  static AppNotificationMapper? _instance;
  static AppNotificationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppNotificationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppNotification';

  static String _$id(AppNotification v) => v.id;
  static const Field<AppNotification, String> _f$id = Field('id', _$id);
  static String _$title(AppNotification v) => v.title;
  static const Field<AppNotification, String> _f$title = Field(
    'title',
    _$title,
  );
  static String _$body(AppNotification v) => v.body;
  static const Field<AppNotification, String> _f$body = Field('body', _$body);
  static bool _$isRead(AppNotification v) => v.isRead;
  static const Field<AppNotification, bool> _f$isRead = Field(
    'isRead',
    _$isRead,
  );
  static DateTime _$createdAt(AppNotification v) => v.createdAt;
  static const Field<AppNotification, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<AppNotification> fields = const {
    #id: _f$id,
    #title: _f$title,
    #body: _f$body,
    #isRead: _f$isRead,
    #createdAt: _f$createdAt,
  };

  static AppNotification _instantiate(DecodingData data) {
    return AppNotification(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      body: data.dec(_f$body),
      isRead: data.dec(_f$isRead),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppNotification fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppNotification>(map);
  }

  static AppNotification fromJson(String json) {
    return ensureInitialized().decodeJson<AppNotification>(json);
  }
}

mixin AppNotificationMappable {
  String toJson() {
    return AppNotificationMapper.ensureInitialized()
        .encodeJson<AppNotification>(this as AppNotification);
  }

  Map<String, dynamic> toMap() {
    return AppNotificationMapper.ensureInitialized().encodeMap<AppNotification>(
      this as AppNotification,
    );
  }

  AppNotificationCopyWith<AppNotification, AppNotification, AppNotification>
  get copyWith =>
      _AppNotificationCopyWithImpl<AppNotification, AppNotification>(
        this as AppNotification,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppNotificationMapper.ensureInitialized().stringifyValue(
      this as AppNotification,
    );
  }

  @override
  bool operator ==(Object other) {
    return AppNotificationMapper.ensureInitialized().equalsValue(
      this as AppNotification,
      other,
    );
  }

  @override
  int get hashCode {
    return AppNotificationMapper.ensureInitialized().hashValue(
      this as AppNotification,
    );
  }
}

extension AppNotificationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AppNotification, $Out> {
  AppNotificationCopyWith<$R, AppNotification, $Out> get $asAppNotification =>
      $base.as((v, t, t2) => _AppNotificationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppNotificationCopyWith<$R, $In extends AppNotification, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? title,
    String? body,
    bool? isRead,
    DateTime? createdAt,
  });
  AppNotificationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AppNotificationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppNotification, $Out>
    implements AppNotificationCopyWith<$R, AppNotification, $Out> {
  _AppNotificationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppNotification> $mapper =
      AppNotificationMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? title,
    String? body,
    bool? isRead,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (title != null) #title: title,
      if (body != null) #body: body,
      if (isRead != null) #isRead: isRead,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  AppNotification $make(CopyWithData data) => AppNotification(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    body: data.get(#body, or: $value.body),
    isRead: data.get(#isRead, or: $value.isRead),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  AppNotificationCopyWith<$R2, AppNotification, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AppNotificationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

