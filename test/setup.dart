import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_data/flutter_data.dart';
import 'package:hive/hive.dart';
import 'package:hive/src/box/default_compaction_strategy.dart';
import 'package:hive/src/box/default_key_comparator.dart';
import 'package:mockito/mockito.dart';

import 'models/city.dart';
import 'models/company.dart';
import 'models/employee.dart';
import 'models/model.dart';

late ProviderContainer container;

void setUpFn() async {
  container = ProviderContainer(
    overrides: [
      hiveProvider.overrideWithValue(HiveFake()),
      // graphNotifierProvider.overrideWithValue(GraphNotifierMock()),
    ],
  );

  await container.read(graphNotifierProvider).initialize();

  final adapterGraph = <String, RemoteAdapter<DataModel>>{
    'models': container.read(internalModelsRemoteAdapterProvider),
    'cities': container.read(internalCitiesRemoteAdapterProvider),
    'companies': container.read(internalCompaniesRemoteAdapterProvider),
    'employees': container.read(internalEmployeesRemoteAdapterProvider),
  };

  internalRepositories['models'] = await container
      .read(modelsRepositoryProvider)
      .initialize(remote: false, adapters: adapterGraph);
  internalRepositories['companies'] = await container
      .read(companiesRepositoryProvider)
      .initialize(remote: false, adapters: adapterGraph);
  internalRepositories['cities'] = await container
      .read(citiesRepositoryProvider)
      .initialize(remote: false, adapters: adapterGraph);
  internalRepositories['employees'] = await container
      .read(employeesRepositoryProvider)
      .initialize(remote: false, adapters: adapterGraph);
}

// home baked watcher
E _watch<E>(ProviderListenable<E> provider) {
  return container.readProviderElement(provider as ProviderBase<E>).readSelf();
}

extension ProviderContainerX on ProviderContainer {
  Repository<Model> get models =>
      _watch(modelsRepositoryProvider)..remoteAdapter.internalWatch = _watch;
  Repository<City> get cities =>
      _watch(citiesRepositoryProvider)..remoteAdapter.internalWatch = _watch;
  Repository<Company> get companies =>
      _watch(companiesRepositoryProvider)..remoteAdapter.internalWatch = _watch;
  Repository<Employee> get employees =>
      _watch(employeesRepositoryProvider)..remoteAdapter.internalWatch = _watch;
}

// hive fakes

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

class HiveFake extends Fake implements HiveInterface {
  final _boxes = <String, Box>{};

  @override
  bool isBoxOpen(String name) => _boxes[name]?.isOpen ?? false;

  @override
  void init(String path) {}

  @override
  Future<bool> boxExists(String name, {String? path}) async =>
      _boxes.containsKey(name);

  @override
  Future<Box<E>> openBox<E>(
    String name, {
    HiveCipher? encryptionCipher,
    KeyComparator keyComparator = defaultKeyComparator,
    CompactionStrategy compactionStrategy = defaultCompactionStrategy,
    bool crashRecovery = true,
    String? path,
    Uint8List? bytes,
    @Deprecated('Use encryptionCipher instead') List<int>? encryptionKey,
  }) async {
    final box = FakeBox<E>();
    _boxes[name] = box;
    return box;
  }

  @override
  Future<void> deleteBoxFromDisk(String name, {String? path}) async {
    _boxes.remove(name);
  }

  @override
  bool isAdapterRegistered(int typeId) {
    return true;
  }
}
