// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Company _$$_CompanyFromJson(Map<String, dynamic> json) => _$_Company(
      id: json['id'] as String?,
      name: json['name'] as String,
      nasdaq: json['nasdaq'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      models: json['models'] == null
          ? null
          : HasMany<Model>.fromJson(json['models'] as Map<String, dynamic>),
      employees: json['w'] == null
          ? null
          : HasMany<Employee>.fromJson(json['w'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CompanyToJson(_$_Company instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nasdaq': instance.nasdaq,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'models': instance.models,
      'w': instance.employees,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $CompanyLocalAdapter on LocalAdapter<Company> {
  @override
  Map<String, Map<String, Object?>> relationshipsFor([Company? model]) => {
        'models': {
          'name': 'models',
          'inverse': 'company',
          'type': 'models',
          'kind': 'HasMany',
          'instance': model?.models
        },
        'w': {
          'name': 'employees',
          'type': 'employees',
          'kind': 'HasMany',
          'instance': model?.employees
        }
      };

  @override
  Company deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return Company.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => model.toJson();
}

// ignore: must_be_immutable
class $CompanyHiveLocalAdapter = HiveLocalAdapter<Company>
    with $CompanyLocalAdapter;

class $CompanyRemoteAdapter = RemoteAdapter<Company>
    with JSONAPIAdapter<Company>, TestMixin<Company>, CaseMixin<Company>;

//

final companiesLocalAdapterProvider = Provider<LocalAdapter<Company>>(
    (ref) => $CompanyHiveLocalAdapter(ref.read));

final companiesRemoteAdapterProvider = Provider<RemoteAdapter<Company>>((ref) =>
    $CompanyRemoteAdapter(ref.watch(companiesLocalAdapterProvider),
        companyProvider, companiesProvider));

final companiesRepositoryProvider =
    Provider<Repository<Company>>((ref) => Repository<Company>(ref.read));

final _companyProvider = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<Company?>,
    DataState<Company?>,
    WatchArgs<Company>>((ref, args) {
  return ref.watch(companiesRepositoryProvider).watchOneNotifier(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Company?>,
        DataState<Company?>>
    companyProvider(dynamic id,
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        AlsoWatch<Company>? alsoWatch}) {
  return _companyProvider(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _companiesProvider = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<List<Company>>,
    DataState<List<Company>>,
    WatchArgs<Company>>((ref, args) {
  return ref.watch(companiesRepositoryProvider).watchAllNotifier(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Company>>,
        DataState<List<Company>>>
    companiesProvider(
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        bool? syncLocal}) {
  return _companiesProvider(WatchArgs(
      remote: remote, params: params, headers: headers, syncLocal: syncLocal));
}

extension CompanyDataX on Company {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `ref.read`, `container.read`
  Company init(Reader read, {bool save = true}) {
    final repository = internalLocatorFn(companiesRepositoryProvider, read);
    final updatedModel =
        repository.remoteAdapter.initializeModel(this, save: save);
    return save ? updatedModel : this;
  }
}

extension CompanyDataRepositoryX on Repository<Company> {
  JSONAPIAdapter<Company> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<Company>;
  TestMixin<Company> get testMixin => remoteAdapter as TestMixin<Company>;
  CaseMixin<Company> get caseMixin => remoteAdapter as CaseMixin<Company>;
}
