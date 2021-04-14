import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'category.freezed.dart';

// capterとかにすればよかった
@freezed
class Category with _$Category {
  factory Category({int? id, String? name}) = _Category;
}
