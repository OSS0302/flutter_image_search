// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageItemImpl _$$ImageItemImplFromJson(Map<String, dynamic> json) =>
    _$ImageItemImpl(
      imageUrl: json['imageUrl'] as String,
      tags: json['tags'] as String,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$$ImageItemImplToJson(_$ImageItemImpl instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'id': instance.id,
    };
