package ru.scar.yandex_checkout

import ru.yandex.money.android.sdk.*
import java.math.BigDecimal
import java.util.Currency
import kotlin.collections.HashMap

private fun amountFromMap(map: HashMap<String, *>) : Amount = Amount(
        BigDecimal.valueOf(map["value"] as Double),
        Currency.getInstance(map["currency"] as String)
)

private fun paymentMethodFromMap(list: List<String>) : Set<PaymentMethodType> {
    if(list.isEmpty())
        return PaymentMethodType.values().toMutableSet()
    return list.map { s -> when(s){
        "yandex" -> PaymentMethodType.YANDEX_MONEY
        "google_pay" -> PaymentMethodType.GOOGLE_PAY
        "card" -> PaymentMethodType.BANK_CARD
        "sberbank" -> PaymentMethodType.SBERBANK
        else -> throw Exception()
    }}.toSet()
}

private fun savePaymentFromMap(e: String) : SavePaymentMethod = when(e){
    "ON" -> SavePaymentMethod.ON
    "OFF" -> SavePaymentMethod.OFF
    "SELECT" -> SavePaymentMethod.USER_SELECTS
    else -> SavePaymentMethod.OFF
}

private fun googlePayParameters(list: List<String>) : GooglePayParameters = GooglePayParameters(
        list.map{ e -> when(e){
            "amex" -> GooglePayCardNetwork.AMEX
            "discover" -> GooglePayCardNetwork.DISCOVER
            "jcb" -> GooglePayCardNetwork.JCB
            "mastercard" -> GooglePayCardNetwork.MASTERCARD
            "visa" -> GooglePayCardNetwork.VISA
            "interac" -> GooglePayCardNetwork.INTERAC
            else -> GooglePayCardNetwork.OTHER
        } }.toSet()
)

fun parsePaymentParameters(map: HashMap<String, *>) : PaymentParameters = PaymentParameters(
        amountFromMap(map["amount"] as HashMap<String, Any>),
        map["title"] as String,
        map["sub_title"] as String,
        map["api_key"] as String,
        map["shop_id"] as String,
        savePaymentFromMap(map["save_pay_method"] as String),
        paymentMethodFromMap(map["payment_method"] as List<String>),
        map["gateway_id"]?.let { it as String },
        map["custom_return_url"]?.let { it as String },
        map["user_phone"]?.let { it as String },
        googlePayParameters(map["google_pay_parameters"] as List<String>)
)

fun TokenizationResult.toMap() : HashMap<String, String> = hashMapOf(
        "payment_method" to when(this.paymentMethodType){
            PaymentMethodType.SBERBANK -> "sberbank"
            PaymentMethodType.BANK_CARD -> "card"
            PaymentMethodType.GOOGLE_PAY -> "google_pay"
            PaymentMethodType.YANDEX_MONEY -> "yandex"
        },
        "token" to this.paymentToken
)