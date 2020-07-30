import 'package:flutter_data/flutter_data.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'models.dart';

class GraphNotifierMock extends Mock implements GraphNotifier {}

final graphMock = GraphNotifierMock();

// ignore: must_be_immutable
class _CityLocalAdapterMock extends Mock implements LocalAdapter<City> {}

class CityLocalAdapterMock extends _CityLocalAdapterMock
    with $CityLocalAdapter {
  @override
  GraphNotifier get graph => graphMock;
}

// ignore: must_be_immutable
class _ModelLocalAdapterMock extends Mock implements LocalAdapter<Model> {}

class ModelLocalAdapterMock extends _ModelLocalAdapterMock
    with $ModelLocalAdapter {
  @override
  GraphNotifier get graph => graphMock;
}

// ignore: must_be_immutable
class _CompanyLocalAdapterMock extends Mock implements LocalAdapter<Company> {}

class CompanyLocalAdapterMock extends _CompanyLocalAdapterMock
    with $CompanyLocalAdapter {
  @override
  GraphNotifier get graph => graphMock;
}

void main() async {
  ProviderStateOwner owner;

  final cityLocalAdapter = CityLocalAdapterMock();
  final companyLocalAdapter = CompanyLocalAdapterMock();
  final modelLocalAdapter = ModelLocalAdapterMock();

  RemoteAdapter<Model> modelRemoteAdapter;
  RemoteAdapter<City> cityRemoteAdapter;
  RemoteAdapter<Company> companyRemoteAdapter;
  Map<String, RemoteAdapter<DataModel>> adapters;

  setUp(() async {
    owner = ProviderStateOwner(
      overrides: [
        companyLocalAdapterProvider
            .overrideAs(Provider((_) => companyLocalAdapter)),
        modelLocalAdapterProvider
            .overrideAs(Provider((_) => modelLocalAdapter)),
        cityLocalAdapterProvider.overrideAs(Provider((_) => cityLocalAdapter)),
      ],
    );

    adapters = {
      'models': modelRemoteAdapterProvider.readOwner(owner),
      'cities': cityRemoteAdapterProvider.readOwner(owner),
      'companies': companyRemoteAdapterProvider.readOwner(owner),
    };

    modelRemoteAdapter = await modelRemoteAdapterProvider
        .readOwner(owner)
        .initialize(adapters: adapters);
    cityRemoteAdapter = await cityRemoteAdapterProvider
        .readOwner(owner)
        .initialize(adapters: adapters);
    companyRemoteAdapter = await companyRemoteAdapterProvider
        .readOwner(owner)
        .initialize(adapters: adapters);
  });

  test('serialize', () {
    final person = Model(id: '23', name: 'Ko');
    expect(modelRemoteAdapter.serialize(person), {
      'data': {
        'type': 'models',
        'id': '23',
        'attributes': {'name': 'Ko'}
      }
    });
  });

  test('serialize with belongs to', () {
    final person = Model(
        id: '23',
        name: 'Ko',
        company: Company(id: '1', name: 'Co').asBelongsTo);

    expect(modelRemoteAdapter.serialize(person), {
      'data': {
        'type': 'models',
        'id': '23',
        'attributes': {'name': 'Ko'},
        'relationships': {
          'company': {
            'data': {'type': 'companies', 'id': '1'}
          }
        },
      }
    });
  });

  test('serialize with has many', () {
    final c = Company(
        id: '1',
        name: 'Acme',
        models:
            {Model(id: '1', name: 'A'), Model(id: '2', name: 'B')}.asHasMany);

    expect(companyRemoteAdapter.serialize(c), {
      'data': {
        'type': 'companies',
        'id': '1',
        'attributes': {'name': 'Acme'},
        'relationships': {
          'models': {
            'data': [
              {'type': 'models', 'id': '1'},
              {'type': 'models', 'id': '2'}
            ]
          }
        },
      }
    });
  });

  test('deserialize multiple', () {
    final cities = cityRemoteAdapter.deserialize({
      'data': [
        {
          'type': 'cities',
          'id': '23',
          'attributes': {'name': 'Ox'}
        },
        {
          'type': 'cities',
          'id': '26',
          'attributes': {'name': 'Nam'}
        },
      ]
    }).models;

    expect(cities, [
      City(id: '23', name: 'Ox'),
      City(id: '26', name: 'Nam'),
    ]);
  });

  test('deserialize with belongsto relationship', () {
    when(graphMock.getKeyForId('companies', '1',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('companies#a1');

    final model = modelRemoteAdapter.deserialize({
      'data': {
        'type': 'models',
        'id': '1',
        'attributes': {'name': 'Ka'},
        'relationships': {
          'company': {
            'data': {'id': '1', 'type': 'companies'}
          }
        }
      }
    }).model;

    expect(
      model,
      isA<Model>()
          .having((m) => m.name, 'name', 'Ka')
          .having((m) => m.id, 'id', '1'),
    );
    // need to check on key as model/relationships are not initialized
    expect(model.company.key, 'companies#a1');
  });

  test('deserialize with hasmany relationship (and included)', () {
    when(graphMock.getKeyForId('models', '1',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('models#a1');
    when(graphMock.getKeyForId('models', '2',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('models#a2');

    final data = companyRemoteAdapter.deserialize({
      'data': {
        'type': 'companies',
        'id': '19',
        'attributes': {'name': 'Mono Motor Co.'},
        'relationships': {
          'models': {
            'data': [
              {'id': '1', 'type': 'models'},
              {'id': '2', 'type': 'models'},
            ]
          }
        }
      },
      'included': [
        {
          'type': 'models',
          'id': '2',
          'attributes': {'name': 'Windy'},
        },
        {
          'type': 'models',
          'id': '1',
          'attributes': {'name': 'Zombie'},
        },
        {
          'type': 'cities',
          'id': '1',
          'attributes': {'name': 'Manila'},
        }
      ]
    }, init: false);

    final company = data.model;
    final models = data.included;

    expect(
      company,
      isA<Company>()
          .having((m) => m.name, 'name', 'Mono Motor Co.')
          .having((m) => m.id, 'id', '19'),
    );
    // need to check on keys as model/relationships are not initialized
    expect(company.models.keys, {'models#a1', 'models#a2'});

    expect(models, [isA<Model>(), isA<Model>(), isA<City>()]);
  });
}
