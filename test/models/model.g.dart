// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ModelLocalAdapter on LocalAdapter<Model> {
  static final Map<String, RelationshipMeta> kModelRelationshipMetas = {
    'company': RelationshipMeta<Company>(
      name: 'company',
      inverseName: 'models',
      type: 'companies',
      kind: 'BelongsTo',
      instance: (_) => (_ as Model).company,
    )
  };

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      kModelRelationshipMetas;

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

extension ModelRelationshipGraphNodeX on RelationshipGraphNode<Model> {
  RelationshipGraphNode<Company> get company {
    final meta = $ModelLocalAdapter.kModelRelationshipMetas['company']
        as RelationshipMeta<Company>;
    if (this is RelationshipMeta) {
      meta.parent = this as RelationshipMeta;
    }
    return meta;
  }
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
