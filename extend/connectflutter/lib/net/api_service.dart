// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/base_response_model.dart';
import '../model/login_request_body_model.dart';
import '../model/login_response_body_model.dart';

part 'api_service.g.dart';

const String apiUrl = 'https://www.iblogstreet.com/';

@RestApi(baseUrl: apiUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("user/v1/{language}/login/normal")
  Future<BaseResponseModel<LoginResponseBodyModel>> login(
    @Path("language") String language,
    @Body() LoginRequestBodyModel body,
  );
}
