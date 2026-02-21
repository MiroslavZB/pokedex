import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:pokedex/api/models/serializable_error.dart';
import 'package:pokedex/api/serialization_factories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class SerializableConverter extends JsonConverter {
  const SerializableConverter();

  @override
  Request convertRequest(Request request) => super.convertRequest(
    request.copyWith(
      body: serializationFactories[request.body.runtimeType] != null ? request.body.toJson() : request.body,
    ),
  );

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(Response response) async {
    final resp = await super.convertResponse(response);

    log('RAW Response: ${resp.body}');

    if (resp.body is Map && serializationFactories.containsKey(Item)) {
      final values = (resp.body as Map<String, dynamic>).values;

      final data = values.length == 1 ? values.first : values;

      if (data is Map<String, dynamic> || data is List) {
        return resp.copyWith<ResultType>(body: _decode<Item>(data));
      }
    }

    return resp.copyWith<ResultType>(body: _decode<Item>(resp.body));
  }

  @override
  FutureOr<Response> convertError<ResultType, Item>(Response response) async {
    final resp = await super.convertResponse(response);

    log('RAW Error: ${response.base.request?.method} ${response.base.request?.url} ${resp.body}');

    String? message;
    try {
      message = (resp.body as Map<String, dynamic>?)?['error']?.toString();
    } catch (_) {
      message = '';
    }

    final e = SerializableError(
      code: response.statusCode,
      error: message,
      method: response.base.request?.method,
      url: response.base.request?.url.toString(),
      raw: resp.body.toString(),
    );

    log('Start Error---->  ${e.toJson()} ----End Error');

    return resp.copyWith(bodyError: e);
  }

  T? _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = serializationFactories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      log('Decode---jsonFactory ($jsonFactory) is null or isn\'t ${JsonFactory<T>} where T is $T');

      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) => values
      .where((v) => v != null)
      .map<T?>((v) {
        try {
          return _decode<T>(v);
        } catch (e, s) {
          log('$e\n$s\n_decodeList error at type $T');
          return null;
        }
      })
      .whereType<T>()
      .toList();

  dynamic _decode<T>(dynamic entity) {
    if (entity is Iterable) return _decodeList<T>(entity as List);

    if (entity is Map) return _decodeMap<T>(entity as Map<String, dynamic>);

    return entity;
  }
}
