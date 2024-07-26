// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pixabay_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PixabayStateImpl _$$PixabayStateImplFromJson(Map<String, dynamic> json) =>
    _$PixabayStateImpl(
      pixabayItem: (json['pixabayItem'] as List<dynamic>?)
              ?.map((e) => PixabayItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$PixabayStateImplToJson(_$PixabayStateImpl instance) =>
    <String, dynamic>{
      'pixabayItem': instance.pixabayItem,
      'isLoading': instance.isLoading,
    };
