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

// Simple implementation for testing
class SimpleFakeAdapter<T extends DataModelMixin<T>> implements Adapter<T> {
  final String _type;
  
  SimpleFakeAdapter(this._type);
  
  @override
  String get type => _type;
  
  @override
  Map<String, RelationshipMeta> get relationshipMetas => {};
  
  @override
  T deserializeLocal(Map<String, dynamic> map, {String? key}) {
    throw UnimplementedError('Not implemented for test');
  }
  
  @override
  Map<String, dynamic> serializeLocal(T model, {bool withRelationships = true}) {
    throw UnimplementedError('Not implemented for test');
  }
  
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// Provider definitions for model adapters
final modelAdapterProvider = Provider<Adapter<Model>>((ref) => 
    SimpleFakeAdapter<Model>('models'));
final cityAdapterProvider = Provider<Adapter<City>>((ref) => 
    SimpleFakeAdapter<City>('cities'));
final companyAdapterProvider = Provider<Adapter<Company>>((ref) => 
    SimpleFakeAdapter<Company>('companies'));
final employeeAdapterProvider = Provider<Adapter<Employee>>((ref) => 
    SimpleFakeAdapter<Employee>('workers'));

void setUpFn() async {
  // Initialize a container with fake storage
  container = ProviderContainer(
    overrides: [
      localStorageProvider.overrideWithValue(SimpleFakeStorage()),
    ],
  );
}

// Helper extension for tests
extension ProviderContainerX on ProviderContainer {
  Adapter<Model> get models => read(modelAdapterProvider);
  Adapter<City> get cities => read(cityAdapterProvider);
  Adapter<Company> get companies => read(companyAdapterProvider);
  Adapter<Employee> get employees => read(employeeAdapterProvider);
}

// Simple storage for tests
class SimpleFakeStorage implements LocalStorage {
  final _storage = <String, Map<String, Map<String, dynamic>>>{};
  bool isDisposed = false;
  
  @override
  String Function() get baseDirFn => () => '/fake/path';
  
  @override
  int get busyTimeout => 5000;
  
  @override
  final LocalStorageClearStrategy clear = LocalStorageClearStrategy.whenError;
  
  @override
  Future<LocalStorage> initialize({bool inIsolate = false}) async {
    return this;
  }
  
  @override
  Future<void> clearAll() async {
    _storage.clear();
  }
  
  @override
  Future<void> clearType(String type) async {
    _storage.remove(type);
  }
  
  @override
  Future<void> delete(String type, String key) async {
    _storage[type]?.remove(key);
  }
  
  @override
  Map<String, dynamic>? get(String type, String key) {
    return _storage[type]?[key];
  }
  
  @override
  Iterable<String> getKeys(String type) {
    return _storage[type]?.keys ?? [];
  }
  
  @override
  Future<void> put(String type, String key, Map<String, dynamic> value) async {
    _storage.putIfAbsent(type, () => {});
    _storage[type]![key] = value;
  }
  
  @override
  Future<void> dispose() async {
    isDisposed = true;
  }
  
  @override
  Future<void> destroy() async {
    await clearAll();
  }
  
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
  Future<void> flush() async { }


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
  void init(String? path,
      {HiveStorageBackendPreference backendPreference =
          HiveStorageBackendPreference.native}) {}

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
    String? collection,
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
