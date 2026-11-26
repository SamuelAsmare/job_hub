// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationAiReview {
  List<String> get strengths;
  List<String> get weaknesses;
  List<String> get missingInformation;
  List<String> get grammarSuggestions;
  List<String> get improvementRecommendations;

  /// Create a copy of ApplicationAiReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApplicationAiReviewCopyWith<ApplicationAiReview> get copyWith =>
      _$ApplicationAiReviewCopyWithImpl<ApplicationAiReview>(
          this as ApplicationAiReview, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as ApplicationAiReview;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApplicationAiReview &&
            const DeepCollectionEquality()
                .equals(other.strengths, _this.strengths) &&
            const DeepCollectionEquality()
                .equals(other.weaknesses, _this.weaknesses) &&
            const DeepCollectionEquality()
                .equals(other.missingInformation, _this.missingInformation) &&
            const DeepCollectionEquality()
                .equals(other.grammarSuggestions, _this.grammarSuggestions) &&
            const DeepCollectionEquality().equals(
                other.improvementRecommendations,
                _this.improvementRecommendations));
  }

  @override
  int get hashCode {
    final _this = this as ApplicationAiReview;
    return Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_this.strengths),
        const DeepCollectionEquality().hash(_this.weaknesses),
        const DeepCollectionEquality().hash(_this.missingInformation),
        const DeepCollectionEquality().hash(_this.grammarSuggestions),
        const DeepCollectionEquality().hash(_this.improvementRecommendations));
  }

  @override
  String toString() {
    final _this = this as ApplicationAiReview;
    return 'ApplicationAiReview(strengths: ${_this.strengths}, weaknesses: ${_this.weaknesses}, missingInformation: ${_this.missingInformation}, grammarSuggestions: ${_this.grammarSuggestions}, improvementRecommendations: ${_this.improvementRecommendations})';
  }
}

/// @nodoc
abstract mixin class $ApplicationAiReviewCopyWith<$Res> {
  factory $ApplicationAiReviewCopyWith(
          ApplicationAiReview value, $Res Function(ApplicationAiReview) _then) =
      _$ApplicationAiReviewCopyWithImpl;
  @useResult
  $Res call(
      {List<String> strengths,
      List<String> weaknesses,
      List<String> missingInformation,
      List<String> grammarSuggestions,
      List<String> improvementRecommendations});
}

