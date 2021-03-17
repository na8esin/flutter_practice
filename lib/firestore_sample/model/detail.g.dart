// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Detail _$_$_DetailFromJson(Map<String, dynamic> json) {
  return _$_Detail(
    title: json['title'] as String,
    createdAt:
        const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    updatedAt:
        const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
  );
}

Map<String, dynamic> _$_$_DetailToJson(_$_Detail instance) => <String, dynamic>{
      'title': instance.title,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
