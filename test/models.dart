import 'dart:async';

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_json_api_adapter/flutter_data_json_api_adapter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@JsonSerializable()
@DataRepository([JSONAPIAdapter, TestMixin])
class Model with DataModel<Model> {
  @override
  final String id;
  final String name;
  final BelongsTo<Company> company;

  Model({this.id, this.name, this.company});
}

@freezed
@DataRepository([JSONAPIAdapter, TestMixin])
abstract class City with DataModel<City>, _$City {
  City._();
  factory City({
    String id,
    String name,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@freezed
@DataRepository([JSONAPIAdapter, TestMixin])
abstract class Employee with DataModel<Employee>, _$Employee {
  Employee._();
  factory Employee({
    String id,
    String name,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}

@freezed
@DataRepository([JSONAPIAdapter, TestMixin])
abstract class Company with DataModel<Company>, _$Company {
  Company._();
  factory Company({
    String id,
    String name,
    String nasdaq,
    DateTime updatedAt,
    HasMany<Model> models,
    // @DataRelationship(remoteType: 'workers')
    // @JsonKey(name: 'w')
    //     HasMany<Employee> employees,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

//

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
  Future<T> loginTest(T model) {
    return null;
  }
}
