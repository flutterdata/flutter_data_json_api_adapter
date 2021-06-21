import 'package:flutter_data/flutter_data.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'models/city.dart';
import 'models/company.dart';
import 'models/employee.dart';
import 'models/model.dart';
import 'test.data.dart';

void main() async {
  late final ProviderContainer container;

  late final RemoteAdapter<Model> modelsRemoteAdapter;
  late final RemoteAdapter<City> citiesRemoteAdapter;
  late final RemoteAdapter<Company> companiesRemoteAdapter;
  late final Map<String, RemoteAdapter<DataModel>> adapters;

  setUpAll(() async {
    container = ProviderContainer(
      overrides: [
        ...flutterDataTestOverrides,
        graphNotifierProvider.overrideWithValue(GraphNotifierMock()),
      ],
    );

    adapters = {
      'models': container.read(modelsRemoteAdapterProvider),
      'cities': container.read(citiesRemoteAdapterProvider),
      'companies': container.read(companiesRemoteAdapterProvider),
      'employees': container.read(employeesRemoteAdapterProvider),
    };

    // stub check for graph for offline
    final graph = container.read(graphNotifierProvider) as GraphNotifierMock;
    when(graph.hasNode(argThat(startsWith('_offline')))).thenReturn(true);

    when(graph.getKeyForId(captureAny, captureAny,
            keyIfAbsent: captureAnyNamed('keyIfAbsent')))
        .thenAnswer((i) => i.positionalArguments.join('#'));

    final ref = container.read(_refProvider);

    modelsRemoteAdapter = await container
        .read(modelsRemoteAdapterProvider)
        .initialize(adapters: adapters, ref: ref);
    citiesRemoteAdapter = await container
        .read(citiesRemoteAdapterProvider)
        .initialize(adapters: adapters, ref: ref);
    companiesRemoteAdapter = await container
        .read(companiesRemoteAdapterProvider)
        .initialize(adapters: adapters, ref: ref);
    await container
        .read(employeesRemoteAdapterProvider)
        .initialize(adapters: adapters, ref: ref);
  });

  test('serialize', () {
    final company = Company(
      id: '23',
      name: 'Ko',
      updatedAt: DateTime.parse('2020-02-02'),
    );

    final map = companiesRemoteAdapter.serialize(company);

    expect(map, {
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

    expect(modelsRemoteAdapter.serialize(person), {
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

    final person2 = Model(
        id: '23', name: 'Ko', company: Company(id: null, name: '').asBelongsTo);

    // ignores null relationships
    expect(modelsRemoteAdapter.serialize(person2), {
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

    expect(companiesRemoteAdapter.serialize(c), {
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
    final cities = citiesRemoteAdapter.deserialize({
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
    final model = modelsRemoteAdapter.deserialize({
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
    }).model!;

    expect(
      model,
      isA<Model>()
          .having((m) => m.name, 'name', 'Ka')
          .having((m) => m.id, 'id', '1'),
    );

    // check rel type - we can't check the ID as it's graph-based
    // ignore: invalid_use_of_protected_member
    expect(model.company!.internalType, 'companies');
  });

  test(
      'deserialize with hasmany relationship (and included), fieldForKey override, singular/plural included types',
      () {
    final data = companiesRemoteAdapter.deserialize({
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
          'type': 'city',
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
    });

    final company = data.model!;
    final models = data.included;

    expect(
      company,
      isA<Company>()
          .having((m) => m.name, 'name', 'Mono Motor Co.')
          .having((m) => m.updatedAt, 'updatedAt',
              DateTime.parse('2020-12-12 12:00'))
          .having((m) => m.id, 'id', '19'),
    );

    // check rel type - we can't check IDs as it's graph-based
    // ignore: invalid_use_of_protected_member
    expect(company.models!.internalType, 'models');
    // ignore: invalid_use_of_protected_member
    expect(company.employees!.internalType, 'employees');

    expect(models, [
      isA<Model>(),
      isA<Model>(),
      isA<City>(),
      isA<Employee>(),
      isA<Employee>()
    ]);
  });

  test('deserialize with overidden type', () {
    final model = container.read(employeesRemoteAdapterProvider).deserialize({
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

  test('missing type in deserialize should be ignored (not fail)', () {
    container.read(modelsRemoteAdapterProvider).deserialize({
      'data': {
        'type': 'model',
        'id': '19',
        'attributes': {'name': 'Hector'},
      },
      'included': [
        {
          'type': 'd23dewd',
          'id': '2',
          'attributes': {'name': 'Z'},
        }
      ],
    });
  });
}

final _refProvider = Provider<ProviderReference>((ref) => ref);

class GraphNotifierMock extends Mock implements GraphNotifier {
  @override
  bool hasNode(String? key) {
    return (super.noSuchMethod(Invocation.method(#hasNode, [key]),
        returnValue: false) as bool);
  }

  @override
  String? getKeyForId(String? type, dynamic id, {String? keyIfAbsent}) =>
      (super.noSuchMethod(Invocation.method(
          #getKeyForId, [type, id], {#keyIfAbsent: keyIfAbsent})) as String?);
}
