import 'package:json_annotation/json_annotation.dart';

part 'serializable_error.g.dart';

@JsonSerializable()
class SerializableError {
  @JsonKey(includeFromJson: false, includeToJson: true)
  final String? method;
  @JsonKey(includeFromJson: false, includeToJson: true)
  final String? url;
  final int? code;
  final String? error;
  @JsonKey(includeFromJson: false, includeToJson: true)
  final String? raw;

  const SerializableError({this.code, this.error, this.method, this.url, this.raw});

  factory SerializableError.fromJson(Map<String, dynamic> json) => _$SerializableErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SerializableErrorToJson(this);

  @override
  String toString() => 'Code: $code - $error\n$method $url\nraw - $raw';
}
