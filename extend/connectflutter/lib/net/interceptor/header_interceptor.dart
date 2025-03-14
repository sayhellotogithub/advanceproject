// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/share_pref/token_share_pref.dart';
import 'package:connectflutter/util/phone_util.dart';
import 'package:dio/dio.dart' hide Headers;

class HeaderInterceptor extends Interceptor {
  static const String AUTH_HEADER = "Authorization";
  static const String BEARER = "Bearer ";
  static const String V4_AUTH_HEADER = "< your key here >";

  static const INVOKER_CHANNEL = "invoker_channel";
  static const INVOKER_DEVICE = "invoker_device";
  static const USER_TOKEN = "user_token";
  static const REFRESH_TOKEN = "refresh_token";

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    Map<String, String> map = {"CORP_ID": "iblogstreet"};

    map[INVOKER_CHANNEL] = "android";
    map[INVOKER_DEVICE] = "${PhoneUtil.systemModel}+${PhoneUtil.systemVersion}";

    var token = await TokenSharePref.getUserToken();
    if (token != null) {
      map[USER_TOKEN] = token;
    }
    var refreshToken = await TokenSharePref.getRefreshToken();
    if (refreshToken != null) {
      map[REFRESH_TOKEN] = refreshToken;
    }
    options.headers.addAll(map);

    super.onRequest(options, handler);
  }
}
