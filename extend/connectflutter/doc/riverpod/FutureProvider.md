**FutureProvider** は、非同期処理（API通信、データベース操作など）を扱うためのRiverpodのプロバイダーです！
データ取得が完了するまでローディング状態を表示したり、エラー処理を組み込んだりするのに便利です。

------

## 🌟 **基本的な使い方**

### 1️⃣ **FutureProviderの定義**

```
final dataProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 2)); // 模擬的な非同期処理
  return "データ取得完了！";
});
```

- **ref**：他のプロバイダーとの連携に使う
- **async/await**：非同期処理を実行

------

### 2️⃣ **データを取得する方法**

**ConsumerWidget で使用する例：**

```
class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(title: Text('FutureProvider Sample')),
      body: Center(
        child: data.when(
          data: (value) => Text(value),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text('エラー: $err'),
        ),
      ),
    );
  }
}
```

- **ref.watch(dataProvider)**：プロバイダーの状態を監視

- when()

  ：

  - **data** → データが正常に取得された時の処理
  - **loading** → データ取得中の処理（ローディング表示など）
  - **error** → エラー時の処理

------

## 🎯 **実践的な例**

**APIからデータを取得するケース：**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final userProvider = FutureProvider((ref) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['name'];
  } else {
    throw Exception('Failed to load user');
  }
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UserPage());
  }
}

class UserPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: Text('User Data')),
      body: Center(
        child: user.when(
          data: (name) => Text('User name: $name'),
          loading: () => CircularProgressIndicator(),
          error: (err, stack) => Text('エラー: $err'),
        ),
      ),
    );
  }
}
```

------

## ✅ **ポイントまとめ**

- **データ取得後にUIを更新したい時** → **FutureProvider**
- **リアルタイムに状態が変わるもの** → **StreamProvider** を使う
- **読み取り専用の非同期データ** → **FutureProvider.autoDispose** で一時的にデータを保持可能

------

何か実際のプロジェクトで使ってみたい非同期処理はありますか