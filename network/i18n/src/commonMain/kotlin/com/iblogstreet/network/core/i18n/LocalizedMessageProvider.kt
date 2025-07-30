package com.iblogstreet.network.core.i18n

import com.iblogstreet.network.core.i18n.error.ErrorCode

object LocalizedMessageProvider {
    fun getMessage(code: ErrorCode, lang: Language = LocaleConfig.currentLanguage): String {
        return when (lang) {
            Language.EN -> when (code) {
                ErrorCode.EMPTY_BODY -> "Response body is empty"
                ErrorCode.TIMEOUT -> "Request timed out"
                ErrorCode.NO_INTERNET -> "No internet connection"
                ErrorCode.HTTP_ERROR -> "HTTP error occurred"
                ErrorCode.PARSE_ERROR -> "Failed to parse response"
                ErrorCode.UNKNOWN_ERROR -> "Unknown error occurred"
            }

            Language.ZH -> when (code) {
                ErrorCode.EMPTY_BODY -> "响应体为空"
                ErrorCode.TIMEOUT -> "请求超时"
                ErrorCode.NO_INTERNET -> "没有网络连接"
                ErrorCode.HTTP_ERROR -> "发生HTTP错误"
                ErrorCode.PARSE_ERROR -> "解析响应失败"
                ErrorCode.UNKNOWN_ERROR -> "发生未知错误"
            }

            Language.JA -> when (code) {
                ErrorCode.EMPTY_BODY -> "レスポンスボディが空です"
                ErrorCode.TIMEOUT -> "リクエストがタイムアウトしました"
                ErrorCode.NO_INTERNET -> "インターネットに接続されていません"
                ErrorCode.HTTP_ERROR -> "HTTPエラーが発生しました"
                ErrorCode.PARSE_ERROR -> "レスポンスの解析に失敗しました"
                ErrorCode.UNKNOWN_ERROR -> "不明なエラーが発生しました"
            }
        }
    }

}