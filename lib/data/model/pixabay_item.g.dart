// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixabay_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PixabayItemImpl _$$PixabayItemImplFromJson(Map<String, dynamic> json) =>
    _$PixabayItemImpl(
      imageUrl: json['imageUrl'] as String,
      tags: json['tags'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$$PixabayItemImplToJson(_$PixabayItemImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'id': instance.id,
    };
