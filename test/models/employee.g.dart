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

// ignore: must_be_immutable
class $EmployeeHiveLocalAdapter = HiveLocalAdapter<Employee>
    with $EmployeeLocalAdapter;

class $EmployeeRemoteAdapter = RemoteAdapter<Employee>
    with JSONAPIAdapter<Employee>, TestMixin<Employee>, EmployeeMixin;

//

final employeesLocalAdapterProvider = Provider<LocalAdapter<Employee>>(
    (ref) => $EmployeeHiveLocalAdapter(ref.read));

final employeesRemoteAdapterProvider = Provider<RemoteAdapter<Employee>>(
    (ref) => $EmployeeRemoteAdapter(ref.watch(employeesLocalAdapterProvider),
        employeeProvider, employeesProvider));

final employeesRepositoryProvider =
    Provider<Repository<Employee>>((ref) => Repository<Employee>(ref.read));

final _employeeProvider = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<Employee?>,
    DataState<Employee?>,
    WatchArgs<Employee>>((ref, args) {
  return ref.watch(employeesRepositoryProvider).watchOneNotifier(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Employee?>,
        DataState<Employee?>>
    employeeProvider(dynamic id,
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        AlsoWatch<Employee>? alsoWatch}) {
  return _employeeProvider(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _employeesProvider = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<List<Employee>>,
    DataState<List<Employee>>,
    WatchArgs<Employee>>((ref, args) {
  return ref.watch(employeesRepositoryProvider).watchAllNotifier(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Employee>>,
        DataState<List<Employee>>>
    employeesProvider(
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        bool? syncLocal}) {
  return _employeesProvider(WatchArgs(
      remote: remote, params: params, headers: headers, syncLocal: syncLocal));
}

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
