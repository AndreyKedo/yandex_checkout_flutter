package ru.scar.yandex_checkout.until

import ru.yandex.money.android.sdk.TokenizationResult

interface ResultHandler {
    fun success(token: TokenizationResult?)
    fun failure(hasError: Boolean?)
}