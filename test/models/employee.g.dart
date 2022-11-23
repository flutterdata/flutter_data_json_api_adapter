// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $EmployeeLocalAdapter on LocalAdapter<Employee> {
  static final Map<String, RelationshipMeta> _kEmployeeRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kEmployeeRelationshipMetas;

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
        $EmployeeHiveLocalAdapter(ref), InternalHolder(_employeesFinders)));

final employeesRepositoryProvider =
    Provider<Repository<Employee>>((ref) => Repository<Employee>(ref));

extension EmployeeDataRepositoryX on Repository<Employee> {
  JSONAPIAdapter<Employee> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<Employee>;
  TestMixin<Employee> get testMixin => remoteAdapter as TestMixin<Employee>;
  EmployeeMixin get employeeMixin => remoteAdapter as EmployeeMixin;
}

extension EmployeeRelationshipGraphNodeX on RelationshipGraphNode<Employee> {}

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
