// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageEvent<T> {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function(String message) showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showSnackBar,
    TResult? Function(String message)? showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function(String message)? showDialog,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowSnackBar<T> value) showSnackBar,
    required TResult Function(ShowDialog<T> value) showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowSnackBar<T> value)? showSnackBar,
    TResult? Function(ShowDialog<T> value)? showDialog,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowSnackBar<T> value)? showSnackBar,
    TResult Function(ShowDialog<T> value)? showDialog,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageEventCopyWith<T, ImageEvent<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageEventCopyWith<T, $Res> {
  factory $ImageEventCopyWith(
          ImageEvent<T> value, $Res Function(ImageEvent<T>) then) =
      _$ImageEventCopyWithImpl<T, $Res, ImageEvent<T>>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ImageEventCopyWithImpl<T, $Res, $Val extends ImageEvent<T>>
    implements $ImageEventCopyWith<T, $Res> {
  _$ImageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShowSnackBarImplCopyWith<T, $Res>
    implements $ImageEventCopyWith<T, $Res> {
  factory _$$ShowSnackBarImplCopyWith(_$ShowSnackBarImpl<T> value,
          $Res Function(_$ShowSnackBarImpl<T>) then) =
      __$$ShowSnackBarImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ShowSnackBarImplCopyWithImpl<T, $Res>
    extends _$ImageEventCopyWithImpl<T, $Res, _$ShowSnackBarImpl<T>>
    implements _$$ShowSnackBarImplCopyWith<T, $Res> {
  __$$ShowSnackBarImplCopyWithImpl(
      _$ShowSnackBarImpl<T> _value, $Res Function(_$ShowSnackBarImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ShowSnackBarImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ShowSnackBarImpl<T> implements ShowSnackBar<T> {
  const _$ShowSnackBarImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ImageEvent<$T>.showSnackBar(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowSnackBarImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowSnackBarImplCopyWith<T, _$ShowSnackBarImpl<T>> get copyWith =>
      __$$ShowSnackBarImplCopyWithImpl<T, _$ShowSnackBarImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function(String message) showDialog,
  }) {
    return showSnackBar(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showSnackBar,
    TResult? Function(String message)? showDialog,
  }) {
    return showSnackBar?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function(String message)? showDialog,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowSnackBar<T> value) showSnackBar,
    required TResult Function(ShowDialog<T> value) showDialog,
  }) {
    return showSnackBar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowSnackBar<T> value)? showSnackBar,
    TResult? Function(ShowDialog<T> value)? showDialog,
  }) {
    return showSnackBar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowSnackBar<T> value)? showSnackBar,
    TResult Function(ShowDialog<T> value)? showDialog,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(this);
    }
    return orElse();
  }
}

abstract class ShowSnackBar<T> implements ImageEvent<T> {
  const factory ShowSnackBar(final String message) = _$ShowSnackBarImpl<T>;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ShowSnackBarImplCopyWith<T, _$ShowSnackBarImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShowDialogImplCopyWith<T, $Res>
    implements $ImageEventCopyWith<T, $Res> {
  factory _$$ShowDialogImplCopyWith(
          _$ShowDialogImpl<T> value, $Res Function(_$ShowDialogImpl<T>) then) =
      __$$ShowDialogImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ShowDialogImplCopyWithImpl<T, $Res>
    extends _$ImageEventCopyWithImpl<T, $Res, _$ShowDialogImpl<T>>
    implements _$$ShowDialogImplCopyWith<T, $Res> {
  __$$ShowDialogImplCopyWithImpl(
      _$ShowDialogImpl<T> _value, $Res Function(_$ShowDialogImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ShowDialogImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ShowDialogImpl<T> implements ShowDialog<T> {
  const _$ShowDialogImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ImageEvent<$T>.showDialog(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowDialogImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowDialogImplCopyWith<T, _$ShowDialogImpl<T>> get copyWith =>
      __$$ShowDialogImplCopyWithImpl<T, _$ShowDialogImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showSnackBar,
    required TResult Function(String message) showDialog,
  }) {
    return showDialog(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showSnackBar,
    TResult? Function(String message)? showDialog,
  }) {
    return showDialog?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showSnackBar,
    TResult Function(String message)? showDialog,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowSnackBar<T> value) showSnackBar,
    required TResult Function(ShowDialog<T> value) showDialog,
  }) {
    return showDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowSnackBar<T> value)? showSnackBar,
    TResult? Function(ShowDialog<T> value)? showDialog,
  }) {
    return showDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowSnackBar<T> value)? showSnackBar,
    TResult Function(ShowDialog<T> value)? showDialog,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(this);
    }
    return orElse();
  }
}

abstract class ShowDialog<T> implements ImageEvent<T> {
  const factory ShowDialog(final String message) = _$ShowDialogImpl<T>;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ShowDialogImplCopyWith<T, _$ShowDialogImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
