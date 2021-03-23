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
  Map<String, dynamic> serialize(final T model) {
    final map = localAdapter.serialize(model).filterNulls;

    final relationships = <String, dynamic>{};

    for (final relEntry in localAdapter.relationshipsFor(model).entries) {
      final field = relEntry.key;
      final _type = _typeFor(relEntry.value['type'] as String);
      final key = keyForField(field);

      if (map[field] != null) {
        if (map[field] is HasMany) {
          final identifiers =
              map[field].where((m) => m.id != null).toSet().map((m) {
            return IdentifierObject(_type, m.id).toJson();
          }).toList();
          relationships[key] = {'data': identifiers};
        }
        if (map[field] is BelongsTo) {
          final rel = map[field] as BelongsTo;
          if (rel.value?.id != null) {
            relationships[key] = {
              'data': IdentifierObject(_type, map[field].value.id).toJson(),
            };
          }
        }
      }
      map.remove(field);
    }

    final id = map.remove('id');
    final renamedMap = Map.fromEntries(
        map.entries.map((e) => MapEntry(keyForField(e.key), e.value)));

    final resource =
        ResourceObject(type, id?.toString(), attributes: renamedMap);

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
  DeserializedData<T, DataModel> deserialize(dynamic data,
      {bool init, String key}) {
    final result = DeserializedData<T, DataModel>([], included: []);
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
        final _internalType = _internalTypeFor(include.type);
        if (adapters.containsKey(_internalType)) {
          final model =
              adapters[_internalType].deserialize(include, init: init).model;
          result.included.add(model);
        }
      }
    }

    for (final obj in collectionData.collection) {
      final mapOut = <String, dynamic>{};

      mapOut['id'] = obj.id;

      for (final relEntry in (obj.relationships ?? {}).entries) {
        final rel = relEntry.value;
        final mapOutKey = fieldForKey(relEntry.key);

        if (rel is ToOne && rel.linkage?.id != null) {
          final _internalType = _internalTypeFor(rel.linkage.type);
          final key = graph.getKeyForId(_internalType, rel.linkage.id,
              keyIfAbsent: DataHelpers.generateKey(_internalType));
          mapOut[mapOutKey] = key;
        }

        if (rel is ToMany) {
          mapOut[mapOutKey] = rel.linkage.map((i) {
            final _internalType = _internalTypeFor(i.type);
            return i.id == null
                ? null
                : graph.getKeyForId(_internalType, i.id,
                    keyIfAbsent: DataHelpers.generateKey(_internalType));
          }).toList();
        }
      }

      for (final attrEntry in obj.attributes.entries) {
        mapOut[fieldForKey(attrEntry.key)] = attrEntry.value;
      }

      final model = localAdapter.deserialize(mapOut);
      if (init) {
        initializeModel(model, key: key, save: true);
      }
      result.models.add(model);
    }

    return result;
  }

  String _internalTypeFor(String type) {
    final _a = adapters.values.where((adapter) =>
        adapter.type == type || adapter.type == DataHelpers.getType(type));
    return _a.isNotEmpty ? _a.first.internalType : DataHelpers.getType(type);
  }

  String _typeFor(String internalType) {
    final _a = adapters.values
        .where((adapter) => adapter.internalType == internalType);
    return _a.isNotEmpty ? _a.first.type : internalType;
  }
}

extension _MapX on Map<String, dynamic> {
  Map<String, dynamic> get filterNulls => {
        for (final e in entries)
          if (e.value != null) e.key: e.value
      };
}
