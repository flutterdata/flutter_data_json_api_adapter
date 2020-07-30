# flutter_data_json_api_adapter

[JSON:API](https://jsonapi.org/) adapter for [Flutter Data](https://flutterdata.dev).

## 👩🏾‍💻 Usage

Add `flutter_data_json_api_adapter` to your `pubspec.yaml` and then import the adapter into your models.

Example:

```dart
@JsonSerializable()
@DataRepository([JSONAPIAdapter, MyJSONAPIAdapter])
class User with DataModel<User> {
  @override
  final int id;
  final String name;
  User({this.id, this.name});
}

mixin MyJSONAPIAdapter on RemoteAdapter<User> {
  @override
  String get baseUrl => "https://my.jsonapi.server/api";

  // other customizations
}
```

This adapter provides default `application/vnd.api+json` headers.

Tests can be run with: `pub run test`

## 📝 License

See [LICENSE](https://github.com/flutterdata/flutter_data/blob/master/LICENSE).