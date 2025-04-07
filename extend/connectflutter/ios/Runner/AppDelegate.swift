import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let iconChannel = FlutterMethodChannel(name: "com.iblogstreet.connectflutter.dynamic_icon/icon",
                                             binaryMessenger: controller.binaryMessenger)
          
      iconChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let self = self else { return }
            
            if call.method == "changeIcon" {
              if let args = call.arguments as? Dictionary<String, Any>,
                 let iconName = args["aliasName"] as? String {
                self.changeAppIcon(iconName: iconName, result: result)
              } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid Argument", details: nil))
              }
            } else if call.method == "getCurrentIcon" {
              self.getCurrentAppIcon(result: result)
            } else {
              result(FlutterMethodNotImplemented)
            }
          })
          
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
private func changeAppIcon(iconName: String, result: @escaping FlutterResult) {
    if !UIApplication.shared.supportsAlternateIcons {
      result(FlutterError(code: "UNSUPPORTED", message: "この端末ではアイコン変更がサポートされていません", details: nil))
      return
    }
    
    // "default"の場合はnilを使用（デフォルトアイコンに戻す）
    let iconToUse: String? = iconName == "default" ? nil : iconName
    
    UIApplication.shared.setAlternateIconName(iconToUse) { error in
      if let error = error {
        print("アイコン変更エラー: \(error.localizedDescription)")
        result(FlutterError(code: "ICON_CHANGE_FAILED", message: error.localizedDescription, details: nil))
      } else {
        print("アイコンを変更しました: \(iconName)")
        result("アイコンを変更しました")
      }
    }
  }
      
  private func getCurrentAppIcon(result: @escaping FlutterResult) {
    if let currentIcon = UIApplication.shared.alternateIconName {
      result(currentIcon)
    } else {
      result("default")
    }
  }
}
