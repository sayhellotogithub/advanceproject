
import 'package:connectflutter/util/phone_util.dart';

class BaseRequestModel {
  String invokerChannel =
      "android";//渠道  字符串  安卓 默认为 android   苹果 默认为IOS   网页端  默认web  手机端  默认  H5
  ///
  ///手机端为  手机型号  +  版本   例如: 小米8+miu8
  /// 网页端为   系统版本 + 浏览器内核
  /// 例如: MacOS Big Sur 11.2.3 + 89.0.4389.82（正式版本）
  ///
  String? invokerDevice = "${PhoneUtil.systemModel}+${PhoneUtil.systemVersion}";
  String corpId = "iblogstreet";
}
