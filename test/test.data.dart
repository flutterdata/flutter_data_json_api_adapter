

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'dart:async';

import 'package:flutter_data/flutter_data.dart';
import 'package:hive/hive.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'models/city.dart';
import 'models/employee.dart';
import 'models/model.dart';
import 'models/company.dart';

// test support

// ignore: must_be_immutable
class $TestCityLocalAdapter = $CityHiveLocalAdapter
    with TestHiveLocalAdapter<City>;
class TestCityRemoteAdapter = $CityRemoteAdapter with TestRemoteAdapter;


// ignore: must_be_immutable
class $TestEmployeeLocalAdapter = $EmployeeHiveLocalAdapter
    with TestHiveLocalAdapter<Employee>;
class TestEmployeeRemoteAdapter = $EmployeeRemoteAdapter with TestRemoteAdapter;


// ignore: must_be_immutable
class $TestModelLocalAdapter = $ModelHiveLocalAdapter
    with TestHiveLocalAdapter<Model>;
class TestModelRemoteAdapter = $ModelRemoteAdapter with TestRemoteAdapter;


// ignore: must_be_immutable
class $TestCompanyLocalAdapter = $CompanyHiveLocalAdapter
    with TestHiveLocalAdapter<Company>;
class TestCompanyRemoteAdapter = $CompanyRemoteAdapter with TestRemoteAdapter;


final flutterDataTestOverrides = [
  hiveLocalStorageProvider
    .overrideWithProvider(Provider((_) => TestHiveLocalStorage())),
  graphNotifierProvider.overrideWithProvider(Provider(
    (ref) => TestDataGraphNotifier(ref.read(hiveLocalStorageProvider)))),
  citiesLocalAdapterProvider.overrideWithProvider(Provider((ref) =>
    $TestCityLocalAdapter(ref))),
citiesRemoteAdapterProvider.overrideWithProvider(Provider((ref) =>
    TestCityRemoteAdapter(ref.read(citiesLocalAdapterProvider)))),

employeesLocalAdapterProvider.overrideWithProvider(Provider((ref) =>
    $TestEmployeeLocalAdapter(ref))),
employeesRemoteAdapterProvider.overrideWithProvider(Provider((ref) =>
    TestEmployeeRemoteAdapter(ref.read(employeesLocalAdapterProvider)))),

modelsLocalAdapterProvider.overrideWithProvider(Provider((ref) =>
    $TestModelLocalAdapter(ref))),
modelsRemoteAdapterProvider.overrideWithProvider(Provider((ref) =>
    TestModelRemoteAdapter(ref.read(modelsLocalAdapterProvider)))),

companiesLocalAdapterProvider.overrideWithProvider(Provider((ref) =>
    $TestCompanyLocalAdapter(ref))),
companiesRemoteAdapterProvider.overrideWithProvider(Provider((ref) =>
    TestCompanyRemoteAdapter(ref.read(companiesLocalAdapterProvider)))),

];

// fakes, mocks & mixins

class FakeBox<T> extends Fake implements Box<T> {
  final _map = <dynamic, T>{};

  @override
  bool isOpen = true;

  @override
  T? get(key, {T? defaultValue}) {
    return _map[key] ?? defaultValue;
  }

  @override
  Future<void> put(key, T value) async {
    _map[key] = value;
  }

  @override
  Future<void> delete(key) async {
    _map.remove(key);
  }

  @override
  Map<dynamic, T> toMap() => _map;

  @override
  Iterable get keys => _map.keys;

  @override
  Iterable<T> get values => _map.values;

  @override
  bool containsKey(key) => _map.containsKey(key);

  @override
  int get length => _map.length;

  @override
  Future<void> deleteFromDisk() async {
    await clear();
  }

  @override
  bool get isEmpty => length == 0;

  @override
  bool get isNotEmpty => !isEmpty;

  @override
  Future<int> clear() {
    _map.clear();
    return Future.value(0);
  }

  @override
  Future<void> close() async {
    isOpen = false;
  }
}

class HiveMock extends Mock implements HiveInterface {
  @override
  bool isBoxOpen(String name) => true;

  @override
  void init(String path) {
    return;
  }
}

class Listener<T> extends Mock {
  void call(T value);
}

mixin TestMetaBox on GraphNotifier {
  @override
  // ignore: must_call_super
  Future<GraphNotifier> initialize() async {
    box = FakeBox<Map>();
    await super.initialize();
    return this;
  }
}

class TestDataGraphNotifier = GraphNotifier with TestMetaBox;

class TestHiveLocalStorage extends HiveLocalStorage {
  @override
  HiveInterface get hive => HiveMock();

  @override
  HiveAesCipher? get encryptionCipher => null;

  @override
  Future<String> Function() get baseDirFn => () async => '';
}

mixin TestHiveLocalAdapter<T extends DataModel<T>> on HiveLocalAdapter<T> {
  @override
  // ignore: must_call_super
  Future<TestHiveLocalAdapter<T>> initialize() async {
    box = FakeBox<T>();
    await super.initialize();
    return this;
  }
}

mixin TestRemoteAdapter<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  Duration get throttleDuration => Duration.zero;

  @override
  String get baseUrl => '';

  @override
  http.Client get httpClient {
    return MockClient((req) async {
      try {
        return ref.watch(mockResponseProvider(req));
      } on ProviderException catch (e) {
        // unwrap provider exception
        // ignore: only_throw_errors
        throw e.exception;
      }
    });
  }
}

final mockResponseProvider =
    Provider.family<http.Response, http.Request>((ref, req) {
  throw UnsupportedError('Please override mockResponseProvider!');
});

