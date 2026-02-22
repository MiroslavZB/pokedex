import 'dart:async';

import 'package:chopper/chopper.dart';

class ErrorInterceptor implements Interceptor {
  const ErrorInterceptor();

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final Request request = chain.request;

    final Response<BodyType> response = await chain.proceed(request);

    if (response.error != null) throw response.error!;

    return response;
  }
}
