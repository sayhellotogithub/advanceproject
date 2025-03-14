// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:dio/dio.dart' hide Headers;

import 'package:connectflutter/share_pref/cookie_share_pref.dart';

class GetCookieInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? cookie = options.headers["Set-Cookie"];
    if (cookie != null) {
      CookieSharePref.saveCookie(cookie);
    }
    handler.next(options);
  }
}
