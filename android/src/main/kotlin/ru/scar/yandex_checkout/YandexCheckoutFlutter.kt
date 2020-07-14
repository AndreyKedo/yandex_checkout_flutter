package ru.scar.yandex_checkout

import android.app.Activity
import android.content.Intent
import io.flutter.Log
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import ru.yandex.money.android.sdk.*

const val REQUEST_TOKENIZE_CODE = 99

interface ResultCallback{
    fun success(token: TokenizationResult)
    fun failure(hasError: Boolean?)
}

open class YandexCheckoutFlutter : ActivityAware, PluginRegistry.ActivityResultListener {
    private var binding: ActivityPluginBinding? = null
    private var callback: ResultCallback? = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addActivityResultListener(this)
    }

    fun startTokenize(checkoutParam : CheckoutParam, resultCallback: ResultCallback){
        if(callback == null && binding != null){
            Log.d(TAG, "Input data tokenize $checkoutParam")
            callback = resultCallback
            binding?.let {
                when(checkoutParam){
                    is DefaultCheckout -> checkout(it.activity, checkoutParam.paymentParameters)
                    is DebugCheckout -> debugCheckout(it.activity, checkoutParam.paymentParameters, checkoutParam.testParameters)
                    is Checkout3Ds -> checkout3DS(it.activity, checkoutParam.url)
                }
            }
        }
    }

    private fun checkout3DS(context: Activity, url: String){
        val intent : Intent = Checkout.create3dsIntent(context, url, ColorScheme.getDefaultScheme())
        context.startActivityForResult(intent, REQUEST_TOKENIZE_CODE)
    }

    private fun checkout(context: Activity, paymentParameters: PaymentParameters){
        val intent : Intent = Checkout.createTokenizeIntent(context, paymentParameters)
        context.startActivityForResult(intent, REQUEST_TOKENIZE_CODE)
    }

    private fun debugCheckout(context: Activity, paymentParameters: PaymentParameters, testParameters: TestParameters?) {
        testParameters?.let {
            val intent : Intent = Checkout.createTokenizeIntent(
                    context,
                    paymentParameters,
                    it
            )
            context.startActivityForResult(intent, REQUEST_TOKENIZE_CODE)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) : Boolean{
        if(requestCode != REQUEST_TOKENIZE_CODE){
            callback = null
            return false
        }
        when(resultCode){
            Activity.RESULT_OK -> {
                if(data != null && callback != null)
                    callback!!.success(Checkout.createTokenizationResult(data))
            }
            Activity.RESULT_CANCELED -> callback?.failure(false)
            Checkout.RESULT_ERROR -> {
                if(data != null && callback != null)
                    callback!!.failure(true)
            }
            else -> {
                callback?.failure(true)
                callback = null
                return false
            }
        }
        callback = null
        return true
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.binding?.removeActivityResultListener(this)
        this.binding = binding
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        binding?.removeActivityResultListener(this)
        binding = null
    }

    override fun onDetachedFromActivity() {
        binding?.removeActivityResultListener(this)
        binding = null
    }
}