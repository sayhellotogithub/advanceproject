package com.iblogstreet.domain.usecase

/**
 * @author junwang
 * @date 2025/07/28 23:49
 */
interface LoginUseCase {
    suspend fun login(username: String, password: String): Result<String>
}