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
  Map<String, Map<String, Object>> relationshipsFor([Employee model]) => {};

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
    with JSONAPIAdapter<Employee>, TestMixin<Employee>;

//

final employeeLocalAdapterProvider =
    Provider<LocalAdapter<Employee>>((ref) => $EmployeeHiveLocalAdapter(ref));

final employeeRemoteAdapterProvider = Provider<RemoteAdapter<Employee>>(
    (ref) => $EmployeeRemoteAdapter(ref.read(employeeLocalAdapterProvider)));

final employeeRepositoryProvider =
    Provider<Repository<Employee>>((ref) => Repository<Employee>(ref));

final _watchEmployee = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<Employee>, WatchArgs<Employee>>((ref, args) {
  return ref.watch(employeeRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Employee>> watchEmployee(
    dynamic id,
    {bool remote = true,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<Employee> alsoWatch}) {
  return _watchEmployee(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _watchEmployees = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<Employee>>, WatchArgs<Employee>>(
        (ref, args) {
  ref.maintainState = false;
  return ref.watch(employeeRepositoryProvider).watchAll(
      remote: args.remote, params: args.params, headers: args.headers);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Employee>>>
    watchEmployees(
        {bool remote,
        Map<String, dynamic> params,
        Map<String, String> headers}) {
  return _watchEmployees(
      WatchArgs(remote: remote, params: params, headers: headers));
}

extension EmployeeX on Employee {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Pass:
  ///  - A `BuildContext` if using Flutter with Riverpod or Provider
  ///  - Nothing if using Flutter with GetIt
  ///  - A Riverpod `ProviderContainer` if using pure Dart
  ///  - Its own [Repository<Employee>]
  Employee init(container) {
    final repository = container is Repository<Employee>
        ? container
        : internalLocatorFn(employeeRepositoryProvider, container);
    return repository.internalAdapter.initializeModel(this, save: true)
        as Employee;
  }
}

extension EmployeeRepositoryX on Repository<Employee> {
  Future<Employee> loginTest(Employee model) =>
      (internalAdapter as TestMixin<Employee>).loginTest(model);
}
