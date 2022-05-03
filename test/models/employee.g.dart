// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

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

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $EmployeeLocalAdapter on LocalAdapter<Employee> {
  @override
  Map<String, Map<String, Object?>> relationshipsFor([Employee? model]) => {};

  @override
  Employee deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return Employee.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => model.toJson();
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

extension EmployeeDataX on Employee {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `ref.read`, `container.read`
  Employee init(Reader read, {bool save = true}) {
    final repository = internalLocatorFn(employeesRepositoryProvider, read);
    final updatedModel =
        repository.remoteAdapter.initializeModel(this, save: save);
    return save ? updatedModel : this;
  }
}

extension EmployeeDataRepositoryX on Repository<Employee> {
  JSONAPIAdapter<Employee> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<Employee>;
  TestMixin<Employee> get testMixin => remoteAdapter as TestMixin<Employee>;
  EmployeeMixin get employeeMixin => remoteAdapter as EmployeeMixin;
}
