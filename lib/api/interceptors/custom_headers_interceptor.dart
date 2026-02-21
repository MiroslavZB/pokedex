import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomHeadersInterceptor implements Interceptor {
  final Ref<ChopperClient> ref;

  CustomHeadersInterceptor(this.ref);

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    return (chain.proceed(
      applyHeaders(chain.request, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'User-Platform': Platform.operatingSystem,
        'Accept-Language': 'en',
      }),
    ));
  }
}
