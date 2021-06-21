import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_json_api_adapter/flutter_data_json_api_adapter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '_adapters.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
@DataRepository([JSONAPIAdapter, TestMixin])
class City with DataModel<City>, _$City {
  City._();
  factory City({
    required String id,
    required String name,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
