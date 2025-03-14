// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../route/app_router_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(_buildBody(), _buildHeader());
  }

  Widget _buildBody() {
    return Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: DimenUtil.width20,
                  right: DimenUtil.width20,
                  top: DimenUtil.height8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.home_title,
                      style: TextStyle(
                        fontSize: FontSizeUtil.size24,
                        color: Color(0xFF202020),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: DimenUtil.height4),
                    Text(
                      AppLocalizations.of(context)!.home_subtitle,
                      style: TextStyle(
                        fontSize: FontSizeUtil.size14,
                        color: Color(0xFF868686),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DimenUtil.height12),
              Image.asset("assets/image/logo.png"),
            ],
          ),
          Positioned(
            child: _buildBottom(),
            bottom: DimenUtil.height20,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: DimenUtil.height70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(DimenUtil.radius6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(DimenUtil.radius8),
              ),
            ),
            child: InkWell(
              onTap: () {
                context.push(minePath);
              },
              child: SvgPicture.asset("assets/icon/icon_user_info.svg"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(DimenUtil.radius6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(DimenUtil.radius8),
              ),
            ),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset("assets/icon/icon_message_black.svg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width15,
        right: DimenUtil.width15,
        top: DimenUtil.height20,
        bottom: DimenUtil.height20,
      ),
      margin: EdgeInsets.only(
        left: DimenUtil.width20,
        right: DimenUtil.width20,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF445FF1),
        borderRadius: BorderRadius.all(Radius.circular(DimenUtil.radius24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icon/icon_open_account.svg"),
              SizedBox(width: DimenUtil.width10),
              Text(
                AppLocalizations.of(context)!.open_account_title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontSizeUtil.size18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _buildMenu(),
          Text(
            AppLocalizations.of(context)!.open_account_tip,
            softWrap: true,
            style: TextStyle(
              fontSize: FontSizeUtil.size12,
              color: Colors.white,
            ),
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Container(
      margin: EdgeInsets.only(
        top: DimenUtil.height20,
        bottom: DimenUtil.height18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomMenuItem(
            "icon_register_account",
            AppLocalizations.of(context)!.register_account,
          ),
          _buildBottomMenuItem(
            "icon_fill_material",
            AppLocalizations.of(context)!.fill_material,
          ),
          _buildBottomMenuItem(
            "icon_electronic_signature",
            AppLocalizations.of(context)!.electronic_signature,
          ),
          _buildBottomMenuItem(
            "icon_advance_verification",
            AppLocalizations.of(context)!.advance_auth,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenuItem(String icon, String title) {
    return Container(
      constraints: BoxConstraints(maxWidth: DimenUtil.width50),
      child: Column(
        children: [
          SvgPicture.asset(ImageUtil.getIconString(icon)),
          SizedBox(height: DimenUtil.height10),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: FontSizeUtil.size14,
              color: Color(0x88FFFFFF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      height: DimenUtil.width56,
      margin: EdgeInsets.only(top: DimenUtil.height40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(DimenUtil.radius16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Text(
              AppLocalizations.of(context)!.filling_material,
              style: TextStyle(
                fontSize: FontSizeUtil.size16,
                color: ColorUtil.colorFF445FF1,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              context.push(openAccountIntroductionPath);
            },
          ),
        ],
      ),
    );
  }
}
