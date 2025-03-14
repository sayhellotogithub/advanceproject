**StateProvider** は、Riverpodでシンプルな状態を管理するためのプロバイダーです。カウンターやフラグ、文字列など、手軽に変更可能な状態を扱うのに便利です！

### 🌟 **基本的な使い方**

1. **StateProviderを定義する**

   ```dart
   final counterProvider = StateProvider<int>((ref) => 0);
   ```

   - **ref**: プロバイダー同士をつなげるためのもの
   - **初期値**: ここでは0を設定

2. **状態を読み取る・更新する**
   **状態を監視するには `ref.watch()` を使う：**

   ```dart
   @override
   Widget build(BuildContext context, WidgetRef ref) {
     final count = ref.watch(counterProvider);
     return Text('Count: $count');
   }
   ```

   **状態を変更するには `ref.read()` と `.notifier.state` を使う：**

   ```dart
   FloatingActionButton(
     onPressed: () => ref.read(counterProvider.notifier).state++,
     child: Icon(Icons.add),
   )
   ```

   - **ref.watch()** → 状態が変わるたびにビルドを再実行
   - **ref.read()** → 状態を1回だけ取得（リビルドしない）

### 🎯 **実践的な例**

**カウンターアプリの例：**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Counter with Riverpod')),
      body: Center(
        child: Text('Count: $count', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}

final counterProvider = StateProvider<int>((ref) => 0);
```

### ✅ **ポイント**

- **StateProvider** は **値そのもの** をシンプルに管理したい場合に使う（int、bool、String など）。
- 状態を複雑に管理するなら **StateNotifierProvider** や **ChangeNotifierProvider** が向いている。
- **ref.read** はイベントハンドラーで使うことが多い（ボタン押下時など）。

どうですか？もしプロジェクトに合わせた実装方法を見たいなら、コード一緒にいじってみましょうか？🔥

