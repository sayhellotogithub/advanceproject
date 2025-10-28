## ゴール

- ユーザー登録／ログイン（JWT）／ログアウト（リフレッシュトークン無効化）

- /me 取得／プロフィール更新／パスワード変更

- （任意）メール検証・パスワードリセットの土台

- 役割（Role）による認可

- 共通バリデーション＆エラーフォーマット


### 起動
```declarative
export JWT_SECRET="dev-secret"
./gradlew :server:run -Dio.ktor.development=true
```

### 技術
#### Database
SQLDelight

####