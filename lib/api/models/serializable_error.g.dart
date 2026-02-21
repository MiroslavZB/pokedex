// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializable_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerializableError _$SerializableErrorFromJson(Map<String, dynamic> json) =>
    SerializableError(
      code: (json['code'] as num?)?.toInt(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$SerializableErrorToJson(SerializableError instance) =>
    <String, dynamic>{
      'method': instance.method,
      'url': instance.url,
      'code': instance.code,
      'error': instance.error,
      'raw': instance.raw,
    };
