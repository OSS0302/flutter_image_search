// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageState _$ImageStateFromJson(Map<String, dynamic> json) {
  return _ImageState.fromJson(json);
}

/// @nodoc
mixin _$ImageState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<ImageItem> get imageItem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageStateCopyWith<ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageStateCopyWith<$Res> {
  factory $ImageStateCopyWith(
          ImageState value, $Res Function(ImageState) then) =
      _$ImageStateCopyWithImpl<$Res, ImageState>;
  @useResult
  $Res call({bool isLoading, List<ImageItem> imageItem});
}

/// @nodoc
class _$ImageStateCopyWithImpl<$Res, $Val extends ImageState>
    implements $ImageStateCopyWith<$Res> {
  _$ImageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageItem = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageItem: null == imageItem
          ? _value.imageItem
          : imageItem // ignore: cast_nullable_to_non_nullable
              as List<ImageItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageStateImplCopyWith<$Res>
    implements $ImageStateCopyWith<$Res> {
  factory _$$ImageStateImplCopyWith(
          _$ImageStateImpl value, $Res Function(_$ImageStateImpl) then) =
      __$$ImageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<ImageItem> imageItem});
}

/// @nodoc
class __$$ImageStateImplCopyWithImpl<$Res>
    extends _$ImageStateCopyWithImpl<$Res, _$ImageStateImpl>
    implements _$$ImageStateImplCopyWith<$Res> {
  __$$ImageStateImplCopyWithImpl(
      _$ImageStateImpl _value, $Res Function(_$ImageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? imageItem = null,
  }) {
    return _then(_$ImageStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageItem: null == imageItem
          ? _value._imageItem
          : imageItem // ignore: cast_nullable_to_non_nullable
              as List<ImageItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageStateImpl with DiagnosticableTreeMixin implements _ImageState {
  const _$ImageStateImpl(
      {this.isLoading = false, final List<ImageItem> imageItem = const []})
      : _imageItem = imageItem;

  factory _$ImageStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageStateImplFromJson(json);

  @override
  @JsonKey()
  final bool isLoading;
  final List<ImageItem> _imageItem;
  @override
  @JsonKey()
  List<ImageItem> get imageItem {
    if (_imageItem is EqualUnmodifiableListView) return _imageItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageItem);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageState(isLoading: $isLoading, imageItem: $imageItem)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageState'))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('imageItem', imageItem));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._imageItem, _imageItem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_imageItem));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageStateImplCopyWith<_$ImageStateImpl> get copyWith =>
      __$$ImageStateImplCopyWithImpl<_$ImageStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageStateImplToJson(
      this,
    );
  }
}

abstract class _ImageState implements ImageState {
  const factory _ImageState(
      {final bool isLoading,
      final List<ImageItem> imageItem}) = _$ImageStateImpl;

  factory _ImageState.fromJson(Map<String, dynamic> json) =
      _$ImageStateImpl.fromJson;

  @override
  bool get isLoading;
  @override
  List<ImageItem> get imageItem;
  @override
  @JsonKey(ignore: true)
  _$$ImageStateImplCopyWith<_$ImageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
