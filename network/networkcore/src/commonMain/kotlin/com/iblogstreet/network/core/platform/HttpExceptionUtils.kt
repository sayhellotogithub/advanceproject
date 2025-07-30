package com.iblogstreet.network.core.platform

/**
 * @author junwang
 * @date 2025/07/29 22:19
 */
expect fun isHttpException(e: Throwable): Boolean
expect fun extractHttpError(e: Throwable): Pair<Int, String>