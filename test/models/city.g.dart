// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $CityLocalAdapter on LocalAdapter<City> {
  static final Map<String, RelationshipMeta> _kCityRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kCityRelationshipMetas;

  @override
  City deserialize(map) {
    map = transformDeserialize(map);
    return City.fromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = model.toJson();
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _citiesFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $CityHiveLocalAdapter = HiveLocalAdapter<City> with $CityLocalAdapter;

class $CityRemoteAdapter = RemoteAdapter<City>
    with JSONAPIAdapter<City>, TestMixin<City>;

final internalCitiesRemoteAdapterProvider = Provider<RemoteAdapter<City>>(
    (ref) => $CityRemoteAdapter(
        $CityHiveLocalAdapter(ref.read), InternalHolder(_citiesFinders)));

final citiesRepositoryProvider =
    Provider<Repository<City>>((ref) => Repository<City>(ref.read));

extension CityDataRepositoryX on Repository<City> {
  JSONAPIAdapter<City> get jSONAPIAdapter =>
      remoteAdapter as JSONAPIAdapter<City>;
  TestMixin<City> get testMixin => remoteAdapter as TestMixin<City>;
}

extension CityRelationshipGraphNodeX on RelationshipGraphNode<City> {}

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
