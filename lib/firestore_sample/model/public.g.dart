// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Public _$_$_PublicFromJson(Map json) {
  return _$_Public(
    name: json['name'] as String,
    subname: json['subname'] as String?,
    createdAt:
        const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    updatedAt:
        const TimestampConverter().fromJson(json['updatedAt'] as Timestamp?),
  );
}

Map<String, dynamic> _$_$_PublicToJson(_$_Public instance) => <String, dynamic>{
      'name': instance.name,
      'subname': instance.subname,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
