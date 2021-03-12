// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

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

final cityLocalAdapterProvider =
    Provider<LocalAdapter<City>>((ref) => $CityHiveLocalAdapter(ref));

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

AutoDisposeStateNotifierProvider<DataStateNotifier<City>> watchCity(dynamic id,
    {bool remote = true,
    Map<String, dynamic> params = const {},
    Map<String, String> headers = const {},
    AlsoWatch<City> alsoWatch}) {
  return _watchCity(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _watchCities = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<List<City>>, WatchArgs<City>>((ref, args) {
  ref.maintainState = false;
  return ref.watch(cityRepositoryProvider).watchAll(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      filterLocal: args.filterLocal,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<City>>> watchCities(
    {bool remote, Map<String, dynamic> params, Map<String, String> headers}) {
  return _watchCities(
      WatchArgs(remote: remote, params: params, headers: headers));
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
