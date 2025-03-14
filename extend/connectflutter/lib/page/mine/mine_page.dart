// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(_buildBody(), CommonTitleWidget());
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        right: DimenUtil.width20,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: DimenUtil.height70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Image.asset(
                  ImageUtil.getImageString("icon_default_bg"),
                  width: DimenUtil.width70,
                  height: DimenUtil.height70,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: DimenUtil.width10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "13537485662",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeUtil.size20,
                          color: ColorUtil.color303030,
                        ),
                      ),
                      SizedBox(width: DimenUtil.width5),
                      SvgPicture.asset(
                        ImageUtil.getIconString("icon_eye_show"),
                      ),
                    ],
                  ),
                  Text(
                    "UID：10001",
                    style: TextStyle(
                      fontSize: FontSizeUtil.size12,
                      color: ColorUtil.colorFF828282,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: DimenUtil.height30),
          InkWell(
            child: _buildItem(AppLocalizations.of(context)!.set, "icon_set"),
            onTap: () {
              context.push(settingsPath);
            },
          ),
          _buildItem(AppLocalizations.of(context)!.help_center, "icon_help"),
          _buildItem(AppLocalizations.of(context)!.about_us, "icon_about"),
        ],
      ),
    );
  }

  Widget _buildItem(String desc, String iconName) {
    return Container(
      height: DimenUtil.height50,
      margin: EdgeInsets.only(bottom: DimenUtil.height10),
      padding: EdgeInsets.only(
        left: DimenUtil.width15,
        right: DimenUtil.width15,
      ),
      decoration: BoxDecoration(
        color: ColorUtil.colorFFF6F6F6,
        borderRadius: BorderRadius.all(Radius.circular(DimenUtil.radius16)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(ImageUtil.getIconString(iconName)),
          SizedBox(width: DimenUtil.width10),
          Text(
            desc,
            style: TextStyle(
              color: ColorUtil.color303030,
              fontSize: FontSizeUtil.size14,
            ),
          ),
          Expanded(
            child: SvgPicture.asset(
              ImageUtil.getIconString("icon_right_arrow_grey"),
              alignment: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }
}
