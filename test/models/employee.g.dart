// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $EmployeeLocalAdapter on LocalAdapter<Employee> {
  @override
  Map<String, Map<String, Object?>> relationshipsFor([Employee? model]) => {};

  @override
  Employee deserialize(map) {
    map = transformDeserialize(map);
    return Employee.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _employeesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $EmployeeHiveLocalAdapter = HiveLocalAdapter<Employee>
    with $EmployeeLocalAdapter;

class $EmployeeRemoteAdapter = RemoteAdapter<Employee>
    with JSONAPIAdapter<Employee>, TestMixin<Employee>, EmployeeMixin;

final internalEmployeesRemoteAdapterProvider =
    Provider<RemoteAdapter<Employee>>((ref) => $EmployeeRemoteAdapter(
        $EmployeeHiveLocalAdapter(ref.read),
        InternalHolder(_employeesFinders)));

final employeesRepositoryProvider =
    Provider<Repository<Employee>>((ref) => Repository<Employee>(ref.read));

extension EmployeeDataRepositoryX on Repository<Employee> {
  JSONAPIAdapter<Employee> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<Employee>;
  TestMixin<Employee> get testMixin => remoteAdapter as TestMixin<Employee>;
  EmployeeMixin get employeeMixin => remoteAdapter as EmployeeMixin;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Employee _$$_EmployeeFromJson(Map<String, dynamic> json) => _$_Employee(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_EmployeeToJson(_$_Employee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
