// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageStateImpl _$$ImageStateImplFromJson(Map<String, dynamic> json) =>
    _$ImageStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      imageItem: (json['imageItem'] as List<dynamic>?)
              ?.map((e) => ImageItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ImageStateImplToJson(_$ImageStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'imageItem': instance.imageItem,
    };
