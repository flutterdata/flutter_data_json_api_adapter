// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) {
  return Model(
    id: json['id'] as String,
    name: json['name'] as String,
    company: json['company'] == null
        ? null
        : BelongsTo.fromJson(json['company'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
    };

_$_City _$_$_CityFromJson(Map<String, dynamic> json) {
  return _$_City(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$_$_CityToJson(_$_City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_Company _$_$_CompanyFromJson(Map<String, dynamic> json) {
  return _$_Company(
    id: json['id'] as String,
    name: json['name'] as String,
    nasdaq: json['nasdaq'] as String,
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    models: json['models'] == null
        ? null
        : HasMany.fromJson(json['models'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_CompanyToJson(_$_Company instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nasdaq': instance.nasdaq,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'models': instance.models,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $ModelLocalAdapter on LocalAdapter<Model> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([Model model]) => {
        'company': {
          'inverse': 'models',
          'type': 'companies',
          'kind': 'BelongsTo',
          'instance': model?.company
        }
      };

  @override
  Model deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return _$ModelFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => _$ModelToJson(model);
}

// ignore: must_be_immutable
class $ModelHiveLocalAdapter = HiveLocalAdapter<Model> with $ModelLocalAdapter;

class $ModelRemoteAdapter = RemoteAdapter<Model>
    with JSONAPIAdapter<Model>, TestMixin<Model>;

//

final modelLocalAdapterProvider = Provider<LocalAdapter<Model>>((ref) =>
    $ModelHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final modelRemoteAdapterProvider = Provider<RemoteAdapter<Model>>(
    (ref) => $ModelRemoteAdapter(ref.read(modelLocalAdapterProvider)));

final modelRepositoryProvider =
    Provider<Repository<Model>>((ref) => Repository<Model>(ref));

final _watchModel = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<Model>, WatchArgs<Model>>((ref, args) {
  return ref.watch(modelRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierStateProvider<DataState<Model>> watchModel(dynamic id,
    {bool remote = true,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<Model> alsoWatch}) {
  return _watchModel(WatchArgs(
          id: id,
          remote: remote,
          params: params,
          headers: headers,
          alsoWatch: alsoWatch))
      .state;
}

final _watchModels = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<Model>>, WatchArgs<Model>>((ref, args) {
  return ref.watch(modelRepositoryProvider).watchAll(
      remote: args.remote, params: args.params, headers: args.headers);
});

AutoDisposeStateNotifierStateProvider<DataState<List<Model>>> watchModels(
    {bool remote, Map<String, dynamic> params, Map<String, String> headers}) {
  return _watchModels(
          WatchArgs(remote: remote, params: params, headers: headers))
      .state;
}

extension ModelX on Model {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Pass:
  ///  - A `BuildContext` if using Flutter with Riverpod or Provider
  ///  - Nothing if using Flutter with GetIt
  ///  - A Riverpod `ProviderContainer` if using pure Dart
  ///  - Its own [Repository<Model>]
  Model init(container) {
    final repository = container is Repository<Model>
        ? container
        : internalLocatorFn(modelRepositoryProvider, container);
    return repository.internalAdapter.initializeModel(this, save: true)
        as Model;
  }
}

extension ModelRepositoryX on Repository<Model> {
  Future<Model> loginTest(Model model) =>
      (internalAdapter as TestMixin<Model>).loginTest(model);
}

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $CityLocalAdapter on LocalAdapter<City> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([City model]) => {};

  @override
  City deserialize(map) {
    for (final key in relationshipsFor().keys) {
      map[key] = {
        '_': [map[key], !map.containsKey(key)],
      };
    }
    return City.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model) => model.toJson();
}

// ignore: must_be_immutable
class $CityHiveLocalAdapter = HiveLocalAdapter<City> with $CityLocalAdapter;

class $CityRemoteAdapter = RemoteAdapter<City>
    with JSONAPIAdapter<City>, TestMixin<City>;

//

final cityLocalAdapterProvider = Provider<LocalAdapter<City>>((ref) =>
    $CityHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final cityRemoteAdapterProvider = Provider<RemoteAdapter<City>>(
    (ref) => $CityRemoteAdapter(ref.read(cityLocalAdapterProvider)));

final cityRepositoryProvider =
    Provider<Repository<City>>((ref) => Repository<City>(ref));

final _watchCity = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<City>, WatchArgs<City>>((ref, args) {
  return ref.watch(cityRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierStateProvider<DataState<City>> watchCity(dynamic id,
    {bool remote = true,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<City> alsoWatch}) {
  return _watchCity(WatchArgs(
          id: id,
          remote: remote,
          params: params,
          headers: headers,
          alsoWatch: alsoWatch))
      .state;
}

final _watchCities = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<City>>, WatchArgs<City>>((ref, args) {
  return ref.watch(cityRepositoryProvider).watchAll(
      remote: args.remote, params: args.params, headers: args.headers);
});

AutoDisposeStateNotifierStateProvider<DataState<List<City>>> watchCities(
    {bool remote, Map<String, dynamic> params, Map<String, String> headers}) {
  return _watchCities(
          WatchArgs(remote: remote, params: params, headers: headers))
      .state;
}

extension CityX on City {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Pass:
  ///  - A `BuildContext` if using Flutter with Riverpod or Provider
  ///  - Nothing if using Flutter with GetIt
  ///  - A Riverpod `ProviderContainer` if using pure Dart
  ///  - Its own [Repository<City>]
  City init(container) {
    final repository = container is Repository<City>
        ? container
        : internalLocatorFn(cityRepositoryProvider, container);
    return repository.internalAdapter.initializeModel(this, save: true) as City;
  }
}

extension CityRepositoryX on Repository<City> {
  Future<City> loginTest(City model) =>
      (internalAdapter as TestMixin<City>).loginTest(model);
}

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $CompanyLocalAdapter on LocalAdapter<Company> {
  @override
  Map<String, Map<String, Object>> relationshipsFor([Company model]) => {
        'models': {
          'inverse': 'company',
          'type': 'models',
          'kind': 'HasMany',
          'instance': model?.models
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
    with JSONAPIAdapter<Company>, TestMixin<Company>;

//

final companyLocalAdapterProvider = Provider<LocalAdapter<Company>>((ref) =>
    $CompanyHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final companyRemoteAdapterProvider = Provider<RemoteAdapter<Company>>(
    (ref) => $CompanyRemoteAdapter(ref.read(companyLocalAdapterProvider)));

final companyRepositoryProvider =
    Provider<Repository<Company>>((ref) => Repository<Company>(ref));

final _watchCompany = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<Company>, WatchArgs<Company>>((ref, args) {
  return ref.watch(companyRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierStateProvider<DataState<Company>> watchCompany(
    dynamic id,
    {bool remote = true,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<Company> alsoWatch}) {
  return _watchCompany(WatchArgs(
          id: id,
          remote: remote,
          params: params,
          headers: headers,
          alsoWatch: alsoWatch))
      .state;
}

final _watchCompanies = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<Company>>, WatchArgs<Company>>((ref, args) {
  return ref.watch(companyRepositoryProvider).watchAll(
      remote: args.remote, params: args.params, headers: args.headers);
});

AutoDisposeStateNotifierStateProvider<DataState<List<Company>>> watchCompanies(
    {bool remote, Map<String, dynamic> params, Map<String, String> headers}) {
  return _watchCompanies(
          WatchArgs(remote: remote, params: params, headers: headers))
      .state;
}

extension CompanyX on Company {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Pass:
  ///  - A `BuildContext` if using Flutter with Riverpod or Provider
  ///  - Nothing if using Flutter with GetIt
  ///  - A Riverpod `ProviderContainer` if using pure Dart
  ///  - Its own [Repository<Company>]
  Company init(container) {
    final repository = container is Repository<Company>
        ? container
        : internalLocatorFn(companyRepositoryProvider, container);
    return repository.internalAdapter.initializeModel(this, save: true)
        as Company;
  }
}

extension CompanyRepositoryX on Repository<Company> {
  Future<Company> loginTest(Company model) =>
      (internalAdapter as TestMixin<Company>).loginTest(model);
}
