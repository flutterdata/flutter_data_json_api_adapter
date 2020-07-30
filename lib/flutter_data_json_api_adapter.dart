library flutter_data_json_api_adapter;

import 'dart:async';

import 'package:flutter_data/flutter_data.dart';
import 'package:json_api/document.dart';

/// Flutter Data adapter for JSON:API.
///
/// Example usage:
///
/// ```
/// @JsonSerializable()
/// @DataRepository([JSONAPIAdapter, MyJSONAPIAdapter])
/// class User with DataModel<User> {
///   @override
///   final int id;
///   final String name;
///   User({this.id, this.name});
/// }
///
/// mixin MyJSONAPIAdapter on RemoteAdapter<User> {
///   @override
///   String get baseUrl => "https://my.jsonapi.server/api";
///
///   // other customizations
/// }
/// ```
mixin JSONAPIAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  FutureOr<Map<String, String>> get defaultHeaders async {
    return await super.defaultHeaders &
        {
          'Content-Type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
        };
  }

  @override
  String keyForField(String field) => field;

  @override
  String fieldForKey(String key) => key;

  /// Transforms native format into JSON:API
  @override
  Map<String, dynamic> serialize(final model) {
    final map = localAdapter.serialize(model).filterNulls;

    final relationships = <String, dynamic>{};

    for (final relEntry in localAdapter.relationshipsFor(model).entries) {
      final field = relEntry.key;
      final relType = relEntry.value['type'] as String;
      final key = keyForField(field);

      if (map[field] != null) {
        if (map[field] is HasMany) {
          final identifiers = map[field].toSet().map((m) {
            return IdentifierObject(relType, m.id).toJson();
          }).toList();
          relationships[key] = {'data': identifiers};
        }
        if (map[field] is BelongsTo) {
          relationships[key] = {
            'data': IdentifierObject(relType, map[field].value.id).toJson(),
          };
        }
      }
      map.remove(field);
    }

    final id = map.remove('id');
    final resource = ResourceObject(type, id?.toString(), attributes: map);

    final document = Document(ResourceData(resource)).toJson();

    // serialize relationships separately as passing them
    // through json_api ResourceObject does not call toJson() on them

    if (relationships.isNotEmpty) {
      (document['data'] as Map)['relationships'] = relationships;
    }
    return document;
  }

  /// Transforms JSON:API into native format (with included resources)
  @override
  DeserializedData<T, DataModel<dynamic>> deserialize(dynamic data,
      {bool init, String key}) {
    final result = DeserializedData<T, DataModel<dynamic>>([], included: []);
    ResourceCollectionData collectionData;
    init ??= false;

    if (data is ResourceCollectionData) {
      collectionData = data;
    }
    // single resource object (used when deserializing includes)
    if (data is ResourceObject) {
      collectionData = ResourceCollectionData([data]);
    } else {
      try {
        if (data is Map && data['data'] is List) {
          // multiple document json
          collectionData = ResourceCollectionData.fromJson(data);
        } else {
          // single document json
          final resourceData = ResourceData.fromJson(data);
          collectionData = ResourceCollectionData([resourceData.resourceObject],
              included: resourceData.included);
        }
      } catch (err, stack) {
        throw DataException('Invalid JSON:API, $err', stackTrace: stack);
      }
    }

    if (collectionData?.included != null) {
      for (final include in collectionData.included) {
        final _type = DataHelpers.getType(include.type);
        final model = adapters[_type]?.deserialize(include, init: init)?.model;
        result.included.add(model);
      }
    }

    for (final obj in collectionData.collection) {
      final mapOut = <String, dynamic>{};

      mapOut['id'] = obj.id;

      if (obj.relationships != null) {
        for (final relEntry in obj.relationships.entries) {
          final rel = relEntry.value;
          final mapOutKey = fieldForKey(relEntry.key);

          if (rel is ToOne && rel.linkage?.id != null) {
            final key = graph.getKeyForId(rel.linkage.type, rel.linkage.id,
                keyIfAbsent: DataHelpers.generateKey(rel.linkage.type));
            mapOut[mapOutKey] = key;
          }

          if (rel is ToMany) {
            mapOut[mapOutKey] = rel.linkage
                .map((i) => i.id == null
                    ? null
                    : graph.getKeyForId(i.type, i.id,
                        keyIfAbsent: DataHelpers.generateKey(i.type)))
                .toList();
          }
        }
        mapOut.addAll(obj.attributes);
      }

      final model = localAdapter.deserialize(mapOut);
      if (init) {
        initializeModel(model, key: key, save: true);
      }
      result.models.add(model);
    }

    return result;
  }
}

extension _MapX on Map<String, dynamic> {
  Map<String, dynamic> get filterNulls =>
      {for (final e in entries) if (e.value != null) e.key: e.value};
}
