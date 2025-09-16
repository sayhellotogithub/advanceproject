package com.iblogstreet.test_lab.presentation.viewmodel

import com.iblogstreet.test_lab.data.UserRepository

/**
 * @author junwang
 * @date 2025/09/16 15:30
 */
class UserVm(private val repo: UserRepository) {
    suspend fun greet() = "Hello ${repo.fetch()}"
}