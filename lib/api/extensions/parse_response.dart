import 'package:chopper/chopper.dart';

extension ParseResponse<T> on Future<Response<T>> {
  Future<T> get parseResponse async => await then((res) => res.body!);
}
