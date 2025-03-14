## **Retrofit + FutureProvider の使い方**

### 1️⃣ **必要なパッケージを追加**

`pubspec.yaml` に追加：

```yaml
dependencies:
  dio: ^5.0.0
  retrofit: ^4.0.0
  json_annotation: ^4.8.0
  flutter_riverpod: ^2.0.0

dev_dependencies:
  retrofit_generator: ^5.0.0
  build_runner: ^2.4.0
```

------

### 2️⃣ **Retrofitのセットアップ**

**APIサービスを作成する：**

```dart
api_service.dart

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users/{id}")
  Future<User> getUser(@Path("id") int id);
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

**ビルドを実行：**

```
flutter pub run build_runner build
```

これで、API呼び出しに必要なコードが自動生成されます！✨

------

### 3️⃣ **FutureProviderと連携**

```dart
provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'api_service.dart';

final dioProvider = Provider((ref) => Dio());

final apiServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final userProvider = FutureProvider.family<User, int>((ref, userId) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getUser(userId);
});
```

- **dioProvider**：Dioのインスタンスを管理
- **apiServiceProvider**：RetrofitのAPIサービス
- **userProvider**：ユーザーIDを引数にとり、非同期でデータを取得

------

### 4️⃣ **データを表示する**

```dart
user_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider.dart';

class UserPage extends ConsumerWidget {
  final int userId;

  UserPage({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));

    return Scaffold(
      appBar: AppBar(title: Text('User Info')),
      body: Center(
        child: userAsync.when(
          data: (user) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${user.name}'),
              Text('Email: ${user.email}'),
            ],
          ),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text('エラーが発生しました: $err'),
        ),
      ),
    );
  }
}
```

------

## ✅ **ポイント解説**

1. **Retrofit + Dio**
   → 非同期のAPI通信を簡潔に実装できる。
2. **FutureProvider**
   → 非同期データを状態管理して、ビルド時に自動でデータ取得＆UI反映。
3. **family修飾子**
   → `FutureProvider.family` を使うことで、引数を受け取ってAPIに動的に値を渡せる。

------