/// @nodoc
class _$ApplicationAiReviewCopyWithImpl<$Res>
    implements $ApplicationAiReviewCopyWith<$Res> {
  _$ApplicationAiReviewCopyWithImpl(this._self, this._then);

  final ApplicationAiReview _self;
  final $Res Function(ApplicationAiReview) _then;

  /// Create a copy of ApplicationAiReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strengths = null,
    Object? weaknesses = null,
    Object? missingInformation = null,
    Object? grammarSuggestions = null,
    Object? improvementRecommendations = null,
  }) {
    return _then(ApplicationAiReview(
      strengths: null == strengths
          ? _self.strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weaknesses: null == weaknesses
          ? _self.weaknesses
          : weaknesses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      missingInformation: null == missingInformation
          ? _self.missingInformation
          : missingInformation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      grammarSuggestions: null == grammarSuggestions
          ? _self.grammarSuggestions
          : grammarSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      improvementRecommendations: null == improvementRecommendations
          ? _self.improvementRecommendations
          : improvementRecommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ApplicationAiReview].
extension ApplicationAiReviewPatterns on ApplicationAiReview {
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
    TResult Function(_ApplicationAiReview value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ApplicationAiReview() when $default != null:
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
    TResult Function(_ApplicationAiReview value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationAiReview():
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
    TResult? Function(_ApplicationAiReview value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationAiReview() when $default != null:
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
            List<String> strengths,
            List<String> weaknesses,
            List<String> missingInformation,
            List<String> grammarSuggestions,
            List<String> improvementRecommendations)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ApplicationAiReview() when $default != null:
        return $default(
            _that.strengths,
            _that.weaknesses,
            _that.missingInformation,
            _that.grammarSuggestions,
            _that.improvementRecommendations);
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
            List<String> strengths,
            List<String> weaknesses,
            List<String> missingInformation,
            List<String> grammarSuggestions,
            List<String> improvementRecommendations)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationAiReview():
        return $default(
            _that.strengths,
            _that.weaknesses,
            _that.missingInformation,
            _that.grammarSuggestions,
            _that.improvementRecommendations);
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
            List<String> strengths,
            List<String> weaknesses,
            List<String> missingInformation,
            List<String> grammarSuggestions,
            List<String> improvementRecommendations)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ApplicationAiReview() when $default != null:
        return $default(
            _that.strengths,
            _that.weaknesses,
            _that.missingInformation,
            _that.grammarSuggestions,
            _that.improvementRecommendations);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ApplicationAiReview implements ApplicationAiReview {
  const _ApplicationAiReview(
      {List<String> strengths = const <String>[],
      List<String> weaknesses = const <String>[],
      List<String> missingInformation = const <String>[],
      List<String> grammarSuggestions = const <String>[],
      List<String> improvementRecommendations = const <String>[]})
      : _strengths = strengths,
        _weaknesses = weaknesses,
        _missingInformation = missingInformation,
        _grammarSuggestions = grammarSuggestions,
        _improvementRecommendations = improvementRecommendations;

  final List<String> _strengths;
  @override
  @JsonKey()
  List<String> get strengths {
    if (_strengths is EqualUnmodifiableListView) return _strengths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strengths);
  }

  final List<String> _weaknesses;
  @override
  @JsonKey()
  List<String> get weaknesses {
    if (_weaknesses is EqualUnmodifiableListView) return _weaknesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weaknesses);
  }

  final List<String> _missingInformation;
  @override
  @JsonKey()
  List<String> get missingInformation {
    if (_missingInformation is EqualUnmodifiableListView)
      return _missingInformation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_missingInformation);
  }

  final List<String> _grammarSuggestions;
  @override
  @JsonKey()
  List<String> get grammarSuggestions {
    if (_grammarSuggestions is EqualUnmodifiableListView)
      return _grammarSuggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grammarSuggestions);
  }

  final List<String> _improvementRecommendations;
  @override
  @JsonKey()
  List<String> get improvementRecommendations {
    if (_improvementRecommendations is EqualUnmodifiableListView)
      return _improvementRecommendations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_improvementRecommendations);
  }

  /// Create a copy of ApplicationAiReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApplicationAiReviewCopyWith<_ApplicationAiReview> get copyWith =>
      __$ApplicationAiReviewCopyWithImpl<_ApplicationAiReview>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ApplicationAiReview &&
            const DeepCollectionEquality()
                .equals(other.strengths, _strengths) &&
            const DeepCollectionEquality()
                .equals(other.weaknesses, _weaknesses) &&
            const DeepCollectionEquality()
                .equals(other.missingInformation, _missingInformation) &&
            const DeepCollectionEquality()
                .equals(other.grammarSuggestions, _grammarSuggestions) &&
            const DeepCollectionEquality().equals(
                other.improvementRecommendations, _improvementRecommendations));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_strengths),
        const DeepCollectionEquality().hash(_weaknesses),
        const DeepCollectionEquality().hash(_missingInformation),
        const DeepCollectionEquality().hash(_grammarSuggestions),
        const DeepCollectionEquality().hash(_improvementRecommendations));
  }

  @override
  String toString() {
    return 'ApplicationAiReview(strengths: $strengths, weaknesses: $weaknesses, missingInformation: $missingInformation, grammarSuggestions: $grammarSuggestions, improvementRecommendations: $improvementRecommendations)';
  }
}

/// @nodoc
abstract mixin class _$ApplicationAiReviewCopyWith<$Res>
    implements $ApplicationAiReviewCopyWith<$Res> {
  factory _$ApplicationAiReviewCopyWith(_ApplicationAiReview value,
          $Res Function(_ApplicationAiReview) _then) =
      __$ApplicationAiReviewCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> strengths,
      List<String> weaknesses,
      List<String> missingInformation,
      List<String> grammarSuggestions,
      List<String> improvementRecommendations});
}

