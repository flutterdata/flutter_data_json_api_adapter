library flutter_data_json_api_adapter;

import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_data/flutter_data.dart' hide Relationship;
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

  /// Transforms native format into JSON:API
  @override
  Future<Map<String, dynamic>> serialize(T model,
      {bool withRelationships = true}) async {
    var map =
        await super.serialize(model, withRelationships: withRelationships);
    map = map.filterNulls;

    // relationships
    final relationships = <String, Relationship>{};

    for (final relEntry in localAdapter.relationshipMetas.entries) {
      final key = relEntry.key;
      final type = _typeFor(relEntry.value.type);

      if (map[key] is Iterable) {
        final identifiers = (map[key] as Iterable<Object>).map((id) {
          return Identifier(type, id.toString());
        }).toList();
        relationships[key] = ToMany(identifiers);
      } else if (map[key] != null) {
        relationships[key] = ToOne(Identifier(type, map[key].toString()));
      }
      map.remove(key);
    }

    // id
    final id = map.remove('id');

    // attributes
    final attributes = Map.fromEntries(
      map.entries.map((e) => MapEntry(e.key, e.value)),
    );

    // assemble type, id, attributes, relationships in `Resource`
    final resource = NewResource(_typeFor(internalType), id?.toString());
    resource.attributes.addAll(attributes);
    resource.relationships.addAll(relationships);

    // add resource to a document
    final outbound = OutboundDataDocument.newResource(resource).toJson();

    // run decode/encode because `json_api`'s `toJson()`
    // DOES NOT return nested Map<String, dynamic>s as expected
    return json.decode(json.encode(outbound)) as Map<String, dynamic>;
  }

  /// Transforms JSON:API into native format (with included resources)
  @override
  Future<DeserializedData<T>> deserialize(Object? data, {String? key}) async {
    final result = DeserializedData<T>([], included: []);
    final collection = ResourceCollection();

    if (data is! Iterable<Resource>) {
      // if data is not already formatted, parse
      try {
        final inbound = InboundDocument(data as Map);
        final isSingle = inbound.json['data'] is Map;
        if (isSingle) {
          collection.add(inbound.dataAsResource());
        } else {
          collection.addAll(inbound.dataAsCollection());
        }

        // group by type
        final grouped = groupBy<Resource, String>(
            inbound.included(), (r) => _internalTypeFor(r.type));

        for (final e in grouped.entries) {
          final internalType = e.key;
          if (adapters.containsKey(internalType)) {
            final data = await adapters[internalType]!.deserialize(e.value);
            result.included
                .addAll(List<DataModel<DataModel>>.from(data.models));
          }
        }
      } catch (err, stack) {
        throw DataException('Invalid JSON:API, $err', stackTrace: stack);
      }
    } else {
      // if data was already formatted, add to collection
      collection.addAll(data);
    }

    // process resources in collection
    for (final resource in collection) {
      final mapOut = <String, dynamic>{};

      mapOut['id'] = resource.id;

      for (final relEntry in (resource.relationships).entries) {
        final rel = relEntry.value;
        final mapOutKey = relEntry.key;

        if (rel is ToOne && rel.identifier != null) {
          final key = rel.identifier!.id;
          mapOut[mapOutKey] = key;
        }

        if (rel is ToMany) {
          mapOut[mapOutKey] = rel.map((i) {
            return i.id;
          }).toList();
        }
      }

      for (final attrEntry in resource.attributes.entries) {
        mapOut[attrEntry.key] = attrEntry.value;
      }

      final data = await super.deserialize(mapOut);
      result.models.addAll(data.models);
    }

    return result;
  }

  String _internalTypeFor(String type) {
    final adapterForType = adapters.values
        .where((adapter) =>
            adapter.type == type ||
            adapter.type == DataHelpers.internalTypeFor(type))
        // ignore: invalid_use_of_visible_for_testing_member
        .safeFirst;
    return adapterForType?.internalType ?? DataHelpers.internalTypeFor(type);
  }

  String _typeFor(String internalType) {
    final adapterForType = adapters.values
        .where((adapter) => adapter.internalType == internalType)
        // ignore: invalid_use_of_visible_for_testing_member
        .safeFirst;
    return adapterForType?.type ?? internalType;
  }
}

extension _MapX on Map<String, dynamic> {
  Map<String, dynamic> get filterNulls => {
        for (final e in entries)
          if (e.value != null) e.key: e.value
      };
}
