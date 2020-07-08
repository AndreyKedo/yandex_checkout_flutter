package ru.scar.yandex_checkout

import androidx.annotation.NonNull
import io.flutter.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import ru.yandex.money.android.sdk.TokenizationResult

/** YandexCheckoutPlugin */
class YandexCheckoutPlugin: FlutterPlugin, MethodCallHandler, YandexCheckoutFlutter() {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "yandex_checkout")
    channel.setMethodCallHandler(this)
  }
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "yandex_checkout")
      channel.setMethodCallHandler(YandexCheckoutPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.d("YandexCheckoutPlugin", "Call method ${call.method} with data ${call.arguments}")
    when (call.method){
      "startPay" -> {
        val callbackHandler = object : ResultCallback {
          override fun success(token: TokenizationResult) = result.success(hashMapOf(
                  "success" to true,
                  "data" to token.toMap()
          ))

          override fun failure(hasError: Boolean?) = result.success(hashMapOf(
                  "success" to false,
                  "hasError" to hasError
          ))
        }
        when {
            call.hasArgument("mock_param") -> {
              val parametersHashMap = call.argument<HashMap<String, *>>("payment_parameters")
              val mockParamMap = call.argument<HashMap<String, *>>("mock_param")
              if(parametersHashMap != null && mockParamMap != null)
                startTokenize(DebugCheckout(parsePaymentParameters(parametersHashMap), parseMockParam(mockParamMap)), callbackHandler)
              else
                result.error(
                        "YandexCheckoutPlugin",
                        "Parameters not must be null",
                        if(parametersHashMap == null) "PaymentParameters not must be null!" else "TestParameters not must be null!"
                )
            }
            call.arguments is String -> startTokenize(Checkout3Ds(call.arguments as String), callbackHandler)
            else -> startTokenize(DefaultCheckout(parsePaymentParameters(call.arguments as HashMap<String, *>)), callbackHandler)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
