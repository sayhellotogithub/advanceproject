#### .g文件生成 
flutter pub run build_runner build
#### 生成 http_service.chopper.dart
dev_dependencies配制
> chopper_generator: ^4.0.0

具体代码参考HttpService

运行命令
> flutter pub run build_runner build

sometime error,please run this
> flutter packages pub run build_runner build --delete-conflicting-outputs

パフォーマンスを確認

> flutter run --profile