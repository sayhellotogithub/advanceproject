/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/icon_about.svg
  String get iconAbout => 'assets/icon/icon_about.svg';

  /// File path: assets/icon/icon_advance_verification.svg
  String get iconAdvanceVerification =>
      'assets/icon/icon_advance_verification.svg';

  /// File path: assets/icon/icon_back_arrow_black.svg
  String get iconBackArrowBlack => 'assets/icon/icon_back_arrow_black.svg';

  /// File path: assets/icon/icon_back_arrow_white.svg
  String get iconBackArrowWhite => 'assets/icon/icon_back_arrow_white.svg';

  /// File path: assets/icon/icon_clear_grey.svg
  String get iconClearGrey => 'assets/icon/icon_clear_grey.svg';

  /// File path: assets/icon/icon_close_black.svg
  String get iconCloseBlack => 'assets/icon/icon_close_black.svg';

  /// File path: assets/icon/icon_delete.svg
  String get iconDelete => 'assets/icon/icon_delete.svg';

  /// File path: assets/icon/icon_electronic_signature.svg
  String get iconElectronicSignature =>
      'assets/icon/icon_electronic_signature.svg';

  /// File path: assets/icon/icon_electronic_signature_tip.svg
  String get iconElectronicSignatureTip =>
      'assets/icon/icon_electronic_signature_tip.svg';

  /// File path: assets/icon/icon_eye_show.svg
  String get iconEyeShow => 'assets/icon/icon_eye_show.svg';

  /// File path: assets/icon/icon_fill_material.svg
  String get iconFillMaterial => 'assets/icon/icon_fill_material.svg';

  /// File path: assets/icon/icon_help.svg
  String get iconHelp => 'assets/icon/icon_help.svg';

  /// File path: assets/icon/icon_message_black.svg
  String get iconMessageBlack => 'assets/icon/icon_message_black.svg';

  /// File path: assets/icon/icon_open_account.svg
  String get iconOpenAccount => 'assets/icon/icon_open_account.svg';

  /// File path: assets/icon/icon_register_account.svg
  String get iconRegisterAccount => 'assets/icon/icon_register_account.svg';

  /// File path: assets/icon/icon_right_arrow_grey.svg
  String get iconRightArrowGrey => 'assets/icon/icon_right_arrow_grey.svg';

  /// File path: assets/icon/icon_search.svg
  String get iconSearch => 'assets/icon/icon_search.svg';

  /// File path: assets/icon/icon_selected_blue.svg
  String get iconSelectedBlue => 'assets/icon/icon_selected_blue.svg';

  /// File path: assets/icon/icon_set.svg
  String get iconSet => 'assets/icon/icon_set.svg';

  /// File path: assets/icon/icon_take_photo.svg
  String get iconTakePhoto => 'assets/icon/icon_take_photo.svg';

  /// File path: assets/icon/icon_user_info.svg
  String get iconUserInfo => 'assets/icon/icon_user_info.svg';

  /// List of all assets
  List<String> get values => [
    iconAbout,
    iconAdvanceVerification,
    iconBackArrowBlack,
    iconBackArrowWhite,
    iconClearGrey,
    iconCloseBlack,
    iconDelete,
    iconElectronicSignature,
    iconElectronicSignatureTip,
    iconEyeShow,
    iconFillMaterial,
    iconHelp,
    iconMessageBlack,
    iconOpenAccount,
    iconRegisterAccount,
    iconRightArrowGrey,
    iconSearch,
    iconSelectedBlue,
    iconSet,
    iconTakePhoto,
    iconUserInfo,
  ];
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/ic_favorite.png
  AssetGenImage get icFavorite =>
      const AssetGenImage('assets/image/ic_favorite.png');

  /// File path: assets/image/icon_default_bg.png
  AssetGenImage get iconDefaultBg =>
      const AssetGenImage('assets/image/icon_default_bg.png');

  /// File path: assets/image/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/image/logo.png');

  /// File path: assets/image/open_account_introduce_logo.png
  AssetGenImage get openAccountIntroduceLogo =>
      const AssetGenImage('assets/image/open_account_introduce_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    icFavorite,
    iconDefaultBg,
    logo,
    openAccountIntroduceLogo,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
