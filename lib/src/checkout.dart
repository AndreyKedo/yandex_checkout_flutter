import 'package:flutter/services.dart';
import 'package:yandex_checkout/src/payment_parameters/mock_parameters.dart';
import 'package:yandex_checkout/src/payment_parameters/payment_parameters.dart';
import 'package:yandex_checkout/src/result.dart';

///[YandexCheckout] is singleton class for working with YandexCheackout native API.
class YandexCheckout {
  static const MethodChannel _channel = const MethodChannel('yandex_checkout');

  //----------------------------------------------------------------------------
  static const YandexCheckout _instance = const YandexCheckout._();
  const YandexCheckout._();
  factory YandexCheckout() => _instance;
  //----------------------------------------------------------------------------

  Result _parseResult(Map<String, dynamic> map) => map['success'] ?
  TokenizationResult.fromMap(Map<String, dynamic>.from(map['data'])) :
  map['hasError'] ? ErrorResult() : CancelResult();

  ///Start checkout process.
  ///[PaymentParameters] parameters for starting checkout process.
  Future<Result> startCheckout(PaymentParameters paymentParameters) async {
    assert(paymentParameters != null);
    assert(paymentParameters.isValid);
    final Map<String, dynamic> result = await _channel.invokeMapMethod<String, dynamic>('startPay', paymentParameters.map);
    return _parseResult(result);
  }

  ///Test checkout process. Only for DEBUG!
  ///[PaymentParameters] parameters for starting checkout process.
  ///[TestParameters] mocking parameters for offline checkout.
  Future<Result> startTestCheckout(PaymentParameters paymentParameters, TestParameters testParameters) async {
    assert(paymentParameters != null && testParameters != null);
    assert(paymentParameters.isValid);
    final Map<String, dynamic> result = await _channel.invokeMapMethod<String, dynamic>('startPay', <String, dynamic>{
      'payment_parameters': paymentParameters.map,
      'mock_param' : testParameters.map
    });
    return _parseResult(result);
  }

  ///Start 3Ds checkout.
  ///You should not use this method if [PaymentParameters.customReturnUrl] is present.
  ///[url] - to open 3DS, should be valid https url.
  Future<Result> start3DsCheckout(String url) async{
    assert(url != null);
    assert(url.isNotEmpty);
    final Map<String, dynamic> result = await _channel.invokeMapMethod<String, dynamic>('startPay', url);
    return _parseResult(result);
  }
}
