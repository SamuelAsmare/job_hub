// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Job {
  String get id;
  String get title;
  String get companyName;
  String? get companyLogo;
  String get location;
  String get description;
  List<String> get requirements;
  String get employmentType;
  String? get salary;
  DateTime get postedAt;
  DateTime? get deadline;
  String get employerId;
  double? get latitude;
  double? get longitude;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JobCopyWith<Job> get copyWith =>
      _$JobCopyWithImpl<Job>(this as Job, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as Job;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Job &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.title, _this.title) ||
                other.title == _this.title) &&
            (identical(other.companyName, _this.companyName) ||
                other.companyName == _this.companyName) &&
            (identical(other.companyLogo, _this.companyLogo) ||
                other.companyLogo == _this.companyLogo) &&
            (identical(other.location, _this.location) ||
                other.location == _this.location) &&
            (identical(other.description, _this.description) ||
                other.description == _this.description) &&
            const DeepCollectionEquality()
                .equals(other.requirements, _this.requirements) &&
            (identical(other.employmentType, _this.employmentType) ||
                other.employmentType == _this.employmentType) &&
            (identical(other.salary, _this.salary) ||
                other.salary == _this.salary) &&
            (identical(other.postedAt, _this.postedAt) ||
                other.postedAt == _this.postedAt) &&
            (identical(other.deadline, _this.deadline) ||
                other.deadline == _this.deadline) &&
            (identical(other.employerId, _this.employerId) ||
                other.employerId == _this.employerId) &&
            (identical(other.latitude, _this.latitude) ||
                other.latitude == _this.latitude) &&
            (identical(other.longitude, _this.longitude) ||
                other.longitude == _this.longitude));
  }

  @override
  int get hashCode {
    final _this = this as Job;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.title,
        _this.companyName,
        _this.companyLogo,
        _this.location,
        _this.description,
        const DeepCollectionEquality().hash(_this.requirements),
        _this.employmentType,
        _this.salary,
        _this.postedAt,
        _this.deadline,
        _this.employerId,
        _this.latitude,
        _this.longitude);
  }

  @override
  String toString() {
    final _this = this as Job;
    return 'Job(id: ${_this.id}, title: ${_this.title}, companyName: ${_this.companyName}, companyLogo: ${_this.companyLogo}, location: ${_this.location}, description: ${_this.description}, requirements: ${_this.requirements}, employmentType: ${_this.employmentType}, salary: ${_this.salary}, postedAt: ${_this.postedAt}, deadline: ${_this.deadline}, employerId: ${_this.employerId}, latitude: ${_this.latitude}, longitude: ${_this.longitude})';
  }
}

/// @nodoc
abstract mixin class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String companyName,
      String? companyLogo,
      String location,
      String description,
      List<String> requirements,
      String employmentType,
      String? salary,
      DateTime postedAt,
      DateTime? deadline,
      String employerId,
      double? latitude,
      double? longitude});
}

