// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $CompanyLocalAdapter on LocalAdapter<Company> {
  static final Map<String, RelationshipMeta> _kCompanyRelationshipMetas = {
    'models': RelationshipMeta<Model>(
      name: 'models',
      inverseName: 'company',
      type: 'models',
      kind: 'HasMany',
      instance: (_) => (_ as Company).models,
    ),
    'w': RelationshipMeta<Employee>(
      name: 'employees',
      type: 'employees',
      kind: 'HasMany',
      instance: (_) => (_ as Company).employees,
    )
  };

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kCompanyRelationshipMetas;

  @override
  Company deserialize(map) {
    map = transformDeserialize(map);
    return Company.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _companiesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $CompanyHiveLocalAdapter = HiveLocalAdapter<Company>
    with $CompanyLocalAdapter;

class $CompanyRemoteAdapter = RemoteAdapter<Company>
    with JSONAPIAdapter<Company>, TestMixin<Company>;

final internalCompaniesRemoteAdapterProvider = Provider<RemoteAdapter<Company>>(
    (ref) => $CompanyRemoteAdapter(
        $CompanyHiveLocalAdapter(ref), InternalHolder(_companiesFinders)));

final companiesRepositoryProvider =
    Provider<Repository<Company>>((ref) => Repository<Company>(ref));

extension CompanyDataRepositoryX on Repository<Company> {
  JSONAPIAdapter<Company> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<Company>;
  TestMixin<Company> get testMixin => remoteAdapter as TestMixin<Company>;
}

extension CompanyRelationshipGraphNodeX on RelationshipGraphNode<Company> {
  RelationshipGraphNode<Model> get models {
    final meta = $CompanyLocalAdapter._kCompanyRelationshipMetas['models']
        as RelationshipMeta<Model>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }

  RelationshipGraphNode<Employee> get employees {
    final meta = $CompanyLocalAdapter._kCompanyRelationshipMetas['w']
        as RelationshipMeta<Employee>;
    return meta.clone(
        parent: this is RelationshipMeta ? this as RelationshipMeta : null);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Company _$$_CompanyFromJson(Map<String, dynamic> json) => _$_Company(
      id: json['id'] as String?,
      name: json['name'] as String,
      nasdaq: json['nasdaq'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
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
      'updated_at': instance.updatedAt?.toIso8601String(),
      'models': instance.models,
      'w': instance.employees,
    };
