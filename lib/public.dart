import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public.freezed.dart';

@freezed
abstract class Public with _$Public {
  factory Public({
    @required String name,
    @required String subname,
  }) = _Public;
}
