package com.iblogstreet.login.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.iblogstreet.domain.usecase.LoginUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

/**
 * @author junwang
 * @date 2025/07/28 23:51
 */
@HiltViewModel
class LoginViewModel @Inject constructor(
    private val loginUseCase: LoginUseCase
) : ViewModel() {
    private val _tokenResult = MutableStateFlow<Result<String>?>(null)
    val tokenResult: StateFlow<Result<String>?> = _tokenResult
    fun login(username: String, password: String) {
        viewModelScope.launch {
            _tokenResult.value = loginUseCase.login(username, password)
        }
    }
}