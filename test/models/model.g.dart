// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) {
  return Model(
    id: json['id'] as String?,
    name: json['name'] as String?,
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

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, non_constant_identifier_names

mixin $ModelLocalAdapter on LocalAdapter<Model> {
  @override
  Map<String, Map<String, Object?>> relationshipsFor([Model? model]) => {
        'company': {
          'name': 'company',
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

final modelsLocalAdapterProvider =
    Provider<LocalAdapter<Model>>((ref) => $ModelHiveLocalAdapter(ref));

final modelsRemoteAdapterProvider = Provider<RemoteAdapter<Model>>(
    (ref) => $ModelRemoteAdapter(ref.read(modelsLocalAdapterProvider)));

final modelsRepositoryProvider =
    Provider<Repository<Model>>((ref) => Repository<Model>(ref));

final _watchModel = StateNotifierProvider.autoDispose
    .family<DataStateNotifier<Model?>, DataState<Model?>, WatchArgs<Model>>(
        (ref, args) {
  return ref.read(modelsRepositoryProvider).watchOne(args.id,
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      alsoWatch: args.alsoWatch);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<Model?>, DataState<Model?>>
    watchModel(dynamic id,
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers,
        AlsoWatch<Model>? alsoWatch}) {
  return _watchModel(WatchArgs(
      id: id,
      remote: remote,
      params: params,
      headers: headers,
      alsoWatch: alsoWatch));
}

final _watchModels = StateNotifierProvider.autoDispose.family<
    DataStateNotifier<List<Model>>,
    DataState<List<Model>>,
    WatchArgs<Model>>((ref, args) {
  ref.maintainState = false;
  return ref.read(modelsRepositoryProvider).watchAll(
      remote: args.remote,
      params: args.params,
      headers: args.headers,
      filterLocal: args.filterLocal,
      syncLocal: args.syncLocal);
});

AutoDisposeStateNotifierProvider<DataStateNotifier<List<Model>>,
        DataState<List<Model>>>
    watchModels(
        {bool? remote,
        Map<String, dynamic>? params,
        Map<String, String>? headers}) {
  return _watchModels(
      WatchArgs(remote: remote, params: params, headers: headers));
}

extension ModelX on Model {
  /// Initializes "fresh" models (i.e. manually instantiated) to use
  /// [save], [delete] and so on.
  ///
  /// Can be obtained via `context.read`, `ref.read`, `container.read`
  Model init(Reader read) {
    final repository = internalLocatorFn(modelsRepositoryProvider, read);
    return repository.remoteAdapter.initializeModel(this, save: true);
  }
}