/// @nodoc
class __$ApplicationAiReviewCopyWithImpl<$Res>
    implements _$ApplicationAiReviewCopyWith<$Res> {
  __$ApplicationAiReviewCopyWithImpl(this._self, this._then);

  final _ApplicationAiReview _self;
  final $Res Function(_ApplicationAiReview) _then;

  /// Create a copy of ApplicationAiReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? strengths = null,
    Object? weaknesses = null,
    Object? missingInformation = null,
    Object? grammarSuggestions = null,
    Object? improvementRecommendations = null,
  }) {
    return _then(_ApplicationAiReview(
      strengths: null == strengths
          ? _self._strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weaknesses: null == weaknesses
          ? _self._weaknesses
          : weaknesses // ignore: cast_nullable_to_non_nullable
              as List<String>,
      missingInformation: null == missingInformation
          ? _self._missingInformation
          : missingInformation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      grammarSuggestions: null == grammarSuggestions
          ? _self._grammarSuggestions
          : grammarSuggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      improvementRecommendations: null == improvementRecommendations
          ? _self._improvementRecommendations
          : improvementRecommendations // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
mixin _$Application {
  String get id;
  String get jobId;
  String get jobTitle;
  String get companyName;
  String get applicantId;
  String get cvReference;
  String get cvFileName;
  String get coverLetter;
  DateTime get appliedAt;
  ApplicationStatus get status;
  ApplicationAiReview? get aiReview;
  String? get employerFeedback;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApplicationCopyWith<Application> get copyWith =>
      _$ApplicationCopyWithImpl<Application>(this as Application, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as Application;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Application &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.jobId, _this.jobId) ||
                other.jobId == _this.jobId) &&
            (identical(other.jobTitle, _this.jobTitle) ||
                other.jobTitle == _this.jobTitle) &&
            (identical(other.companyName, _this.companyName) ||
                other.companyName == _this.companyName) &&
            (identical(other.applicantId, _this.applicantId) ||
                other.applicantId == _this.applicantId) &&
            (identical(other.cvReference, _this.cvReference) ||
                other.cvReference == _this.cvReference) &&
            (identical(other.cvFileName, _this.cvFileName) ||
                other.cvFileName == _this.cvFileName) &&
            (identical(other.coverLetter, _this.coverLetter) ||
                other.coverLetter == _this.coverLetter) &&
            (identical(other.appliedAt, _this.appliedAt) ||
                other.appliedAt == _this.appliedAt) &&
            (identical(other.status, _this.status) ||
                other.status == _this.status) &&
            (identical(other.aiReview, _this.aiReview) ||
                other.aiReview == _this.aiReview) &&
            (identical(other.employerFeedback, _this.employerFeedback) ||
                other.employerFeedback == _this.employerFeedback));
  }

  @override
  int get hashCode {
    final _this = this as Application;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.jobId,
        _this.jobTitle,
        _this.companyName,
        _this.applicantId,
        _this.cvReference,
        _this.cvFileName,
        _this.coverLetter,
        _this.appliedAt,
        _this.status,
        _this.aiReview,
        _this.employerFeedback);
  }

  @override
  String toString() {
    final _this = this as Application;
    return 'Application(id: ${_this.id}, jobId: ${_this.jobId}, jobTitle: ${_this.jobTitle}, companyName: ${_this.companyName}, applicantId: ${_this.applicantId}, cvReference: ${_this.cvReference}, cvFileName: ${_this.cvFileName}, coverLetter: ${_this.coverLetter}, appliedAt: ${_this.appliedAt}, status: ${_this.status}, aiReview: ${_this.aiReview}, employerFeedback: ${_this.employerFeedback})';
  }
}

/// @nodoc
abstract mixin class $ApplicationCopyWith<$Res> {
  factory $ApplicationCopyWith(
          Application value, $Res Function(Application) _then) =
      _$ApplicationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String jobId,
      String jobTitle,
      String companyName,
      String applicantId,
      String cvReference,
      String cvFileName,
      String coverLetter,
      DateTime appliedAt,
      ApplicationStatus status,
      ApplicationAiReview? aiReview,
      String? employerFeedback});

  $ApplicationAiReviewCopyWith<$Res>? get aiReview;
}

