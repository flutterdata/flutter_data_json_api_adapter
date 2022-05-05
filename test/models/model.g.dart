// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

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
    map = transformDeserialize(map);
    return _$ModelFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$ModelToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _modelsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $ModelHiveLocalAdapter = HiveLocalAdapter<Model> with $ModelLocalAdapter;

class $ModelRemoteAdapter = RemoteAdapter<Model>
    with JSONAPIAdapter<Model>, TestMixin<Model>;

final internalModelsRemoteAdapterProvider = Provider<RemoteAdapter<Model>>(
    (ref) => $ModelRemoteAdapter(
        $ModelHiveLocalAdapter(ref.read), InternalHolder(_modelsFinders)));

final modelsRepositoryProvider =
    Provider<Repository<Model>>((ref) => Repository<Model>(ref.read));

extension ModelDataRepositoryX on Repository<Model> {
  JSONAPIAdapter<Model> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<Model>;
  TestMixin<Model> get testMixin => remoteAdapter as TestMixin<Model>;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      id: json['id'] as String?,
      name: json['name'] as String?,
      company: json['company'] == null
          ? null
          : BelongsTo<Company>.fromJson(
              json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
    };
