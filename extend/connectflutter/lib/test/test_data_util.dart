// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import '../model/base_response_model.dart';
import '../model/country_info_bean.dart';
import '../model/login_response_body_model.dart';

getLoginResponseBodyModel() {
  return BaseResponseModel(
    code: 0,
    msg: "success",
    success: true,
    data: LoginResponseBodyModel(
      loginName: "loginName",
      isRegister: false,
      userToken: "userToken",
      refreshToken: "refreshToken",
    ),
  );
}

getVerifyRestPasswordResponseModel() {
  return BaseResponseModel(
    code: 0,
    msg: "success",
    success: true,
    data: "data",
  );
}

getSendAuthCodeResponseModel() {
  return BaseResponseModel(code: 0, msg: "success", success: true, data: true);
}

BaseResponseModel<List<CountryInfoBean>> getCountryInfoResponseModel() {
  return BaseResponseModel(
    code: 0,
    msg: "success",
    success: true,
    data: [
      CountryInfoBean(
        simpleCode: "simpleCode",
        telephoneCode: "telephoneCode",
        name: "name",
        letters: "letters",
        flag: "flag",
      ),
    ],
  );
}
