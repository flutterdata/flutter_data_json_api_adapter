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

final modelLocalAdapterProvider = RiverpodAlias.provider<LocalAdapter<Model>>(
    (ref) => $ModelHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final modelRemoteAdapterProvider = RiverpodAlias.provider<RemoteAdapter<Model>>(
    (ref) => $ModelRemoteAdapter(ref.read(modelLocalAdapterProvider)));

final modelRepositoryProvider =
    RiverpodAlias.provider<Repository<Model>>((_) => Repository<Model>());

extension ModelX on Model {
  Model init(owner) {
    return internalLocatorFn(modelRepositoryProvider, owner)
        .internalAdapter
        .initializeModel(this, save: true) as Model;
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

final cityLocalAdapterProvider = RiverpodAlias.provider<LocalAdapter<City>>(
    (ref) => $CityHiveLocalAdapter(
        ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final cityRemoteAdapterProvider = RiverpodAlias.provider<RemoteAdapter<City>>(
    (ref) => $CityRemoteAdapter(ref.read(cityLocalAdapterProvider)));

final cityRepositoryProvider =
    RiverpodAlias.provider<Repository<City>>((_) => Repository<City>());

extension CityX on City {
  City init(owner) {
    return internalLocatorFn(cityRepositoryProvider, owner)
        .internalAdapter
        .initializeModel(this, save: true) as City;
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

final companyLocalAdapterProvider =
    RiverpodAlias.provider<LocalAdapter<Company>>((ref) =>
        $CompanyHiveLocalAdapter(
            ref.read(hiveLocalStorageProvider), ref.read(graphProvider)));

final companyRemoteAdapterProvider =
    RiverpodAlias.provider<RemoteAdapter<Company>>(
        (ref) => $CompanyRemoteAdapter(ref.read(companyLocalAdapterProvider)));

final companyRepositoryProvider =
    RiverpodAlias.provider<Repository<Company>>((_) => Repository<Company>());

extension CompanyX on Company {
  Company init(owner) {
    return internalLocatorFn(companyRepositoryProvider, owner)
        .internalAdapter
        .initializeModel(this, save: true) as Company;
  }
}

extension CompanyRepositoryX on Repository<Company> {
  Future<Company> loginTest(Company model) =>
      (internalAdapter as TestMixin<Company>).loginTest(model);
}
