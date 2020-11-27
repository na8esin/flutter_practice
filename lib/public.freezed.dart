// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'public.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PublicTearOff {
  const _$PublicTearOff();

// ignore: unused_element
  _Public call({@required String name, @required String subname}) {
    return _Public(
      name: name,
      subname: subname,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Public = _$PublicTearOff();

/// @nodoc
mixin _$Public {
  String get name;
  String get subname;

  $PublicCopyWith<Public> get copyWith;
}

/// @nodoc
abstract class $PublicCopyWith<$Res> {
  factory $PublicCopyWith(Public value, $Res Function(Public) then) =
      _$PublicCopyWithImpl<$Res>;
  $Res call({String name, String subname});
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
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as String,
      subname: subname == freezed ? _value.subname : subname as String,
    ));
  }
}

/// @nodoc
abstract class _$PublicCopyWith<$Res> implements $PublicCopyWith<$Res> {
  factory _$PublicCopyWith(_Public value, $Res Function(_Public) then) =
      __$PublicCopyWithImpl<$Res>;
  @override
  $Res call({String name, String subname});
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
  }) {
    return _then(_Public(
      name: name == freezed ? _value.name : name as String,
      subname: subname == freezed ? _value.subname : subname as String,
    ));
  }
}

/// @nodoc
class _$_Public with DiagnosticableTreeMixin implements _Public {
  _$_Public({@required this.name, @required this.subname})
      : assert(name != null),
        assert(subname != null);

  @override
  final String name;
  @override
  final String subname;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Public(name: $name, subname: $subname)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Public'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('subname', subname));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Public &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.subname, subname) ||
                const DeepCollectionEquality().equals(other.subname, subname)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(subname);

  @override
  _$PublicCopyWith<_Public> get copyWith =>
      __$PublicCopyWithImpl<_Public>(this, _$identity);
}

abstract class _Public implements Public {
  factory _Public({@required String name, @required String subname}) =
      _$_Public;

  @override
  String get name;
  @override
  String get subname;
  @override
  _$PublicCopyWith<_Public> get copyWith;
}
