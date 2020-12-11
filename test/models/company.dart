import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_json_api_adapter/flutter_data_json_api_adapter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '_adapters.dart';
import 'employee.dart';
import 'model.dart';

part 'company.freezed.dart';
part 'company.g.dart';

@freezed
@DataRepository([JSONAPIAdapter, TestMixin, CaseMixin])
abstract class Company with DataModel<Company>, _$Company {
  Company._();
  factory Company({
    String id,
    String name,
    String nasdaq,
    DateTime updatedAt,
    HasMany<Model> models,
    @DataRelationship(remoteType: 'workers')
    @JsonKey(name: 'w')
        HasMany<Employee> employees,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
