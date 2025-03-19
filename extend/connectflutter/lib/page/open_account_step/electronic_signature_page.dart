// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

import 'package:connectflutter/component/index.dart';
import 'package:connectflutter/component/title/index.dart';
import 'package:connectflutter/component/title/title_util.dart';
import 'package:connectflutter/l10n/index.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../gen/assets.gen.dart';

class ElectronicSignaturePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ElectronicSignaturePageState();
  }
}

class _ElectronicSignaturePageState extends State<ElectronicSignaturePage> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return PageUtil.buildPage(
      _buildBody(),
      CommonTitleWidget(
        title: AppLocalizations.of(context)!.electronic_signature,
        rightWidget: TitleUitl.rightWidget(
          AppLocalizations.of(context)!.re_enter,
          () {},
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(
        left: DimenUtil.width20,
        right: DimenUtil.width20,
      ),
      child: Stack(
        children: [
          ListView(
            children: [
              LinearPercentIndicator(
                lineHeight: 10,
                percent: 0.5,
                padding: EdgeInsets.zero,
                progressColor: ColorUtil.colorFFF1DD44,
                backgroundColor: ColorUtil.colorFFF7F7F7,
              ),
              SizedBox(height: DimenUtil.height20),
              // UploadImageWidget(),
              Container(
                height: DimenUtil.height180,
                padding: EdgeInsets.only(
                  left: DimenUtil.width16,
                  right: DimenUtil.width16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimenUtil.radius16),
                  color:
                      hasPicture()
                          ? ColorUtil.color4D303030
                          : ColorUtil.colorFFF7F7F7,
                ),
                child: Stack(
                  children: [
                    //todo
                    // Consumer<AppStateManagerProvider>(
                    //   builder: (context, snap, child) {
                    //     this.imagePath = snap.path;
                    //     if (hasPicture()) {
                    //       return Center(
                    //         child: Image.file(
                    //           File(imagePath!),
                    //           fit: BoxFit.fitHeight,
                    //         ),
                    //       );
                    //     } else {
                    //       return Container();
                    //     }
                    //   },
                    // ),
                    Center(
                      child: InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.icon.iconElectronicSignature.svg(),
                            SizedBox(height: DimenUtil.height4),
                            Text(
                              AppLocalizations.of(context)!.click_signature,
                              style: TextStyle(
                                fontSize: FontSizeUtil.size12,
                                color: ColorUtil.colorFF445FF1,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          context.go(electronicSignatureLandscapePath);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: DimenUtil.height20),
              Text(
                AppLocalizations.of(context)!.electronic_signature_warm_tip,
                style: TextStyle(
                  fontSize: FontSizeUtil.size12,
                  color: ColorUtil.colorFF828282,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: DimenUtil.height34,
            left: 0,
            right: 0,
            child: CommonButtonWidget(
              buttonText:
                  AppLocalizations.of(context)!.next_step_face_recognize,
              enable: true,
            ),
          ),
        ],
      ),
    );
  }

  bool hasPicture() {
    return imagePath != null;
  }
}
