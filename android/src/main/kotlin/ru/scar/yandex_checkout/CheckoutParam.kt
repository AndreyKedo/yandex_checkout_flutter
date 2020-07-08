package ru.scar.yandex_checkout

import ru.yandex.money.android.sdk.PaymentParameters
import ru.yandex.money.android.sdk.TestParameters

sealed class CheckoutParam

data class DefaultCheckout(val paymentParameters: PaymentParameters) : CheckoutParam(){
    override fun toString(): String = "$paymentParameters"
}

data class Checkout3Ds(val url: String) : CheckoutParam(){
    override fun toString(): String = "3Ds url - $url"
}

data class DebugCheckout(val paymentParameters: PaymentParameters,
                         val testParameters: TestParameters? = null) : CheckoutParam(){
    override fun toString(): String  = "$paymentParameters \nTest parameters - $testParameters"
}