import 'package:flutter_data/flutter_data.dart';
import 'package:test/test.dart';

import 'models/city.dart';
import 'models/company.dart';
import 'models/employee.dart';
import 'models/model.dart';
import 'setup.dart';

void main() async {
  setUp(setUpFn);

  test('serialize', () {
    final company = Company(
      id: '23',
      name: 'Ko',
      updatedAt: DateTime.parse('2020-02-02'),
    );

    final map = container.companies.remoteAdapter.serialize(company);

    expect(map, {
      'data': {
        'type': 'companies',
        'id': '23',
        'attributes': {'name': 'Ko', 'updated_at': '2020-02-02T00:00:00.000'}
      }
    });
  });

  test('serialize without ID', () {
    final company = Company(name: 'Tao');

    final map = container.companies.remoteAdapter.serialize(company);

    expect(map, {
      'data': {
        'type': 'companies',
        'id': isNotNull,
        'attributes': {'name': 'Tao'}
      }
    });
  });

  test('serialize with belongs to', () {
    final person = Model(
        id: '23',
        name: 'Ko',
        company: Company(id: '1', name: 'Co').asBelongsTo);

    expect(container.models.remoteAdapter.serialize(person), {
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
    expect(container.models.remoteAdapter.serialize(person2), {
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

    expect(container.companies.remoteAdapter.serialize(c), {
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
    final cities = container.cities.remoteAdapter.deserialize({
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
    final model = container.models.remoteAdapter.deserialize({
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
    final data = container.companies.remoteAdapter.deserialize({
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
    final model = container.employees.remoteAdapter.deserialize({
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
    container.models.remoteAdapter.deserialize({
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
