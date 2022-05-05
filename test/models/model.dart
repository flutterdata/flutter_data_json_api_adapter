import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_json_api_adapter/flutter_data_json_api_adapter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '_adapters.dart';
import 'company.dart';

part 'model.g.dart';

@JsonSerializable()
@DataRepository([JSONAPIAdapter, TestMixin])
class Model extends DataModel<Model> {
  @override
  final String? id;
  final String? name;
  final BelongsTo<Company>? company;

  Model({this.id, this.name, this.company});
}
