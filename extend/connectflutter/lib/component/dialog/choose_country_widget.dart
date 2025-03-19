// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'dart:developer' as Logger;

import 'package:connectflutter/component/azlistview/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/city_model.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpinyin/lpinyin.dart';

import '../../net/api_service_provider.dart';

class ChooseCountryWidget extends ConsumerStatefulWidget {
  ValueChanged<CityModel>? itemClick;

  ChooseCountryWidget({Key? key, this.itemClick}) : super(key: key);

  @override
  _ChooseCountryWidgetState createState() => _ChooseCountryWidgetState();
}

class _ChooseCountryWidgetState extends ConsumerState<ChooseCountryWidget> {
  List<CityModel> cityList = [];
  double susItemHeight = 50;
  String imgFavorite = Assets.image.icFavorite.path;
  List<CityModel> hotCityList = [];

  void itemClickChange(CityModel value) {}

  @override
  void initState() {
    super.initState();

    hotCityList.addAll([
      CityModel(
        name: "中国大陆+86",
        telephoneCode: CityModel.getChinaCountryCode(),
      ),
      CityModel(
        name: "中国香港+852",
        telephoneCode: CityModel.getChinaHKCountryCode(),
      ),
      CityModel(
        name: "中国澳门+0853",
        telephoneCode: CityModel.getChinaMaCaoCountryCode(),
      ),
      CityModel(
        name: "中国台湾+886",
        telephoneCode: CityModel.getChinaTaiWanCountryCode(),
      ),
    ]);

    Future.delayed(Duration(milliseconds: 500), () {
      loadData();
    });
  }

  Future<void> loadData() async {
    final response = await ref.read(countryInfoProvider);
    response.when(
      data: (value) {
        final updatedCities =
            value?.data?.map((v) {
              return CityModel(
                name: "${v.name ?? ""}${v.telephoneCode ?? ""}",
                simpleCode: v.simpleCode,
                telephoneCode: v.telephoneCode,
              );
            }).toList() ??
            [];
        _handleList(updatedCities);
      },
      error: (error, stackTrace) {
        // Handle error here
        Logger.log("Error loading data: $error");
      },
      loading: () {},
    );
  }

  void _handleList(List<CityModel> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(cityList);

    setState(() {});
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.start,
        children:
            hotCityList.map((e) {
              return InkWell(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(e.name),
                  decoration: BoxDecoration(
                    color: ColorUtil.colorFFF5F7FE,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                onTap: () {
                  widget.itemClick?.call(e);
                  Navigator.pop(context, e);
                },
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 27),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.please_choose_phone_area,
                  style: TextStyle(fontSize: 18, color: ColorUtil.color303030),
                ),
                Assets.icon.iconCloseBlack.svg(width: 24, height: 24),
              ],
            ),
          ),
          _buildSearch(),
          SizedBox(height: 20),
          _buildHeader(),
          Expanded(
            child: AzListView(
              data: cityList,
              fixHeader: false,
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index) {
                CityModel model = cityList[index];
                return Util.getListItem(
                  context,
                  model,
                  widget.itemClick,
                  susHeight: susItemHeight,
                );
              },
              susItemHeight: susItemHeight,
              susItemBuilder: (BuildContext context, int index) {
                CityModel model = cityList[index];
                String tag = model.getSuspensionTag();
                if (imgFavorite == tag) {
                  return Container();
                }
                return Util.getSusItem(context, tag, susHeight: susItemHeight);
              },
              indexBarData: SuspensionUtil.getTagIndexList(cityList),
              indexBarOptions: IndexBarOptions(
                textStyle: TextStyle(
                  fontSize: 10,
                  color: ColorUtil.color303030,
                ),
                needRebuild: true,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                indexHintDecoration: BoxDecoration(color: Colors.red),
                decoration: BoxDecoration(
                  color: ColorUtil.colorFFF6F6F6,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                downColor: Color(0xFFEEEEEE),
                localImages: [imgFavorite], //local images.
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      margin: EdgeInsets.only(top: 23, left: 20, right: 20),
      // height: 40,
      padding: EdgeInsets.only(left: 17, right: 17),
      decoration: BoxDecoration(
        color: ColorUtil.colorFFF6F6F6,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Assets.icon.iconSearch.svg(),
          SizedBox(width: 10),
          Flexible(
            child: TextField(
              style: TextStyle(fontSize: 14, color: ColorUtil.color303030),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14, color: ColorUtil.hintColor),
                hintText: AppLocalizations.of(context)!.please_fill_keyword,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
