// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/gen/assets.gen.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/provider/app_state_manager_provier.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../provider/locale_notifier.dart';

class SettingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageUtil.buildPage(
      _buildBody(context, ref),
      CommonTitleWidget(title: AppLocalizations.of(context)!.set),
    );
  }

  _buildBody(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        right: DimenUtil.width20,
        top: DimenUtil.height10,
      ),
      child: Stack(
        children: [
          ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.security_set,
                style: TextStyle(
                  fontSize: FontSizeUtil.size14,
                  color: ColorUtil.color303030,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: DimenUtil.height10),
              _buildItem(
                AppLocalizations.of(context)!.login_password,
                AppLocalizations.of(context)!.modify,
              ),
              _buildItem(
                AppLocalizations.of(context)!.fund_password,
                AppLocalizations.of(context)!.unbound,
              ),
              _buildItem(
                AppLocalizations.of(context)!.phone,
                AppLocalizations.of(context)!.unbound,
              ),
              _buildItem(
                AppLocalizations.of(context)!.email,
                AppLocalizations.of(context)!.unbound,
              ),
              _buildItem(
                AppLocalizations.of(context)!.google_authenticator,
                AppLocalizations.of(context)!.unbound,
              ),
              SizedBox(height: DimenUtil.height10),
              Text(
                AppLocalizations.of(context)!.general_set,
                style: TextStyle(
                  fontSize: FontSizeUtil.size14,
                  color: ColorUtil.color303030,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: DimenUtil.height10),
              InkWell(
                child: _buildItem(
                  AppLocalizations.of(context)!.language,
                  ref.watch(localeProvider)?.languageCode,
                ),

                onTap: () {
                  context.push(setLanguagePath);
                },
              ),
            ],
          ),
          Positioned(
            bottom: DimenUtil.height20,
            left: 0,
            right: 0,
            child: InkWell(
              child: Container(
                height: DimenUtil.height50,
                decoration: BoxDecoration(
                  color: ColorUtil.colorFF445FF1,
                  borderRadius: BorderRadius.all(
                    Radius.circular(DimenUtil.radius16),
                  ),
                ),
                child: Align(
                  child: Text(
                    AppLocalizations.of(context)!.logout,
                    style: TextStyle(
                      fontSize: FontSizeUtil.size14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(DimenUtil.radius24),
                          topRight: Radius.circular(DimenUtil.radius24),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: DimenUtil.height50,
                            child: InkWell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: TextStyle(
                                    fontSize: FontSizeUtil.size16,
                                    color: ColorUtil.color303030,
                                  ),
                                ),
                              ),
                              onTap: () {
                                ref
                                    .read(appStateManagerProvider.notifier)
                                    .logout(ref);
                              },
                            ),
                          ),
                          Container(
                            color: ColorUtil.colorFFF6F6F6,
                            padding: EdgeInsets.only(
                              left: DimenUtil.width20,
                              right: DimenUtil.width20,
                            ),
                            height: 1,
                          ),
                          Container(
                            height: DimenUtil.height50,
                            child: Align(
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: TextStyle(
                                  fontSize: FontSizeUtil.size16,
                                  color: ColorUtil.color303030,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String desc, String? stateName) {
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
          Text(
            desc,
            style: TextStyle(
              color: ColorUtil.color303030,
              fontSize: FontSizeUtil.size14,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  stateName ?? "",
                  style: TextStyle(
                    fontSize: FontSizeUtil.size14,
                    color: ColorUtil.colorFFB6B6B6,
                  ),
                ),
                Assets.icon.iconRightArrowGrey.svg(
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
