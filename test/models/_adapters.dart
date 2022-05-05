import 'dart:async';

import 'package:flutter_data/flutter_data.dart';

mixin TestMixin<T extends DataModel<T>> on RemoteAdapter<T> {
  @override
  String get baseUrl => 'http://127.0.0.1:17083/';

  @override
  FutureOr<Map<String, dynamic>> get defaultParams => {
        'page': {'limit': 10}
      };

  @override
  FutureOr<Map<String, String>> get defaultHeaders =>
      {'x-client-id': '2473272'};

  // test random method
  Future<T?> loginTest(T model) async {
    return null;
  }
}
