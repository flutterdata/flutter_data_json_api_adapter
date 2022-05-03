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

final _companiesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $CompanyHiveLocalAdapter = HiveLocalAdapter<Company>
    with $CompanyLocalAdapter;

class $CompanyRemoteAdapter = RemoteAdapter<Company>
    with JSONAPIAdapter<Company>, TestMixin<Company>, CaseMixin<Company>;

final internalCompaniesRemoteAdapterProvider = Provider<RemoteAdapter<Company>>(
    (ref) => $CompanyRemoteAdapter(
        $CompanyHiveLocalAdapter(ref.read), InternalHolder(_companiesFinders)));

final companiesRepositoryProvider =
    Provider<Repository<Company>>((ref) => Repository<Company>(ref.read));

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