/// @nodoc
class _$ApplicationCopyWithImpl<$Res> implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._self, this._then);

  final Application _self;
  final $Res Function(Application) _then;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jobId = null,
    Object? jobTitle = null,
    Object? companyName = null,
    Object? applicantId = null,
    Object? cvReference = null,
    Object? cvFileName = null,
    Object? coverLetter = null,
    Object? appliedAt = null,
    Object? status = null,
    Object? aiReview = freezed,
    Object? employerFeedback = freezed,
  }) {
    return _then(Application(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      jobTitle: null == jobTitle
          ? _self.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      applicantId: null == applicantId
          ? _self.applicantId
          : applicantId // ignore: cast_nullable_to_non_nullable
              as String,
      cvReference: null == cvReference
          ? _self.cvReference
          : cvReference // ignore: cast_nullable_to_non_nullable
              as String,
      cvFileName: null == cvFileName
          ? _self.cvFileName
          : cvFileName // ignore: cast_nullable_to_non_nullable
              as String,
      coverLetter: null == coverLetter
          ? _self.coverLetter
          : coverLetter // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _self.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApplicationStatus,
      aiReview: freezed == aiReview
          ? _self.aiReview
          : aiReview // ignore: cast_nullable_to_non_nullable
              as ApplicationAiReview?,
      employerFeedback: freezed == employerFeedback
          ? _self.employerFeedback
          : employerFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApplicationAiReviewCopyWith<$Res>? get aiReview {
    if (_self.aiReview == null) {
      return null;
    }

    return $ApplicationAiReviewCopyWith<$Res>(_self.aiReview!, (value) {
      return _then(_self.copyWith(aiReview: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Application].
extension ApplicationPatterns on Application {
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
    TResult Function(_Application value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Application() when $default != null:
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
    TResult Function(_Application value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Application():
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
    TResult? Function(_Application value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Application() when $default != null:
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
            String jobId,
            String jobTitle,
            String companyName,
            String applicantId,
            String cvReference,
            String cvFileName,
            String coverLetter,
            DateTime appliedAt,
            ApplicationStatus status,
            ApplicationAiReview? aiReview,
            String? employerFeedback)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Application() when $default != null:
        return $default(
            _that.id,
            _that.jobId,
            _that.jobTitle,
            _that.companyName,
            _that.applicantId,
            _that.cvReference,
            _that.cvFileName,
            _that.coverLetter,
            _that.appliedAt,
            _that.status,
            _that.aiReview,
            _that.employerFeedback);
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
            String jobId,
            String jobTitle,
            String companyName,
            String applicantId,
            String cvReference,
            String cvFileName,
            String coverLetter,
            DateTime appliedAt,
            ApplicationStatus status,
            ApplicationAiReview? aiReview,
            String? employerFeedback)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Application():
        return $default(
            _that.id,
            _that.jobId,
            _that.jobTitle,
            _that.companyName,
            _that.applicantId,
            _that.cvReference,
            _that.cvFileName,
            _that.coverLetter,
            _that.appliedAt,
            _that.status,
            _that.aiReview,
            _that.employerFeedback);
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
            String jobId,
            String jobTitle,
            String companyName,
            String applicantId,
            String cvReference,
            String cvFileName,
            String coverLetter,
            DateTime appliedAt,
            ApplicationStatus status,
            ApplicationAiReview? aiReview,
            String? employerFeedback)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Application() when $default != null:
        return $default(
            _that.id,
            _that.jobId,
            _that.jobTitle,
            _that.companyName,
            _that.applicantId,
            _that.cvReference,
            _that.cvFileName,
            _that.coverLetter,
            _that.appliedAt,
            _that.status,
            _that.aiReview,
            _that.employerFeedback);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Application implements Application {
  const _Application(
      {required this.id,
      required this.jobId,
      required this.jobTitle,
      required this.companyName,
      required this.applicantId,
      required this.cvReference,
      required this.cvFileName,
      required this.coverLetter,
      required this.appliedAt,
      this.status = ApplicationStatus.pending,
      this.aiReview,
      this.employerFeedback});

  @override
  final String id;
  @override
  final String jobId;
  @override
  final String jobTitle;
  @override
  final String companyName;
  @override
  final String applicantId;
  @override
  final String cvReference;
  @override
  final String cvFileName;
  @override
  final String coverLetter;
  @override
  final DateTime appliedAt;
  @override
  @JsonKey()
  final ApplicationStatus status;
  @override
  final ApplicationAiReview? aiReview;
  @override
  final String? employerFeedback;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApplicationCopyWith<_Application> get copyWith =>
      __$ApplicationCopyWithImpl<_Application>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Application &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jobId, jobId) || other.jobId == jobId) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.applicantId, applicantId) ||
                other.applicantId == applicantId) &&
            (identical(other.cvReference, cvReference) ||
                other.cvReference == cvReference) &&
            (identical(other.cvFileName, cvFileName) ||
                other.cvFileName == cvFileName) &&
            (identical(other.coverLetter, coverLetter) ||
                other.coverLetter == coverLetter) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.aiReview, aiReview) ||
                other.aiReview == aiReview) &&
            (identical(other.employerFeedback, employerFeedback) ||
                other.employerFeedback == employerFeedback));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        jobId,
        jobTitle,
        companyName,
        applicantId,
        cvReference,
        cvFileName,
        coverLetter,
        appliedAt,
        status,
        aiReview,
        employerFeedback);
  }

  @override
  String toString() {
    return 'Application(id: $id, jobId: $jobId, jobTitle: $jobTitle, companyName: $companyName, applicantId: $applicantId, cvReference: $cvReference, cvFileName: $cvFileName, coverLetter: $coverLetter, appliedAt: $appliedAt, status: $status, aiReview: $aiReview, employerFeedback: $employerFeedback)';
  }
}

