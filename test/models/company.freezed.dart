// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
class _$CompanyTearOff {
  const _$CompanyTearOff();

// ignore: unused_element
  _Company call(
      {String id,
      String name,
      String nasdaq,
      DateTime updatedAt,
      HasMany<Model> models,
      @JsonKey(name: 'w') HasMany<Employee> employees}) {
    return _Company(
      id: id,
      name: name,
      nasdaq: nasdaq,
      updatedAt: updatedAt,
      models: models,
      employees: employees,
    );
  }

// ignore: unused_element
  Company fromJson(Map<String, Object> json) {
    return Company.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Company = _$CompanyTearOff();

/// @nodoc
mixin _$Company {
  String get id;
  String get name;
  String get nasdaq;
  DateTime get updatedAt;
  HasMany<Model> get models;
  @JsonKey(name: 'w')
  HasMany<Employee> get employees;

  Map<String, dynamic> toJson();
  $CompanyCopyWith<Company> get copyWith;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      String nasdaq,
      DateTime updatedAt,
      HasMany<Model> models,
      @JsonKey(name: 'w') HasMany<Employee> employees});
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res> implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  final Company _value;
  // ignore: unused_field
  final $Res Function(Company) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object nasdaq = freezed,
    Object updatedAt = freezed,
    Object models = freezed,
    Object employees = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      nasdaq: nasdaq == freezed ? _value.nasdaq : nasdaq as String,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      models: models == freezed ? _value.models : models as HasMany<Model>,
      employees: employees == freezed
          ? _value.employees
          : employees as HasMany<Employee>,
    ));
  }
}

/// @nodoc
abstract class _$CompanyCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$CompanyCopyWith(_Company value, $Res Function(_Company) then) =
      __$CompanyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      String nasdaq,
      DateTime updatedAt,
      HasMany<Model> models,
      @JsonKey(name: 'w') HasMany<Employee> employees});
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
    Object id = freezed,
    Object name = freezed,
    Object nasdaq = freezed,
    Object updatedAt = freezed,
    Object models = freezed,
    Object employees = freezed,
  }) {
    return _then(_Company(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      nasdaq: nasdaq == freezed ? _value.nasdaq : nasdaq as String,
      updatedAt:
          updatedAt == freezed ? _value.updatedAt : updatedAt as DateTime,
      models: models == freezed ? _value.models : models as HasMany<Model>,
      employees: employees == freezed
          ? _value.employees
          : employees as HasMany<Employee>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Company extends _Company {
  _$_Company(
      {this.id,
      this.name,
      this.nasdaq,
      this.updatedAt,
      this.models,
      @JsonKey(name: 'w') this.employees})
      : super._();

  factory _$_Company.fromJson(Map<String, dynamic> json) =>
      _$_$_CompanyFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String nasdaq;
  @override
  final DateTime updatedAt;
  @override
  final HasMany<Model> models;
  @override
  @JsonKey(name: 'w')
  final HasMany<Employee> employees;

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

  @override
  _$CompanyCopyWith<_Company> get copyWith =>
      __$CompanyCopyWithImpl<_Company>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CompanyToJson(this);
  }
}

abstract class _Company extends Company {
  _Company._() : super._();
  factory _Company(
      {String id,
      String name,
      String nasdaq,
      DateTime updatedAt,
      HasMany<Model> models,
      @JsonKey(name: 'w') HasMany<Employee> employees}) = _$_Company;

  factory _Company.fromJson(Map<String, dynamic> json) = _$_Company.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get nasdaq;
  @override
  DateTime get updatedAt;
  @override
  HasMany<Model> get models;
  @override
  @JsonKey(name: 'w')
  HasMany<Employee> get employees;
  @override
  _$CompanyCopyWith<_Company> get copyWith;
}
