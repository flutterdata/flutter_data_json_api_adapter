// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
class _$CompanyTearOff {
  const _$CompanyTearOff();

  _Company call(
      {String? id,
      required String name,
      String? nasdaq,
      DateTime? updatedAt,
      HasMany<Model>? models,
      @JsonKey(name: 'w') HasMany<Employee>? employees}) {
    return _Company(
      id: id,
      name: name,
      nasdaq: nasdaq,
      updatedAt: updatedAt,
      models: models,
      employees: employees,
    );
  }

  Company fromJson(Map<String, Object> json) {
    return Company.fromJson(json);
  }
}

/// @nodoc
const $Company = _$CompanyTearOff();

/// @nodoc
mixin _$Company {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get nasdaq => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  HasMany<Model>? get models =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'w')
  HasMany<Employee>? get employees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyCopyWith<Company> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      String? nasdaq,
      DateTime? updatedAt,
      HasMany<Model>? models,
      @JsonKey(name: 'w') HasMany<Employee>? employees});
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res> implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  final Company _value;
  // ignore: unused_field
  final $Res Function(Company) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nasdaq = freezed,
    Object? updatedAt = freezed,
    Object? models = freezed,
    Object? employees = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nasdaq: nasdaq == freezed
          ? _value.nasdaq
          : nasdaq // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      models: models == freezed
          ? _value.models
          : models // ignore: cast_nullable_to_non_nullable
              as HasMany<Model>?,
      employees: employees == freezed
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as HasMany<Employee>?,
    ));
  }
}

/// @nodoc
abstract class _$CompanyCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$CompanyCopyWith(_Company value, $Res Function(_Company) then) =
      __$CompanyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      String? nasdaq,
      DateTime? updatedAt,
      HasMany<Model>? models,
      @JsonKey(name: 'w') HasMany<Employee>? employees});
}

/// @nodoc
class __$CompanyCopyWithImpl<$Res> extends _$CompanyCopyWithImpl<$Res>
    implements _$CompanyCopyWith<$Res> {
  __$CompanyCopyWithImpl(_Company _value, $Res Function(_Company) _then)
      : super(_value, (v) => _then(v as _Company));

  @override
  _Company get _value => super._value as _Company;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nasdaq = freezed,
    Object? updatedAt = freezed,
    Object? models = freezed,
    Object? employees = freezed,
  }) {
    return _then(_Company(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nasdaq: nasdaq == freezed
          ? _value.nasdaq
          : nasdaq // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      models: models == freezed
          ? _value.models
          : models // ignore: cast_nullable_to_non_nullable
              as HasMany<Model>?,
      employees: employees == freezed
          ? _value.employees
          : employees // ignore: cast_nullable_to_non_nullable
              as HasMany<Employee>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Company extends _Company {
  _$_Company(
      {this.id,
      required this.name,
      this.nasdaq,
      this.updatedAt,
      this.models,
      @JsonKey(name: 'w') this.employees})
      : super._();

  factory _$_Company.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String? nasdaq;
  @override
  final DateTime? updatedAt;
  @override
  final HasMany<Model>? models;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'w')
  final HasMany<Employee>? employees;

  @override
  String toString() {
    return 'Company(id: $id, name: $name, nasdaq: $nasdaq, updatedAt: $updatedAt, models: $models, employees: $employees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Company &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.nasdaq, nasdaq) ||
                const DeepCollectionEquality().equals(other.nasdaq, nasdaq)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.models, models) ||
                const DeepCollectionEquality().equals(other.models, models)) &&
            (identical(other.employees, employees) ||
                const DeepCollectionEquality()
                    .equals(other.employees, employees)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(nasdaq) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(models) ^
      const DeepCollectionEquality().hash(employees);

  @JsonKey(ignore: true)
  @override
  _$CompanyCopyWith<_Company> get copyWith =>
      __$CompanyCopyWithImpl<_Company>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyToJson(this);
  }
}

abstract class _Company extends Company {
  factory _Company(
      {String? id,
      required String name,
      String? nasdaq,
      DateTime? updatedAt,
      HasMany<Model>? models,
      @JsonKey(name: 'w') HasMany<Employee>? employees}) = _$_Company;
  _Company._() : super._();

  factory _Company.fromJson(Map<String, dynamic> json) = _$_Company.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String? get nasdaq => throw _privateConstructorUsedError;
  @override
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  HasMany<Model>? get models => throw _privateConstructorUsedError;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'w')
  HasMany<Employee>? get employees => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CompanyCopyWith<_Company> get copyWith =>
      throw _privateConstructorUsedError;
}
