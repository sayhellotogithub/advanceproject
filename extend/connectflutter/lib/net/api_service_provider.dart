// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/test/test_data_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/index.dart';
import 'api_service.dart';
import 'interceptor/date_time_interceptor.dart';
import 'interceptor/header_interceptor.dart';

final dioProvider = Provider((ref) => Dio());

final apiServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  dio.interceptors.add(HeaderInterceptor());
  dio.interceptors.add(DateTimeInterceptor());
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  return ApiService(dio);
});

final countryInfoProvider =
    FutureProvider<BaseResponseModel<List<CountryInfoBean>>?>((ref) async {
      final apiService = ref.read(apiServiceProvider);

      return getCountryInfoResponseModel();
    });
final sendAuthCodeProvider =
    FutureProvider.family<BaseResponseModel<bool>, AuthCodeRequestModel>((
      ref,
      body,
    ) async {
      final apiService = ref.read(apiServiceProvider);
      return getSendAuthCodeResponseModel();
    });

final loginProvider = FutureProvider.family<
  BaseResponseModel<LoginResponseBodyModel>,
  LoginRequestBodyModel
>((ref, body) async {
  final apiService = ref.read(apiServiceProvider);
  return getLoginResponseBodyModel();
});

final resetPasswordProvider = FutureProvider.family<
  BaseResponseModel<LoginResponseBodyModel>,
  ResetPasswordRequestBodyModel
>((ref, body) async {
  final apiService = ref.read(apiServiceProvider);

  return getLoginResponseBodyModel();
});

final verifyRestPasswordProvider = FutureProvider.family<
  BaseResponseModel<String>,
  VerifyResetPasswordBodyModel
>((ref, body) async {
  final apiService = ref.read(apiServiceProvider);
  return getVerifyRestPasswordResponseModel();
});
