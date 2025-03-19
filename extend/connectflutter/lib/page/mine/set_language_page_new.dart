// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/title/common_title_widget.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../gen/assets.gen.dart';
import '../../provider/locale_notifier.dart';

class SetLanguagePageNew extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageUtil.buildPage(
      _buildBody(ref),
      CommonTitleWidget(title: AppLocalizations.of(context)!.language),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        right: DimenUtil.width20,
      ),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: DimenUtil.height11),
          for (var item in AppLocalizations.supportedLocales)
            InkWell(
              child: _buildItem(
                item.languageCode,
                item.languageCode == ref.read(localeProvider)?.languageCode,
              ),
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(item);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildItem(String desc, bool isChoose) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: ColorUtil.colorFFF6F6F6,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            desc,
            style: TextStyle(color: ColorUtil.color303030, fontSize: 14),
          ),
          if (isChoose) Assets.icon.iconSelectedBlue.svg(),
        ],
      ),
    );
  }
}
