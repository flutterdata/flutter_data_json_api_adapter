// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_City _$$_CityFromJson(Map<String, dynamic> json) => _$_City(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_CityToJson(_$_City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $CityLocalAdapter on LocalAdapter<City> {
  @override
  Map<String, Map<String, Object?>> relationshipsFor([City? model]) => {};

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

final citiesLocalAdapterProvider =
    Provider<LocalAdapter<City>>((ref) => $CityHiveLocalAdapter(ref.read));

final citiesRemoteAdapterProvider = Provider<RemoteAdapter<City>>((ref) =>
    $CityRemoteAdapter(
        ref.watch(citiesLocalAdapterProvider), cityProvider, citiesProvider));

final citiesRepositoryProvider =
    Provider<Repository<City>>((ref) => Repository<City>(ref.read));

final _cityProvider = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<City?>, DataState<City?>, WatchArgs<City>>(
        (ref, args) {
  return ref.watch(citiesRepositoryProvider).watchOneNotifier(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<City?>, DataState<City?>>
    cityProvider(dynamic id,
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        AlsoWatch<City>? alsoWatch}) {
  return _cityProvider(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _citiesProvider = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<List<City>>,
    DataState<List<City>>,
    WatchArgs<City>>((ref, args) {
  return ref.watch(citiesRepositoryProvider).watchAllNotifier(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<City>>,
        DataState<List<City>>>
    citiesProvider(
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        bool? syncLocal}) {
  return _citiesProvider(WatchArgs(
      remote: remote, params: params, headers: headers, syncLocal: syncLocal));
}

extension CityDataX on City {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `ref.read`, `container.read`
  City init(Reader read, {bool save = true}) {
    final repository = internalLocatorFn(citiesRepositoryProvider, read);
    final updatedModel =
        repository.remoteAdapter.initializeModel(this, save: save);
    return save ? updatedModel : this;
  }
}

extension CityDataRepositoryX on Repository<City> {
  JSONAPIAdapter<City> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<City>;
  TestMixin<City> get testMixin => remoteAdapter as TestMixin<City>;
}
