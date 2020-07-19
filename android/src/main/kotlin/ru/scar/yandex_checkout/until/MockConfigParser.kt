package ru.scar.yandex_checkout.until

import ru.yandex.money.android.sdk.Amount
import ru.yandex.money.android.sdk.MockConfiguration
import ru.yandex.money.android.sdk.TestParameters
import java.math.BigDecimal
import java.util.*
import kotlin.collections.HashMap

@Suppress("UNCHECKED_CAST")
class MockParser{
    companion object{
        fun parse(map: HashMap<String, *>) : TestParameters = TestParameters(
                map["show_logs"] as Boolean,
                map["google_pay_test"] as Boolean,
                mockConfigFromMap(map["mock_config"] as HashMap<String, *>)

        )

        private fun mockConfigFromMap(map: HashMap<String, *>) : MockConfiguration = MockConfiguration(
                map["complete_with_error"] as Boolean,
                map["payment_auth_passed"] as Boolean,
                map["cards_count"] as Int,
                map["amount"]?.let { amountFromMap(it as HashMap<String, *>) }
        )

        private fun amountFromMap(map: HashMap<String, *>) : Amount = Amount(
                BigDecimal.valueOf(map["value"] as Double),
                Currency.getInstance(map["currency"] as String)
        )
    }
}