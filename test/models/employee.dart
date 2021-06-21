import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_json_api_adapter/flutter_data_json_api_adapter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '_adapters.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
@DataRepository([JSONAPIAdapter, TestMixin, EmployeeMixin])
class Employee with DataModel<Employee>, _$Employee {
  Employee._();
  factory Employee({
    required String id,
    required String name,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}

mixin EmployeeMixin on RemoteAdapter<Employee> {
  @override
  String get type => 'workers';
}
