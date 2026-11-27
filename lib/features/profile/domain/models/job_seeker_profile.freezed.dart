// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_seeker_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobSeekerProfile {
  String get userId;
  String? get phone;
  String? get bio;
  List<String> get skills;
  List<String> get education;
  List<String> get experience;
  String? get cvUrl;

  /// Create a copy of JobSeekerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JobSeekerProfileCopyWith<JobSeekerProfile> get copyWith =>
      _$JobSeekerProfileCopyWithImpl<JobSeekerProfile>(
          this as JobSeekerProfile, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as JobSeekerProfile;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JobSeekerProfile &&
            (identical(other.userId, _this.userId) ||
                other.userId == _this.userId) &&
            (identical(other.phone, _this.phone) ||
                other.phone == _this.phone) &&
            (identical(other.bio, _this.bio) || other.bio == _this.bio) &&
            const DeepCollectionEquality().equals(other.skills, _this.skills) &&
            const DeepCollectionEquality()
                .equals(other.education, _this.education) &&
            const DeepCollectionEquality()
                .equals(other.experience, _this.experience) &&
            (identical(other.cvUrl, _this.cvUrl) ||
                other.cvUrl == _this.cvUrl));
  }

  @override
  int get hashCode {
    final _this = this as JobSeekerProfile;
    return Object.hash(
        runtimeType,
        _this.userId,
        _this.phone,
        _this.bio,
        const DeepCollectionEquality().hash(_this.skills),
        const DeepCollectionEquality().hash(_this.education),
        const DeepCollectionEquality().hash(_this.experience),
        _this.cvUrl);
  }

  @override
  String toString() {
    final _this = this as JobSeekerProfile;
    return 'JobSeekerProfile(userId: ${_this.userId}, phone: ${_this.phone}, bio: ${_this.bio}, skills: ${_this.skills}, education: ${_this.education}, experience: ${_this.experience}, cvUrl: ${_this.cvUrl})';
  }
}

/// @nodoc
abstract mixin class $JobSeekerProfileCopyWith<$Res> {
  factory $JobSeekerProfileCopyWith(
          JobSeekerProfile value, $Res Function(JobSeekerProfile) _then) =
      _$JobSeekerProfileCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String? phone,
      String? bio,
      List<String> skills,
      List<String> education,
      List<String> experience,
      String? cvUrl});
}

/// @nodoc
class _$JobSeekerProfileCopyWithImpl<$Res>
    implements $JobSeekerProfileCopyWith<$Res> {
  _$JobSeekerProfileCopyWithImpl(this._self, this._then);

  final JobSeekerProfile _self;
  final $Res Function(JobSeekerProfile) _then;

  /// Create a copy of JobSeekerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? phone = freezed,
    Object? bio = freezed,
    Object? skills = null,
    Object? education = null,
    Object? experience = null,
    Object? cvUrl = freezed,
  }) {
    return _then(JobSeekerProfile(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: null == skills
          ? _self.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      education: null == education
          ? _self.education
          : education // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experience: null == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cvUrl: freezed == cvUrl
          ? _self.cvUrl
          : cvUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [JobSeekerProfile].
extension JobSeekerProfilePatterns on JobSeekerProfile {
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
    TResult Function(_JobSeekerProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JobSeekerProfile() when $default != null:
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
    TResult Function(_JobSeekerProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobSeekerProfile():
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
    TResult? Function(_JobSeekerProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobSeekerProfile() when $default != null:
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
            String? phone,
            String? bio,
            List<String> skills,
            List<String> education,
            List<String> experience,
            String? cvUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _JobSeekerProfile() when $default != null:
        return $default(_that.userId, _that.phone, _that.bio, _that.skills,
            _that.education, _that.experience, _that.cvUrl);
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
            String? phone,
            String? bio,
            List<String> skills,
            List<String> education,
            List<String> experience,
            String? cvUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobSeekerProfile():
        return $default(_that.userId, _that.phone, _that.bio, _that.skills,
            _that.education, _that.experience, _that.cvUrl);
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
            String? phone,
            String? bio,
            List<String> skills,
            List<String> education,
            List<String> experience,
            String? cvUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _JobSeekerProfile() when $default != null:
        return $default(_that.userId, _that.phone, _that.bio, _that.skills,
            _that.education, _that.experience, _that.cvUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _JobSeekerProfile implements JobSeekerProfile {
  const _JobSeekerProfile(
      {required this.userId,
      this.phone,
      this.bio,
      List<String> skills = const <String>[],
      List<String> education = const <String>[],
      List<String> experience = const <String>[],
      this.cvUrl})
      : _skills = skills,
        _education = education,
        _experience = experience;

  @override
  final String userId;
  @override
  final String? phone;
  @override
  final String? bio;
  final List<String> _skills;
  @override
  @JsonKey()
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<String> _education;
  @override
  @JsonKey()
  List<String> get education {
    if (_education is EqualUnmodifiableListView) return _education;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_education);
  }

  final List<String> _experience;
  @override
  @JsonKey()
  List<String> get experience {
    if (_experience is EqualUnmodifiableListView) return _experience;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_experience);
  }

  @override
  final String? cvUrl;

  /// Create a copy of JobSeekerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JobSeekerProfileCopyWith<_JobSeekerProfile> get copyWith =>
      __$JobSeekerProfileCopyWithImpl<_JobSeekerProfile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JobSeekerProfile &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other.skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other.education, _education) &&
            const DeepCollectionEquality()
                .equals(other.experience, _experience) &&
            (identical(other.cvUrl, cvUrl) || other.cvUrl == cvUrl));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        userId,
        phone,
        bio,
        const DeepCollectionEquality().hash(_skills),
        const DeepCollectionEquality().hash(_education),
        const DeepCollectionEquality().hash(_experience),
        cvUrl);
  }

  @override
  String toString() {
    return 'JobSeekerProfile(userId: $userId, phone: $phone, bio: $bio, skills: $skills, education: $education, experience: $experience, cvUrl: $cvUrl)';
  }
}

/// @nodoc
abstract mixin class _$JobSeekerProfileCopyWith<$Res>
    implements $JobSeekerProfileCopyWith<$Res> {
  factory _$JobSeekerProfileCopyWith(
          _JobSeekerProfile value, $Res Function(_JobSeekerProfile) _then) =
      __$JobSeekerProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      String? phone,
      String? bio,
      List<String> skills,
      List<String> education,
      List<String> experience,
      String? cvUrl});
}

/// @nodoc
class __$JobSeekerProfileCopyWithImpl<$Res>
    implements _$JobSeekerProfileCopyWith<$Res> {
  __$JobSeekerProfileCopyWithImpl(this._self, this._then);

  final _JobSeekerProfile _self;
  final $Res Function(_JobSeekerProfile) _then;

  /// Create a copy of JobSeekerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? phone = freezed,
    Object? bio = freezed,
    Object? skills = null,
    Object? education = null,
    Object? experience = null,
    Object? cvUrl = freezed,
  }) {
    return _then(_JobSeekerProfile(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: null == skills
          ? _self._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      education: null == education
          ? _self._education
          : education // ignore: cast_nullable_to_non_nullable
              as List<String>,
      experience: null == experience
          ? _self._experience
          : experience // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cvUrl: freezed == cvUrl
          ? _self.cvUrl
          : cvUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
