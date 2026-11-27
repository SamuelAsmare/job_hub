// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppSettings {
  String get userId;
  bool get notificationsEnabled;
  bool get emailNotificationsEnabled;
  bool get pushNotificationsEnabled;
  String get themeMode;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as AppSettings;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppSettings &&
            (identical(other.userId, _this.userId) ||
                other.userId == _this.userId) &&
            (identical(
                    other.notificationsEnabled, _this.notificationsEnabled) ||
                other.notificationsEnabled == _this.notificationsEnabled) &&
            (identical(other.emailNotificationsEnabled,
                    _this.emailNotificationsEnabled) ||
                other.emailNotificationsEnabled ==
                    _this.emailNotificationsEnabled) &&
            (identical(other.pushNotificationsEnabled,
                    _this.pushNotificationsEnabled) ||
                other.pushNotificationsEnabled ==
                    _this.pushNotificationsEnabled) &&
            (identical(other.themeMode, _this.themeMode) ||
                other.themeMode == _this.themeMode));
  }

  @override
  int get hashCode {
    final _this = this as AppSettings;
    return Object.hash(
        runtimeType,
        _this.userId,
        _this.notificationsEnabled,
        _this.emailNotificationsEnabled,
        _this.pushNotificationsEnabled,
        _this.themeMode);
  }

  @override
  String toString() {
    final _this = this as AppSettings;
    return 'AppSettings(userId: ${_this.userId}, notificationsEnabled: ${_this.notificationsEnabled}, emailNotificationsEnabled: ${_this.emailNotificationsEnabled}, pushNotificationsEnabled: ${_this.pushNotificationsEnabled}, themeMode: ${_this.themeMode})';
  }
}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) _then) =
      _$AppSettingsCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      bool notificationsEnabled,
      bool emailNotificationsEnabled,
      bool pushNotificationsEnabled,
      String themeMode});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res> implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? notificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? pushNotificationsEnabled = null,
    Object? themeMode = null,
  }) {
    return _then(AppSettings(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _self.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _self.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _self.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppSettings value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppSettings() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppSettings value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettings():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppSettings value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettings() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String userId,
            bool notificationsEnabled,
            bool emailNotificationsEnabled,
            bool pushNotificationsEnabled,
            String themeMode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppSettings() when $default != null:
        return $default(
            _that.userId,
            _that.notificationsEnabled,
            _that.emailNotificationsEnabled,
            _that.pushNotificationsEnabled,
            _that.themeMode);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String userId,
            bool notificationsEnabled,
            bool emailNotificationsEnabled,
            bool pushNotificationsEnabled,
            String themeMode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettings():
        return $default(
            _that.userId,
            _that.notificationsEnabled,
            _that.emailNotificationsEnabled,
            _that.pushNotificationsEnabled,
            _that.themeMode);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String userId,
            bool notificationsEnabled,
            bool emailNotificationsEnabled,
            bool pushNotificationsEnabled,
            String themeMode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppSettings() when $default != null:
        return $default(
            _that.userId,
            _that.notificationsEnabled,
            _that.emailNotificationsEnabled,
            _that.pushNotificationsEnabled,
            _that.themeMode);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AppSettings implements AppSettings {
  const _AppSettings(
      {required this.userId,
      this.notificationsEnabled = true,
      this.emailNotificationsEnabled = true,
      this.pushNotificationsEnabled = true,
      this.themeMode = 'light'});

  @override
  final String userId;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool emailNotificationsEnabled;
  @override
  @JsonKey()
  final bool pushNotificationsEnabled;
  @override
  @JsonKey()
  final String themeMode;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppSettingsCopyWith<_AppSettings> get copyWith =>
      __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppSettings &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.emailNotificationsEnabled,
                    emailNotificationsEnabled) ||
                other.emailNotificationsEnabled == emailNotificationsEnabled) &&
            (identical(
                    other.pushNotificationsEnabled, pushNotificationsEnabled) ||
                other.pushNotificationsEnabled == pushNotificationsEnabled) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, userId, notificationsEnabled,
        emailNotificationsEnabled, pushNotificationsEnabled, themeMode);
  }

  @override
  String toString() {
    return 'AppSettings(userId: $userId, notificationsEnabled: $notificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, pushNotificationsEnabled: $pushNotificationsEnabled, themeMode: $themeMode)';
  }
}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(
          _AppSettings value, $Res Function(_AppSettings) _then) =
      __$AppSettingsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      bool notificationsEnabled,
      bool emailNotificationsEnabled,
      bool pushNotificationsEnabled,
      String themeMode});
}

/// @nodoc
class __$AppSettingsCopyWithImpl<$Res> implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? notificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? pushNotificationsEnabled = null,
    Object? themeMode = null,
  }) {
    return _then(_AppSettings(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _self.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _self.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _self.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
