package com.iblogstreet.designsystem.components

import android.content.Intent
import android.webkit.WebResourceRequest
import android.webkit.WebView
import androidx.compose.runtime.Composable
import androidx.compose.ui.viewinterop.AndroidView

/**
 * @author junwang
 * @date 2025/05/29 0:27
 *
 * 1. AndroidManifest にセキュリティ設定を反映
 * <uses-permission android:name="android.permission.INTERNET" />
 *
 * <application
 *     android:usesCleartextTraffic="false" <!-- HTTPは禁止（HTTPSのみ） -->
 *     ...>
 * </application>
 *
 * 2.通信面のセキュリティ
 * 必ずHTTPSのURLだけを使用する（HTTPをブロック）
 *
 * 自己署名証明書は使わない（証明書エラーのバイパスは禁止）
 *
 * WebChromeClient を設定する場合は JavaScript Consoleなどの処理にも注意
 *
 * 3.JavaScriptを使う場合の対策（やむを得ずONにする場合）
 * settings.javaScriptEnabled = true
 *
 * addJavascriptInterface(object {
 *     @JavascriptInterface
 *     fun showToast(message: String) {
 *         Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
 *     }
 * }, "AndroidInterface")
 */
@Composable
fun SecureWebView(
    url: String,
    allowedDomains: List<String> = listOf(""),
    onPageStarted: (String) -> Unit = {},
    onPageFinished: (String) -> Unit = {},
    onError: (Throwable) -> Unit = {}
) {
    AndroidView(factory = { context ->
        WebView(context).apply {
            //セキュリティ　設定
            settings.apply {
                javaScriptEnabled = false //JSを必要としない場合は絶対にOFF
                domStorageEnabled = false//DOMストレージを必要としない場合はOFF
                allowFileAccess = false //ローカルファイルへのアクセスを許可しない
                allowContentAccess = false //コンテンツへのアクセスを許可しない
                useWideViewPort = true
                loadWithOverviewMode = true //ページを広げて表示する
                setSupportZoom(true)
                builtInZoomControls = true //ズームコントロールを有効にする
                displayZoomControls = false //ズームコントロールの表示を無効にする
            }
            //セキュリティーの防御策
            webViewClient = object : android.webkit.WebViewClient() {
                override fun shouldOverrideUrlLoading(
                    view: WebView,
                    request: WebResourceRequest?
                ): Boolean {
                    val host = request?.url?.host
                    val isAllowed = host != null && allowedDomains.any { host.endsWith(it) }
                    // ホストが許可されている場合のみ、URLをロードする
                    return if (isAllowed) {
                        false // URLをロードする
                    } else {
                        val intent = Intent(Intent.ACTION_VIEW, request?.url)
                        context.startActivity(intent)
                        true // URLのロードをキャンセルする
                    }
                }

                override fun onPageStarted(
                    view: WebView,
                    url: String,
                    favicon: android.graphics.Bitmap?
                ) {
                    onPageStarted(url)
                }

                override fun onPageFinished(view: WebView, url: String) {
                    onPageFinished(url)
                }

                override fun onReceivedError(
                    view: WebView,
                    errorCode: Int,
                    description: String,
                    failingUrl: String
                ) {
                    onError(Throwable(description))
                }
            }
            clearCache(true)
            clearHistory()
            loadUrl(url)
        }
    })


}

