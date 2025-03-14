// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/common_button_widget.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/component/title/title_util.dart';
import 'package:connectflutter/component/white_board/index.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/util/file_util.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ElectroniceSignatureLandscapePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ElectroniceSignatureLandscapePageState();
  }
}

class _ElectroniceSignatureLandscapePageState
    extends State<ElectroniceSignatureLandscapePage> {
  WhiteBoardController whiteBoardController = WhiteBoardController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return PageUtil.buildLandScapeFullPage(
      _buildBody(),
      CommonTitleWhiteWidget(
        title: AppLocalizations.of(context)!.electronic_signature,
        rightWidget: TitleUitl.rightWidget(
          AppLocalizations.of(context)!.re_enter,
          () {
            whiteBoardController.clear();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: ColorUtil.color303030,
      padding: EdgeInsets.only(
        left: DimenUtil.width40,
        right: DimenUtil.width20,
        top: DimenUtil.height10,
        bottom: DimenUtil.height35,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimenUtil.radius16),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: DimenUtil.width16,
                      right: DimenUtil.width16,
                    ),
                    child: WhiteBoard(
                      controller: whiteBoardController,
                      strokeColor: Colors.black,
                      strokeWidth: 3,
                      onConvertImage: saveToPng,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          ImageUtil.getIconString(
                            "icon_electronic_signature_tip",
                          ),
                        ),
                        SizedBox(height: DimenUtil.height4),
                        Text(
                          AppLocalizations.of(context)!.please_sign_in_area,
                          style: TextStyle(
                            fontSize: FontSizeUtil.size12,
                            color: ColorUtil.colorFF445FF1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: DimenUtil.width20),
          Container(
            width: 100,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CommonButtonWidget(
                buttonText: AppLocalizations.of(context)!.save,
                buttonClick: () {
                  whiteBoardController.convertToImage();
                },
                enable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveToPng(Uint8List? png) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location, Permission.storage].request();

    for (final entry in statuses.entries) {
      if (!entry.value.isGranted) {
        openAppSettings();
      }
    }
    if (png != null) {
      var result = await FileUtil.saveImage("", Uuid().v1(), png);
      var path = await FileUtil.localPath;

      // AppRouterUtil.getAppState(context).changePath(path + result);
      // AppRouterUtil.popPage(context);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
