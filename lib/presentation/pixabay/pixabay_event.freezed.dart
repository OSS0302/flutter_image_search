// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pixabay_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PixabayEvent<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showDialog,
    required TResult Function(String messge) showSnackBar,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showDialog,
    TResult? Function(String messge)? showSnackBar,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showDialog,
    TResult Function(String messge)? showSnackBar,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowDialog<T> value) showDialog,
    required TResult Function(ShowSnackBar<T> value) showSnackBar,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowDialog<T> value)? showDialog,
    TResult? Function(ShowSnackBar<T> value)? showSnackBar,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
    TResult Function(ShowSnackBar<T> value)? showSnackBar,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixabayEventCopyWith<T, $Res> {
  factory $PixabayEventCopyWith(
          PixabayEvent<T> value, $Res Function(PixabayEvent<T>) then) =
      _$PixabayEventCopyWithImpl<T, $Res, PixabayEvent<T>>;
}

/// @nodoc
class _$PixabayEventCopyWithImpl<T, $Res, $Val extends PixabayEvent<T>>
    implements $PixabayEventCopyWith<T, $Res> {
  _$PixabayEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ShowDialogImplCopyWith<T, $Res> {
  factory _$$ShowDialogImplCopyWith(
          _$ShowDialogImpl<T> value, $Res Function(_$ShowDialogImpl<T>) then) =
      __$$ShowDialogImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ShowDialogImplCopyWithImpl<T, $Res>
    extends _$PixabayEventCopyWithImpl<T, $Res, _$ShowDialogImpl<T>>
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
    return 'PixabayEvent<$T>.showDialog(message: $message)';
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
    required TResult Function(String message) showDialog,
    required TResult Function(String messge) showSnackBar,
  }) {
    return showDialog(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showDialog,
    TResult? Function(String messge)? showSnackBar,
  }) {
    return showDialog?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showDialog,
    TResult Function(String messge)? showSnackBar,
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
    required TResult Function(ShowDialog<T> value) showDialog,
    required TResult Function(ShowSnackBar<T> value) showSnackBar,
  }) {
    return showDialog(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowDialog<T> value)? showDialog,
    TResult? Function(ShowSnackBar<T> value)? showSnackBar,
  }) {
    return showDialog?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
    TResult Function(ShowSnackBar<T> value)? showSnackBar,
    required TResult orElse(),
  }) {
    if (showDialog != null) {
      return showDialog(this);
    }
    return orElse();
  }
}

abstract class ShowDialog<T> implements PixabayEvent<T> {
  const factory ShowDialog(final String message) = _$ShowDialogImpl<T>;

  String get message;
  @JsonKey(ignore: true)
  _$$ShowDialogImplCopyWith<T, _$ShowDialogImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShowSnackBarImplCopyWith<T, $Res> {
  factory _$$ShowSnackBarImplCopyWith(_$ShowSnackBarImpl<T> value,
          $Res Function(_$ShowSnackBarImpl<T>) then) =
      __$$ShowSnackBarImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String messge});
}

/// @nodoc
class __$$ShowSnackBarImplCopyWithImpl<T, $Res>
    extends _$PixabayEventCopyWithImpl<T, $Res, _$ShowSnackBarImpl<T>>
    implements _$$ShowSnackBarImplCopyWith<T, $Res> {
  __$$ShowSnackBarImplCopyWithImpl(
      _$ShowSnackBarImpl<T> _value, $Res Function(_$ShowSnackBarImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messge = null,
  }) {
    return _then(_$ShowSnackBarImpl<T>(
      null == messge
          ? _value.messge
          : messge // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ShowSnackBarImpl<T> implements ShowSnackBar<T> {
  const _$ShowSnackBarImpl(this.messge);

  @override
  final String messge;

  @override
  String toString() {
    return 'PixabayEvent<$T>.showSnackBar(messge: $messge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShowSnackBarImpl<T> &&
            (identical(other.messge, messge) || other.messge == messge));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messge);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShowSnackBarImplCopyWith<T, _$ShowSnackBarImpl<T>> get copyWith =>
      __$$ShowSnackBarImplCopyWithImpl<T, _$ShowSnackBarImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) showDialog,
    required TResult Function(String messge) showSnackBar,
  }) {
    return showSnackBar(messge);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? showDialog,
    TResult? Function(String messge)? showSnackBar,
  }) {
    return showSnackBar?.call(messge);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? showDialog,
    TResult Function(String messge)? showSnackBar,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(messge);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ShowDialog<T> value) showDialog,
    required TResult Function(ShowSnackBar<T> value) showSnackBar,
  }) {
    return showSnackBar(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ShowDialog<T> value)? showDialog,
    TResult? Function(ShowSnackBar<T> value)? showSnackBar,
  }) {
    return showSnackBar?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ShowDialog<T> value)? showDialog,
    TResult Function(ShowSnackBar<T> value)? showSnackBar,
    required TResult orElse(),
  }) {
    if (showSnackBar != null) {
      return showSnackBar(this);
    }
    return orElse();
  }
}

abstract class ShowSnackBar<T> implements PixabayEvent<T> {
  const factory ShowSnackBar(final String messge) = _$ShowSnackBarImpl<T>;

  String get messge;
  @JsonKey(ignore: true)
  _$$ShowSnackBarImplCopyWith<T, _$ShowSnackBarImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
