// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employer_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmployerProfile {
  String get employerId;
  String get companyName;
  String get industry;
  String get description;
  String? get location;
  String? get website;
  String? get phone;
  String? get logoUrl;

  /// Create a copy of EmployerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EmployerProfileCopyWith<EmployerProfile> get copyWith =>
      _$EmployerProfileCopyWithImpl<EmployerProfile>(
          this as EmployerProfile, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as EmployerProfile;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmployerProfile &&
            (identical(other.employerId, _this.employerId) ||
                other.employerId == _this.employerId) &&
            (identical(other.companyName, _this.companyName) ||
                other.companyName == _this.companyName) &&
            (identical(other.industry, _this.industry) ||
                other.industry == _this.industry) &&
            (identical(other.description, _this.description) ||
                other.description == _this.description) &&
            (identical(other.location, _this.location) ||
                other.location == _this.location) &&
            (identical(other.website, _this.website) ||
                other.website == _this.website) &&
            (identical(other.phone, _this.phone) ||
                other.phone == _this.phone) &&
            (identical(other.logoUrl, _this.logoUrl) ||
                other.logoUrl == _this.logoUrl));
  }

  @override
  int get hashCode {
    final _this = this as EmployerProfile;
    return Object.hash(
        runtimeType,
        _this.employerId,
        _this.companyName,
        _this.industry,
        _this.description,
        _this.location,
        _this.website,
        _this.phone,
        _this.logoUrl);
  }

  @override
  String toString() {
    final _this = this as EmployerProfile;
    return 'EmployerProfile(employerId: ${_this.employerId}, companyName: ${_this.companyName}, industry: ${_this.industry}, description: ${_this.description}, location: ${_this.location}, website: ${_this.website}, phone: ${_this.phone}, logoUrl: ${_this.logoUrl})';
  }
}

/// @nodoc
abstract mixin class $EmployerProfileCopyWith<$Res> {
  factory $EmployerProfileCopyWith(
          EmployerProfile value, $Res Function(EmployerProfile) _then) =
      _$EmployerProfileCopyWithImpl;
  @useResult
  $Res call(
      {String employerId,
      String companyName,
      String industry,
      String description,
      String? location,
      String? website,
      String? phone,
      String? logoUrl});
}

/// @nodoc
class _$EmployerProfileCopyWithImpl<$Res>
    implements $EmployerProfileCopyWith<$Res> {
  _$EmployerProfileCopyWithImpl(this._self, this._then);

  final EmployerProfile _self;
  final $Res Function(EmployerProfile) _then;

  /// Create a copy of EmployerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employerId = null,
    Object? companyName = null,
    Object? industry = null,
    Object? description = null,
    Object? location = freezed,
    Object? website = freezed,
    Object? phone = freezed,
    Object? logoUrl = freezed,
  }) {
    return _then(EmployerProfile(
      employerId: null == employerId
          ? _self.employerId
          : employerId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _self.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _self.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EmployerProfile].
extension EmployerProfilePatterns on EmployerProfile {
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
    TResult Function(_EmployerProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployerProfile() when $default != null:
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
    TResult Function(_EmployerProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployerProfile():
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
    TResult? Function(_EmployerProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployerProfile() when $default != null:
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
            String employerId,
            String companyName,
            String industry,
            String description,
            String? location,
            String? website,
            String? phone,
            String? logoUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EmployerProfile() when $default != null:
        return $default(
            _that.employerId,
            _that.companyName,
            _that.industry,
            _that.description,
            _that.location,
            _that.website,
            _that.phone,
            _that.logoUrl);
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
            String employerId,
            String companyName,
            String industry,
            String description,
            String? location,
            String? website,
            String? phone,
            String? logoUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployerProfile():
        return $default(
            _that.employerId,
            _that.companyName,
            _that.industry,
            _that.description,
            _that.location,
            _that.website,
            _that.phone,
            _that.logoUrl);
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
            String employerId,
            String companyName,
            String industry,
            String description,
            String? location,
            String? website,
            String? phone,
            String? logoUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EmployerProfile() when $default != null:
        return $default(
            _that.employerId,
            _that.companyName,
            _that.industry,
            _that.description,
            _that.location,
            _that.website,
            _that.phone,
            _that.logoUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EmployerProfile implements EmployerProfile {
  const _EmployerProfile(
      {required this.employerId,
      required this.companyName,
      required this.industry,
      required this.description,
      this.location,
      this.website,
      this.phone,
      this.logoUrl});

  @override
  final String employerId;
  @override
  final String companyName;
  @override
  final String industry;
  @override
  final String description;
  @override
  final String? location;
  @override
  final String? website;
  @override
  final String? phone;
  @override
  final String? logoUrl;

  /// Create a copy of EmployerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmployerProfileCopyWith<_EmployerProfile> get copyWith =>
      __$EmployerProfileCopyWithImpl<_EmployerProfile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmployerProfile &&
            (identical(other.employerId, employerId) ||
                other.employerId == employerId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, employerId, companyName, industry,
        description, location, website, phone, logoUrl);
  }

  @override
  String toString() {
    return 'EmployerProfile(employerId: $employerId, companyName: $companyName, industry: $industry, description: $description, location: $location, website: $website, phone: $phone, logoUrl: $logoUrl)';
  }
}

/// @nodoc
abstract mixin class _$EmployerProfileCopyWith<$Res>
    implements $EmployerProfileCopyWith<$Res> {
  factory _$EmployerProfileCopyWith(
          _EmployerProfile value, $Res Function(_EmployerProfile) _then) =
      __$EmployerProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String employerId,
      String companyName,
      String industry,
      String description,
      String? location,
      String? website,
      String? phone,
      String? logoUrl});
}

/// @nodoc
class __$EmployerProfileCopyWithImpl<$Res>
    implements _$EmployerProfileCopyWith<$Res> {
  __$EmployerProfileCopyWithImpl(this._self, this._then);

  final _EmployerProfile _self;
  final $Res Function(_EmployerProfile) _then;

  /// Create a copy of EmployerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? employerId = null,
    Object? companyName = null,
    Object? industry = null,
    Object? description = null,
    Object? location = freezed,
    Object? website = freezed,
    Object? phone = freezed,
    Object? logoUrl = freezed,
  }) {
    return _then(_EmployerProfile(
      employerId: null == employerId
          ? _self.employerId
          : employerId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _self.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _self.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
