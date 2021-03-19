import 'package:flutter_data/flutter_data.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'models/city.dart';
import 'models/company.dart';
import 'models/employee.dart';
import 'models/model.dart';
import 'test.data.dart';

class GraphNotifierMock extends Mock implements GraphNotifier {}

void main() async {
  ProviderContainer container;

  RemoteAdapter<Model> modelRemoteAdapter;
  RemoteAdapter<City> cityRemoteAdapter;
  RemoteAdapter<Company> companyRemoteAdapter;
  Map<String, RemoteAdapter<DataModel>> adapters;

  setUp(() async {
    container = ProviderContainer(
      overrides: [
        ...flutterDataTestOverrides,
        graphProvider.overrideWithValue(GraphNotifierMock()),
      ],
    );

    adapters = {
      'models': container.read(modelRemoteAdapterProvider),
      'cities': container.read(cityRemoteAdapterProvider),
      'companies': container.read(companyRemoteAdapterProvider),
      'employees': container.read(employeeRemoteAdapterProvider),
    };

    // stub check for graph for offline
    final graph = container.read(graphProvider);
    when(graph.hasNode(argThat(startsWith('_offline')))).thenReturn(true);

    modelRemoteAdapter = await container
        .read(modelRemoteAdapterProvider)
        .initialize(adapters: adapters);
    cityRemoteAdapter = await container
        .read(cityRemoteAdapterProvider)
        .initialize(adapters: adapters);
    companyRemoteAdapter = await container
        .read(companyRemoteAdapterProvider)
        .initialize(adapters: adapters);
  });

  test('serialize', () {
    final company =
        Company(id: '23', name: 'Ko', updatedAt: DateTime.parse('2020-02-02'));
    expect(companyRemoteAdapter.serialize(company), {
      'data': {
        'type': 'companies',
        'id': '23',
        'attributes': {'name': 'Ko', 'updated_at': '2020-02-02T00:00:00.000'}
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

    final person2 =
        Model(id: '23', name: 'Ko', company: Company(id: null).asBelongsTo);

    // ignores null relationships
    expect(modelRemoteAdapter.serialize(person2), {
      'data': {
        'type': 'models',
        'id': '23',
        'attributes': {'name': 'Ko'},
      }
    });
  });

  test('serialize with has many', () {
    final c = Company(
        id: '1',
        name: 'Acme',
        employees: {Employee(id: '10', name: 'Wendy')}.asHasMany,
        models: {
          Model(id: '1', name: 'A'),
          Model(id: null),
          Model(id: '2', name: 'B')
        }.asHasMany);

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
          },
          'w': {
            'data': [
              {'type': 'workers', 'id': '10'},
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
    when(container.read(graphProvider).getKeyForId('companies', '1',
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

  test(
      'deserialize with hasmany relationship (and included) (and fieldForKey override)',
      () {
    final graphMock = container.read(graphProvider);
    when(graphMock.getKeyForId('models', '1',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('models#a1');
    when(graphMock.getKeyForId('models', '2',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('models#a2');
    when(graphMock.getKeyForId('employees', '1',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('employees#e1');
    when(graphMock.getKeyForId('employees', '2',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('employees#e2');

    final data = companyRemoteAdapter.deserialize({
      'data': {
        'type': 'companies',
        'id': '19',
        'attributes': {
          'name': 'Mono Motor Co.',
          // company has the CaseAdapter to see this as `updatedAt`
          'updated_at': '2020-12-12 12:00',
        },
        'relationships': {
          'models': {
            'data': [
              {'id': '1', 'type': 'models'},
              {'id': '2', 'type': 'models'},
            ]
          },
          'w': {
            'data': [
              {'id': '1', 'type': 'workers'},
              {'id': '2', 'type': 'workers'},
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
        },
        {
          'type': 'workers',
          'id': '1',
          'attributes': {'name': 'Sandro'},
        },
        {
          'type': 'workers',
          'id': '2',
          'attributes': {'name': 'August'},
        },
      ]
    }, init: false);

    final company = data.model;
    final models = data.included;

    expect(
      company,
      isA<Company>()
          .having((m) => m.name, 'name', 'Mono Motor Co.')
          .having((m) => m.updatedAt, 'updatedAt',
              DateTime.parse('2020-12-12 12:00'))
          .having((m) => m.id, 'id', '19'),
    );
    // need to check on keys as model/relationships are not initialized
    expect(company.models.keys, {'models#a1', 'models#a2'});
    expect(company.employees.keys, {'employees#e1', 'employees#e2'});

    expect(models, [
      isA<Model>(),
      isA<Model>(),
      isA<City>(),
      isA<Employee>(),
      isA<Employee>()
    ]);
  });

  test('deserialize with overidden type', () {
    when(container.read(graphProvider).getKeyForId('employees', '1',
            keyIfAbsent: anyNamed('keyIfAbsent')))
        .thenReturn('employees#e1');

    final model = container.read(employeeRemoteAdapterProvider).deserialize({
      'data': {
        'type': 'workers',
        'id': '19',
        'attributes': {'name': 'Hector'},
      }
    }).model;

    expect(
      model,
      isA<Employee>()
          .having((m) => m.name, 'name', 'Hector')
          .having((m) => m.id, 'id', '19'),
    );
  });
}
