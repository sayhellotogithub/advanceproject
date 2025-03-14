// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/model/city_model.dart';
import 'package:flutter/material.dart';
import 'package:connectflutter/component/bottomsheet/custom_bottom_sheet.dart' as bs;

import '../component/dialog/choose_country_widget.dart';
import '../component/dialog/common_dialog.dart';

class DialogUtil {
  static void showChooseCountryDialog(BuildContext context,
      {Function(CityModel)? item}) {
    bs.showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ChooseCountryWidget(
          itemClick: item,
        );
      },
    );
  }

  static void showWarmTipDialog(BuildContext context,
      {VoidCallback? cancel,
      VoidCallback? confirm,
      VoidCallback? backgroundReturn}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonDialog(
            content: AppLocalizations.of(context)!.fill_material_exit_tip,
            title: AppLocalizations.of(context)!.warm_tip,
            cancelClick: cancel,
            confirmClick: confirm,
          );
        });
  }
}
