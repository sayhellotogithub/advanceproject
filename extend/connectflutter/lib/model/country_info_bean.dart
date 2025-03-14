import 'package:json_annotation/json_annotation.dart';

/// name : "中国"
/// simpleCode : "CHN"
/// telephoneCode : "+86"
/// letters : "Z"
/// flag : null

part "country_info_bean.g.dart";
@JsonSerializable()
class CountryInfoBean {
  String? _name;
  String? _simpleCode;
  String? _telephoneCode;
  String? _letters;
  String? _flag;

  String? get name => _name;

  String? get simpleCode => _simpleCode;

  String? get telephoneCode => _telephoneCode;

  String? get letters => _letters;

  String? get flag => _flag;

  CountryInfoBean({String? name,
    String? simpleCode,
    String? telephoneCode,
    String? letters,
    String? flag}) {
    _name = name;
    _simpleCode = simpleCode;
    _telephoneCode = telephoneCode;
    _letters = letters;
    _flag = flag;
  }

  factory CountryInfoBean.fromJson(Map<String, dynamic> json) => _$CountryInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CountryInfoBeanToJson(this);
}
