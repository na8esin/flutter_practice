// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'public.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Public _$PublicFromJson(Map<String, dynamic> json) {
  return _Public.fromJson(json);
}

/// @nodoc
class _$PublicTearOff {
  const _$PublicTearOff();

// ignore: unused_element
  _Public call(
      {@required String name,
      String subname,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt}) {
    return _Public(
      name: name,
      subname: subname,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

// ignore: unused_element
  Public fromJson(Map<String, Object> json) {
    return Public.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Public = _$PublicTearOff();

/// @nodoc
mixin _$Public {
  String get name;
  String get subname;
  @TimestampConverter()
  DateTime get createdAt;
  @TimestampConverter()
  DateTime get updatedAt;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $PublicCopyWith<Public> get copyWith;
}

/// @nodoc
abstract class $PublicCopyWith<$Res> {
  factory $PublicCopyWith(Public value, $Res Function(Public) then) =
      _$PublicCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String subname,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

/// @nodoc
class _$PublicCopyWithImpl<$Res> implements $PublicCopyWith<$Res> {
  _$PublicCopyWithImpl(this._value, this._then);

  final Public _value;
  // ignore: unused_field
  final $Res Function(Public) _then;

  @override
  $Res call({
    Object name = freezed,
    Object subname = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      subname: subname == freezed ? _value.subname : subname as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$PublicCopyWith<$Res> implements $PublicCopyWith<$Res> {
  factory _$PublicCopyWith(_Public value, $Res Function(_Public) then) =
      __$PublicCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String subname,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt});
}

/// @nodoc
class __$PublicCopyWithImpl<$Res> extends _$PublicCopyWithImpl<$Res>
    implements _$PublicCopyWith<$Res> {
  __$PublicCopyWithImpl(_Public _value, $Res Function(_Public) _then)
      : super(_value, (v) => _then(v as _Public));

  @override
  _Public get _value => super._value as _Public;

  @override
  $Res call({
    Object name = freezed,
    Object subname = freezed,
    Object createdAt = freezed,
    Object updatedAt = freezed,
  }) {
    return _then(_Public(
      name: name == freezed ? _value.name : name as String,
      subname: subname == freezed ? _value.subname : subname as String,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Public implements _Public {
  _$_Public(
      {@required this.name,
      this.subname,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : assert(name != null);

  factory _$_Public.fromJson(Map<String, dynamic> json) =>
      _$_$_PublicFromJson(json);

  @override
  final String name;
  @override
  final String subname;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Public(name: $name, subname: $subname, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Public &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.subname, subname) ||
                const DeepCollectionEquality()
                    .equals(other.subname, subname)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(subname) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$PublicCopyWith<_Public> get copyWith =>
      __$PublicCopyWithImpl<_Public>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PublicToJson(this);
  }
}

abstract class _Public implements Public {
  factory _Public(
      {@required String name,
      String subname,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime updatedAt}) = _$_Public;

  factory _Public.fromJson(Map<String, dynamic> json) = _$_Public.fromJson;

  @override
  String get name;
  @override
  String get subname;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$PublicCopyWith<_Public> get copyWith;
}
