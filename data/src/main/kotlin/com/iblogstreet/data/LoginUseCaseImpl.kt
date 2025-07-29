package com.iblogstreet.data

import com.iblogstreet.domain.repository.TokenRepository
import com.iblogstreet.domain.usecase.LoginUseCase

/**
 * @author junwang
 * @date 2025/07/29 1:22
 */
class LoginUseCaseImpl(
    private val tokenRepository: TokenRepository
) : LoginUseCase {
    override suspend fun login(username: String, password: String): Result<String> {
        if (username == "user" && password == "pass") {
            val token = "dummy_token"
            tokenRepository.saveToken(token)
            return Result.success(token)
        }
        return Result.failure(Exception("Invalid login"))
    }
}
