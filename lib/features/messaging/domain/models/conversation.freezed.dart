// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Conversation {
  String get id;
  String get participantOneId;
  String get participantTwoId;
  String get participantOneName;
  String get participantTwoName;
  String? get participantOnePhoto;
  String? get participantTwoPhoto;
  String? get lastMessage;
  DateTime? get lastMessageAt;
  int get unreadCount;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<Conversation> get copyWith =>
      _$ConversationCopyWithImpl<Conversation>(
          this as Conversation, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as Conversation;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Conversation &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.participantOneId, _this.participantOneId) ||
                other.participantOneId == _this.participantOneId) &&
            (identical(other.participantTwoId, _this.participantTwoId) ||
                other.participantTwoId == _this.participantTwoId) &&
            (identical(other.participantOneName, _this.participantOneName) ||
                other.participantOneName == _this.participantOneName) &&
            (identical(other.participantTwoName, _this.participantTwoName) ||
                other.participantTwoName == _this.participantTwoName) &&
            (identical(other.participantOnePhoto, _this.participantOnePhoto) ||
                other.participantOnePhoto == _this.participantOnePhoto) &&
            (identical(other.participantTwoPhoto, _this.participantTwoPhoto) ||
                other.participantTwoPhoto == _this.participantTwoPhoto) &&
            (identical(other.lastMessage, _this.lastMessage) ||
                other.lastMessage == _this.lastMessage) &&
            (identical(other.lastMessageAt, _this.lastMessageAt) ||
                other.lastMessageAt == _this.lastMessageAt) &&
            (identical(other.unreadCount, _this.unreadCount) ||
                other.unreadCount == _this.unreadCount));
  }

  @override
  int get hashCode {
    final _this = this as Conversation;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.participantOneId,
        _this.participantTwoId,
        _this.participantOneName,
        _this.participantTwoName,
        _this.participantOnePhoto,
        _this.participantTwoPhoto,
        _this.lastMessage,
        _this.lastMessageAt,
        _this.unreadCount);
  }

  @override
  String toString() {
    final _this = this as Conversation;
    return 'Conversation(id: ${_this.id}, participantOneId: ${_this.participantOneId}, participantTwoId: ${_this.participantTwoId}, participantOneName: ${_this.participantOneName}, participantTwoName: ${_this.participantTwoName}, participantOnePhoto: ${_this.participantOnePhoto}, participantTwoPhoto: ${_this.participantTwoPhoto}, lastMessage: ${_this.lastMessage}, lastMessageAt: ${_this.lastMessageAt}, unreadCount: ${_this.unreadCount})';
  }
}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) _then) =
      _$ConversationCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String participantOneId,
      String participantTwoId,
      String participantOneName,
      String participantTwoName,
      String? participantOnePhoto,
      String? participantTwoPhoto,
      String? lastMessage,
      DateTime? lastMessageAt,
      int unreadCount});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? participantOneId = null,
    Object? participantTwoId = null,
    Object? participantOneName = null,
    Object? participantTwoName = null,
    Object? participantOnePhoto = freezed,
    Object? participantTwoPhoto = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = null,
  }) {
    return _then(Conversation(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      participantOneId: null == participantOneId
          ? _self.participantOneId
          : participantOneId // ignore: cast_nullable_to_non_nullable
              as String,
      participantTwoId: null == participantTwoId
          ? _self.participantTwoId
          : participantTwoId // ignore: cast_nullable_to_non_nullable
              as String,
      participantOneName: null == participantOneName
          ? _self.participantOneName
          : participantOneName // ignore: cast_nullable_to_non_nullable
              as String,
      participantTwoName: null == participantTwoName
          ? _self.participantTwoName
          : participantTwoName // ignore: cast_nullable_to_non_nullable
              as String,
      participantOnePhoto: freezed == participantOnePhoto
          ? _self.participantOnePhoto
          : participantOnePhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      participantTwoPhoto: freezed == participantTwoPhoto
          ? _self.participantTwoPhoto
          : participantTwoPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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
    TResult Function(_Conversation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
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
    TResult Function(_Conversation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation():
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
    TResult? Function(_Conversation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
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
            String participantOneId,
            String participantTwoId,
            String participantOneName,
            String participantTwoName,
            String? participantOnePhoto,
            String? participantTwoPhoto,
            String? lastMessage,
            DateTime? lastMessageAt,
            int unreadCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(
            _that.id,
            _that.participantOneId,
            _that.participantTwoId,
            _that.participantOneName,
            _that.participantTwoName,
            _that.participantOnePhoto,
            _that.participantTwoPhoto,
            _that.lastMessage,
            _that.lastMessageAt,
            _that.unreadCount);
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
            String participantOneId,
            String participantTwoId,
            String participantOneName,
            String participantTwoName,
            String? participantOnePhoto,
            String? participantTwoPhoto,
            String? lastMessage,
            DateTime? lastMessageAt,
            int unreadCount)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation():
        return $default(
            _that.id,
            _that.participantOneId,
            _that.participantTwoId,
            _that.participantOneName,
            _that.participantTwoName,
            _that.participantOnePhoto,
            _that.participantTwoPhoto,
            _that.lastMessage,
            _that.lastMessageAt,
            _that.unreadCount);
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
            String participantOneId,
            String participantTwoId,
            String participantOneName,
            String participantTwoName,
            String? participantOnePhoto,
            String? participantTwoPhoto,
            String? lastMessage,
            DateTime? lastMessageAt,
            int unreadCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(
            _that.id,
            _that.participantOneId,
            _that.participantTwoId,
            _that.participantOneName,
            _that.participantTwoName,
            _that.participantOnePhoto,
            _that.participantTwoPhoto,
            _that.lastMessage,
            _that.lastMessageAt,
            _that.unreadCount);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Conversation implements Conversation {
  const _Conversation(
      {required this.id,
      required this.participantOneId,
      required this.participantTwoId,
      required this.participantOneName,
      required this.participantTwoName,
      this.participantOnePhoto,
      this.participantTwoPhoto,
      this.lastMessage,
      this.lastMessageAt,
      this.unreadCount = 0});

  @override
  final String id;
  @override
  final String participantOneId;
  @override
  final String participantTwoId;
  @override
  final String participantOneName;
  @override
  final String participantTwoName;
  @override
  final String? participantOnePhoto;
  @override
  final String? participantTwoPhoto;
  @override
  final String? lastMessage;
  @override
  final DateTime? lastMessageAt;
  @override
  @JsonKey()
  final int unreadCount;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationCopyWith<_Conversation> get copyWith =>
      __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Conversation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.participantOneId, participantOneId) ||
                other.participantOneId == participantOneId) &&
            (identical(other.participantTwoId, participantTwoId) ||
                other.participantTwoId == participantTwoId) &&
            (identical(other.participantOneName, participantOneName) ||
                other.participantOneName == participantOneName) &&
            (identical(other.participantTwoName, participantTwoName) ||
                other.participantTwoName == participantTwoName) &&
            (identical(other.participantOnePhoto, participantOnePhoto) ||
                other.participantOnePhoto == participantOnePhoto) &&
            (identical(other.participantTwoPhoto, participantTwoPhoto) ||
                other.participantTwoPhoto == participantTwoPhoto) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        participantOneId,
        participantTwoId,
        participantOneName,
        participantTwoName,
        participantOnePhoto,
        participantTwoPhoto,
        lastMessage,
        lastMessageAt,
        unreadCount);
  }

  @override
  String toString() {
    return 'Conversation(id: $id, participantOneId: $participantOneId, participantTwoId: $participantTwoId, participantOneName: $participantOneName, participantTwoName: $participantTwoName, participantOnePhoto: $participantOnePhoto, participantTwoPhoto: $participantTwoPhoto, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(
          _Conversation value, $Res Function(_Conversation) _then) =
      __$ConversationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String participantOneId,
      String participantTwoId,
      String participantOneName,
      String participantTwoName,
      String? participantOnePhoto,
      String? participantTwoPhoto,
      String? lastMessage,
      DateTime? lastMessageAt,
      int unreadCount});
}

/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? participantOneId = null,
    Object? participantTwoId = null,
    Object? participantOneName = null,
    Object? participantTwoName = null,
    Object? participantOnePhoto = freezed,
    Object? participantTwoPhoto = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = null,
  }) {
    return _then(_Conversation(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      participantOneId: null == participantOneId
          ? _self.participantOneId
          : participantOneId // ignore: cast_nullable_to_non_nullable
              as String,
      participantTwoId: null == participantTwoId
          ? _self.participantTwoId
          : participantTwoId // ignore: cast_nullable_to_non_nullable
              as String,
      participantOneName: null == participantOneName
          ? _self.participantOneName
          : participantOneName // ignore: cast_nullable_to_non_nullable
              as String,
      participantTwoName: null == participantTwoName
          ? _self.participantTwoName
          : participantTwoName // ignore: cast_nullable_to_non_nullable
              as String,
      participantOnePhoto: freezed == participantOnePhoto
          ? _self.participantOnePhoto
          : participantOnePhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      participantTwoPhoto: freezed == participantTwoPhoto
          ? _self.participantTwoPhoto
          : participantTwoPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