/// @nodoc
class _$JobCopyWithImpl<$Res> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? companyName = null,
    Object? companyLogo = freezed,
    Object? location = null,
    Object? description = null,
    Object? requirements = null,
    Object? employmentType = null,
    Object? salary = freezed,
    Object? postedAt = null,
    Object? deadline = freezed,
    Object? employerId = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(Job(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      companyLogo: freezed == companyLogo
          ? _self.companyLogo
          : companyLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _self.requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      employmentType: null == employmentType
          ? _self.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as String,
      salary: freezed == salary
          ? _self.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as String?,
      postedAt: null == postedAt
          ? _self.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deadline: freezed == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      employerId: null == employerId
          ? _self.employerId
          : employerId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Job].
extension JobPatterns on Job {
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
    TResult Function(_Job value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Job() when $default != null:
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
    TResult Function(_Job value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Job():
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
    TResult? Function(_Job value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Job() when $default != null:
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
            String id,
            String title,
            String companyName,
            String? companyLogo,
            String location,
            String description,
            List<String> requirements,
            String employmentType,
            String? salary,
            DateTime postedAt,
            DateTime? deadline,
            String employerId,
            double? latitude,
            double? longitude)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Job() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.companyName,
            _that.companyLogo,
            _that.location,
            _that.description,
            _that.requirements,
            _that.employmentType,
            _that.salary,
            _that.postedAt,
            _that.deadline,
            _that.employerId,
            _that.latitude,
            _that.longitude);
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
            String id,
            String title,
            String companyName,
            String? companyLogo,
            String location,
            String description,
            List<String> requirements,
            String employmentType,
            String? salary,
            DateTime postedAt,
            DateTime? deadline,
            String employerId,
            double? latitude,
            double? longitude)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Job():
        return $default(
            _that.id,
            _that.title,
            _that.companyName,
            _that.companyLogo,
            _that.location,
            _that.description,
            _that.requirements,
            _that.employmentType,
            _that.salary,
            _that.postedAt,
            _that.deadline,
            _that.employerId,
            _that.latitude,
            _that.longitude);
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
            String id,
            String title,
            String companyName,
            String? companyLogo,
            String location,
            String description,
            List<String> requirements,
            String employmentType,
            String? salary,
            DateTime postedAt,
            DateTime? deadline,
            String employerId,
            double? latitude,
            double? longitude)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Job() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.companyName,
            _that.companyLogo,
            _that.location,
            _that.description,
            _that.requirements,
            _that.employmentType,
            _that.salary,
            _that.postedAt,
            _that.deadline,
            _that.employerId,
            _that.latitude,
            _that.longitude);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Job implements Job {
  const _Job(
      {required this.id,
      required this.title,
      required this.companyName,
      this.companyLogo,
      required this.location,
      required this.description,
      required List<String> requirements,
      required this.employmentType,
      this.salary,
      required this.postedAt,
      this.deadline,
      required this.employerId,
      this.latitude,
      this.longitude})
      : _requirements = requirements;

  @override
  final String id;
  @override
  final String title;
  @override
  final String companyName;
  @override
  final String? companyLogo;
  @override
  final String location;
  @override
  final String description;
  final List<String> _requirements;
  @override
  List<String> get requirements {
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requirements);
  }

  @override
  final String employmentType;
  @override
  final String? salary;
  @override
  final DateTime postedAt;
  @override
  final DateTime? deadline;
  @override
  final String employerId;
  @override
  final double? latitude;
  @override
  final double? longitude;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JobCopyWith<_Job> get copyWith =>
      __$JobCopyWithImpl<_Job>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Job &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.companyLogo, companyLogo) ||
                other.companyLogo == companyLogo) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.requirements, _requirements) &&
            (identical(other.employmentType, employmentType) ||
                other.employmentType == employmentType) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.postedAt, postedAt) ||
                other.postedAt == postedAt) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.employerId, employerId) ||
                other.employerId == employerId) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        title,
        companyName,
        companyLogo,
        location,
        description,
        const DeepCollectionEquality().hash(_requirements),
        employmentType,
        salary,
        postedAt,
        deadline,
        employerId,
        latitude,
        longitude);
  }

  @override
  String toString() {
    return 'Job(id: $id, title: $title, companyName: $companyName, companyLogo: $companyLogo, location: $location, description: $description, requirements: $requirements, employmentType: $employmentType, salary: $salary, postedAt: $postedAt, deadline: $deadline, employerId: $employerId, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) =
      __$JobCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String companyName,
      String? companyLogo,
      String location,
      String description,
      List<String> requirements,
      String employmentType,
      String? salary,
      DateTime postedAt,
      DateTime? deadline,
      String employerId,
      double? latitude,
      double? longitude});
}

/// @nodoc
class __$JobCopyWithImpl<$Res> implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? companyName = null,
    Object? companyLogo = freezed,
    Object? location = null,
    Object? description = null,
    Object? requirements = null,
    Object? employmentType = null,
    Object? salary = freezed,
    Object? postedAt = null,
    Object? deadline = freezed,
    Object? employerId = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_Job(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      companyLogo: freezed == companyLogo
          ? _self.companyLogo
          : companyLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      requirements: null == requirements
          ? _self._requirements
          : requirements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      employmentType: null == employmentType
          ? _self.employmentType
          : employmentType // ignore: cast_nullable_to_non_nullable
              as String,
      salary: freezed == salary
          ? _self.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as String?,
      postedAt: null == postedAt
          ? _self.postedAt
          : postedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deadline: freezed == deadline
          ? _self.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      employerId: null == employerId
          ? _self.employerId
          : employerId // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