/// @nodoc
abstract mixin class _$ApplicationCopyWith<$Res>
    implements $ApplicationCopyWith<$Res> {
  factory _$ApplicationCopyWith(
          _Application value, $Res Function(_Application) _then) =
      __$ApplicationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String jobId,
      String jobTitle,
      String companyName,
      String applicantId,
      String cvReference,
      String cvFileName,
      String coverLetter,
      DateTime appliedAt,
      ApplicationStatus status,
      ApplicationAiReview? aiReview,
      String? employerFeedback});

  @override
  $ApplicationAiReviewCopyWith<$Res>? get aiReview;
}

/// @nodoc
class __$ApplicationCopyWithImpl<$Res> implements _$ApplicationCopyWith<$Res> {
  __$ApplicationCopyWithImpl(this._self, this._then);

  final _Application _self;
  final $Res Function(_Application) _then;

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? jobId = null,
    Object? jobTitle = null,
    Object? companyName = null,
    Object? applicantId = null,
    Object? cvReference = null,
    Object? cvFileName = null,
    Object? coverLetter = null,
    Object? appliedAt = null,
    Object? status = null,
    Object? aiReview = freezed,
    Object? employerFeedback = freezed,
  }) {
    return _then(_Application(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      jobId: null == jobId
          ? _self.jobId
          : jobId // ignore: cast_nullable_to_non_nullable
              as String,
      jobTitle: null == jobTitle
          ? _self.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      applicantId: null == applicantId
          ? _self.applicantId
          : applicantId // ignore: cast_nullable_to_non_nullable
              as String,
      cvReference: null == cvReference
          ? _self.cvReference
          : cvReference // ignore: cast_nullable_to_non_nullable
              as String,
      cvFileName: null == cvFileName
          ? _self.cvFileName
          : cvFileName // ignore: cast_nullable_to_non_nullable
              as String,
      coverLetter: null == coverLetter
          ? _self.coverLetter
          : coverLetter // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _self.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApplicationStatus,
      aiReview: freezed == aiReview
          ? _self.aiReview
          : aiReview // ignore: cast_nullable_to_non_nullable
              as ApplicationAiReview?,
      employerFeedback: freezed == employerFeedback
          ? _self.employerFeedback
          : employerFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Application
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApplicationAiReviewCopyWith<$Res>? get aiReview {
    if (_self.aiReview == null) {
      return null;
    }

    return $ApplicationAiReviewCopyWith<$Res>(_self.aiReview!, (value) {
      return _then(_self.copyWith(aiReview: value));
    });
  }
}

// dart format on
