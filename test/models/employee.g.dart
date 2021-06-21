// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Employee _$_$_EmployeeFromJson(Map<String, dynamic> json) {
  return _$_Employee(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$_$_EmployeeToJson(_$_Employee instance) =>
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

final employeesLocalAdapterProvider =
    Provider<LocalAdapter<Employee>>((ref) => $EmployeeHiveLocalAdapter(ref));

final employeesRemoteAdapterProvider = Provider<RemoteAdapter<Employee>>(
    (ref) => $EmployeeRemoteAdapter(ref.read(employeesLocalAdapterProvider)));

final employeesRepositoryProvider =
    Provider<Repository<Employee>>((ref) => Repository<Employee>(ref));

final _watchEmployee = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<Employee?>,
    DataState<Employee?>,
    WatchArgs<Employee>>((ref, args) {
  return ref.read(employeesRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Employee?>,
        DataState<Employee?>>
    watchEmployee(dynamic id,
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        AlsoWatch<Employee>? alsoWatch}) {
  return _watchEmployee(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _watchEmployees = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<List<Employee>>,
    DataState<List<Employee>>,
    WatchArgs<Employee>>((ref, args) {
  ref.maintainState = false;
  return ref.read(employeesRepositoryProvider).watchAll(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      filterLocal: args.filterLocal,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Employee>>,
        DataState<List<Employee>>>
    watchEmployees(
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers}) {
  return _watchEmployees(
      WatchArgs(remote: remote, params: params, headers: headers));
}

extension EmployeeX on Employee {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `context.read`, `ref.read`, `container.read`
  Employee init(Reader read) {
    final repository = internalLocatorFn(employeesRepositoryProvider, read);
    return repository.remoteAdapter.initializeModel(this, save: true);
  }
}
