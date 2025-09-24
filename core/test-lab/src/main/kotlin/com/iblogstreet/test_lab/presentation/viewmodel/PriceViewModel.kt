package com.iblogstreet.test_lab.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.iblogstreet.test_lab.domain.models.DiscountInput
import com.iblogstreet.test_lab.domain.usecase.CalculateFinalPriceUseCase
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

/**
 * @author junwang
 * @date 2025/09/24 15:26
 */
data class UiState(
    val finalPrice: Int? = null,
    val loading: Boolean = false,
    val error: String? = null
)

class PriceViewModel(private val useCase: CalculateFinalPriceUseCase) : ViewModel() {
    private val _state = MutableStateFlow(UiState())
    val uiState: StateFlow<UiState> = _state.asStateFlow()

    fun calc(discountInput: DiscountInput) = viewModelScope.launch {
        _state.update { it.copy(loading = true, error = null) }

        runCatching { useCase(discountInput) }.onSuccess { price ->
            _state.update {
                it.copy(
                    finalPrice = price,
                    loading = false
                )
            }
        }.onFailure { e ->
            _state.update {
                it.copy(
                    error = e.message,
                    loading = false
                )
            }
        }
    }
}