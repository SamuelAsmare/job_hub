// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedJob {
  String get id;
  String get userId;
  String get jobId;
  DateTime get savedAt;

  /// Create a copy of SavedJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedJobCopyWith<SavedJob> get copyWith =>
      _$SavedJobCopyWithImpl<SavedJob>(this as SavedJob, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as SavedJob;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedJob &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.userId, _this.userId) ||
                other.userId == _this.userId) &&
            (identical(other.jobId, _this.jobId) ||
                other.jobId == _this.jobId) &&
            (identical(other.savedAt, _this.savedAt) ||
                other.savedAt == _this.savedAt));
  }

  @override
  int get hashCode {
    final _this = this as SavedJob;
    return Object.hash(
        runtimeType, _this.id, _this.userId, _this.jobId, _this.savedAt);
  }

  @override
  String toString() {
    final _this = this as SavedJob;
    return 'SavedJob(id: ${_this.id}, userId: ${_this.userId}, jobId: ${_this.jobId}, savedAt: ${_this.savedAt})';
  }
}

/// @nodoc
abstract mixin class $SavedJobCopyWith<$Res> {
  factory $SavedJobCopyWith(SavedJob value, $Res Function(SavedJob) _then) =
      _$SavedJobCopyWithImpl;
  @useResult
  $Res call({String id, String userId, String jobId, DateTime savedAt});
}

/// @nodoc
class _$SavedJobCopyWithImpl<$Res> implements $SavedJobCopyWith<$Res> {
  _$SavedJobCopyWithImpl(this._self, this._then);

  final SavedJob _self;
  final $Res Function(SavedJob) _then;

  /// Create a copy of SavedJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? jobId = null,
    Object? savedAt = null,
  }) {
    return _then(SavedJob(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedJob].
extension SavedJobPatterns on SavedJob {
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
    TResult Function(_SavedJob value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedJob() when $default != null:
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
    TResult Function(_SavedJob value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedJob():
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
    TResult? Function(_SavedJob value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedJob() when $default != null:
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
    TResult Function(String id, String userId, String jobId, DateTime savedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedJob() when $default != null:
        return $default(_that.id, _that.userId, _that.jobId, _that.savedAt);
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
    TResult Function(String id, String userId, String jobId, DateTime savedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedJob():
        return $default(_that.id, _that.userId, _that.jobId, _that.savedAt);
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
    TResult? Function(String id, String userId, String jobId, DateTime savedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedJob() when $default != null:
        return $default(_that.id, _that.userId, _that.jobId, _that.savedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SavedJob implements SavedJob {
  const _SavedJob(
      {required this.id,
      required this.userId,
      required this.jobId,
      required this.savedAt});

  @override
  final String id;
  @override
  final String userId;
  @override
  final String jobId;
  @override
  final DateTime savedAt;

  /// Create a copy of SavedJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedJobCopyWith<_SavedJob> get copyWith =>
      __$SavedJobCopyWithImpl<_SavedJob>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedJob &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, userId, jobId, savedAt);
  }

  @override
  String toString() {
    return 'SavedJob(id: $id, userId: $userId, jobId: $jobId, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class _$SavedJobCopyWith<$Res>
    implements $SavedJobCopyWith<$Res> {
  factory _$SavedJobCopyWith(_SavedJob value, $Res Function(_SavedJob) _then) =
      __$SavedJobCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String userId, String jobId, DateTime savedAt});
}

/// @nodoc
class __$SavedJobCopyWithImpl<$Res> implements _$SavedJobCopyWith<$Res> {
  __$SavedJobCopyWithImpl(this._self, this._then);

  final _SavedJob _self;
  final $Res Function(_SavedJob) _then;

  /// Create a copy of SavedJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? jobId = null,
    Object? savedAt = null,
  }) {
    return _then(_SavedJob(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      savedAt: null == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
