// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryInfoBean _$CountryInfoBeanFromJson(Map<String, dynamic> json) =>
    CountryInfoBean(
      name: json['name'] as String?,
      simpleCode: json['simpleCode'] as String?,
      telephoneCode: json['telephoneCode'] as String?,
      letters: json['letters'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$CountryInfoBeanToJson(CountryInfoBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'simpleCode': instance.simpleCode,
      'telephoneCode': instance.telephoneCode,
      'letters': instance.letters,
      'flag': instance.flag,
    };
