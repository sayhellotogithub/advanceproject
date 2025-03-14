import 'dart:convert';

import 'package:connectflutter/component/azlistview/index.dart';

class CityModel extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? namePinyin;
  String? simpleCode;
  String? telephoneCode;

  CityModel(
      {required this.name,
        this.tagIndex,
        this.namePinyin,
        this.simpleCode,
        this.telephoneCode});

  CityModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  static CityModel defaultModel() {
    return CityModel(
        name: "中国大陆+86", telephoneCode: CityModel.getChinaCountryCode());
  }

  Map<String, dynamic> toJson() =>
      {'name': name, "telephoneCode": telephoneCode};

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);

  ///
  /// 是否是中国的国家码
  /// @param countryCode
  /// @return
  ///
  static bool isChinaCountryCode(String countryCode) {
    if ("86" == countryCode) {
      return true;
    }
    return false;
  }

  static String getChinaCountryCode() {
    return "+86";
  }

  static String getChinaHKCountryCode() {
    return "+852";
  }

  static String getChinaMaCaoCountryCode() {
    return "+853";
  }

  static String getChinaTaiWanCountryCode() {
    return "+886";
  }

  ///
  /// 判断国籍是否是中国大陆
  ///@param nationality
  /// @return

  static bool isMainLand(String nationality) {
    return "CHN" == nationality;
  }

  static void removeChina(List<CityModel>? countryList) {
    if (countryList != null && countryList.length > 0) {
      for (CityModel countryInfoBean in countryList) {
        if (isMainLand(countryInfoBean.simpleCode ?? "")) {
          countryList.remove(countryInfoBean);
          return;
        }
      }
    }
  }
}
