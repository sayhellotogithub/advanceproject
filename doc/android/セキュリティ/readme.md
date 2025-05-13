### **1. セキュアなデータ保存** ⭕️

- **SharedPreferencesは平文NG！**
  - → `EncryptedSharedPreferences` を使う（AES暗号化済）
- **内部ストレージ（Internal Storage）の適切な使用**
  - 外部ストレージはファイルが他アプリから読める可能性がある

### **2. 生体認証（Biometric認証）**

- AndroidXの `BiometricPrompt` API を使用
- 顔/指紋/パスコード等に対応
- 認証成功時のみ「鍵」や「トークン」を取得可能にする

### **3. 通信のセキュリティ**

- **HTTPS（TLS 1.2以上）必須**
- **証明書ピニング（Certificate Pinning）**
  - OkHttpの `CertificatePinner` を使うことで、中間者攻撃（MITM）対策
- **信頼できない証明書のバイパス禁止**
  - `TrustManager` をカスタムでゆるめるのはNG！

### **4. センシティブ情報の管理**

- **トークンやパスワードのハードコード禁止！**
  - BuildConfigやKeystoreを使って安全に管理
- **Android Keystoreシステムの活用**
  - AESキーやRSAキーを安全に保存・利用
  - 例：認証後にしかアクセスできないようにする

### **5. アプリコードの難読化**

- **Proguard / R8 の設定強化**
  - クラス名、メソッド名を難読化
  - リフレクション使用箇所は `-keep` を明示
- **retrace でデバッグログも読めるように管理**

### **6. 逆コンパイル対策**

- **Asset内の重要なデータは暗号化**
- **JNI（C/C++）でロジックをNative化する手法**
  - 簡単にデコンパイルできないようにする
- **SafetyNet Attestation / Play Integrity API** の活用
  - 改ざん検知、root検出、Bot対策など

### **7. WebViewの安全な使い方**

- JavaScriptを有効にする場合は **極力使わない or オリジンドメイン制限**
- `addJavascriptInterface()` は脆弱になりやすい → 必要最低限に
- 外部リンクは `ACTION_VIEW` でChromeなどに渡すのが無難

### **8. デバッグビルドと本番ビルドの違い管理**

- `debuggable="false"` を必ずReleaseビルドで設定
- `logcat`にAPIキーやエラー内容を出力しない
- Firebase Crashlyticsで収集する情報を必要最小限に制限

------

## **おすすめ教材 / ドキュメント**

- [Android Developers - App Security Best Practices](https://developer.android.com/topic/security/best-practices)
- OWASP Mobile Top 10（脆弱性チェックリスト）
- GitHub: [Android Security Recipes](https://github.com/ashishb/android-security-awesome)