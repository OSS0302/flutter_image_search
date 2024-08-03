// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pixabay_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PixabayItem _$PixabayItemFromJson(Map<String, dynamic> json) {
  return _PixabayItem.fromJson(json);
}

/// @nodoc
mixin _$PixabayItem {
  String get imageUrl => throw _privateConstructorUsedError;
  String get tags => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PixabayItemCopyWith<PixabayItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PixabayItemCopyWith<$Res> {
  factory $PixabayItemCopyWith(
          PixabayItem value, $Res Function(PixabayItem) then) =
      _$PixabayItemCopyWithImpl<$Res, PixabayItem>;
  @useResult
  $Res call({String imageUrl, String tags, int id});
}

/// @nodoc
class _$PixabayItemCopyWithImpl<$Res, $Val extends PixabayItem>
    implements $PixabayItemCopyWith<$Res> {
  _$PixabayItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? tags = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PixabayItemImplCopyWith<$Res>
    implements $PixabayItemCopyWith<$Res> {
  factory _$$PixabayItemImplCopyWith(
          _$PixabayItemImpl value, $Res Function(_$PixabayItemImpl) then) =
      __$$PixabayItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String imageUrl, String tags, int id});
}

/// @nodoc
class __$$PixabayItemImplCopyWithImpl<$Res>
    extends _$PixabayItemCopyWithImpl<$Res, _$PixabayItemImpl>
    implements _$$PixabayItemImplCopyWith<$Res> {
  __$$PixabayItemImplCopyWithImpl(
      _$PixabayItemImpl _value, $Res Function(_$PixabayItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? tags = null,
    Object? id = null,
  }) {
    return _then(_$PixabayItemImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PixabayItemImpl with DiagnosticableTreeMixin implements _PixabayItem {
  const _$PixabayItemImpl(
      {required this.imageUrl, required this.tags, required this.id});

  factory _$PixabayItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PixabayItemImplFromJson(json);

  @override
  final String imageUrl;
  @override
  final String tags;
  @override
  final int id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PixabayItem(imageUrl: $imageUrl, tags: $tags, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PixabayItem'))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PixabayItemImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, tags, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PixabayItemImplCopyWith<_$PixabayItemImpl> get copyWith =>
      __$$PixabayItemImplCopyWithImpl<_$PixabayItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PixabayItemImplToJson(
      this,
    );
  }
}

abstract class _PixabayItem implements PixabayItem {
  const factory _PixabayItem(
      {required final String imageUrl,
      required final String tags,
      required final int id}) = _$PixabayItemImpl;

  factory _PixabayItem.fromJson(Map<String, dynamic> json) =
      _$PixabayItemImpl.fromJson;

  @override
  String get imageUrl;
  @override
  String get tags;
  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$PixabayItemImplCopyWith<_$PixabayItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
