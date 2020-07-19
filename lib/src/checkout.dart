import 'package:flutter/services.dart';
import 'package:yandex_checkout_flutter/src/3ds_result.dart';
import 'package:yandex_checkout_flutter/src/payment_parameters/mock_parameters.dart';
import 'package:yandex_checkout_flutter/src/payment_parameters/payment_parameters.dart';
import 'package:yandex_checkout_flutter/src/result.dart';

///Is singleton class for working with Yandex Checkout native API.
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

  Result3ds _parse3dsResult(Map<String, dynamic> map) => map['success'] ? Success() :
  map['hasError'] ? Error() : Cancel();

  ///Start checkout process.
  ///[PaymentParameters] parameters for starting checkout process.
  Future<Result> startCheckout(PaymentParameters paymentParameters) async {
    assert(paymentParameters != null);
    assert(paymentParameters.isValid);
    return _channel.invokeMapMethod<String, dynamic>('startPay', paymentParameters.map).then<Result>((value) => _parseResult(value));
  }

  ///Test checkout process. Only for DEBUG!
  ///[PaymentParameters] parameters for starting checkout process.
  ///[TestParameters] mocking parameters for offline checkout.
  Future<Result> startTestCheckout(PaymentParameters paymentParameters, {TestParameters testParameters = const TestParameters()}) async {
    assert(paymentParameters != null);
    assert(paymentParameters.isValid);
    return _channel.invokeMapMethod<String, dynamic>('startPay', <String, dynamic>{
      'payment_parameters': paymentParameters.map,
      'mock_param' : testParameters.map
    }).then<Result>((value) => _parseResult(value));
  }

  ///Start 3Ds checkout.
  ///You should not use this method if [PaymentParameters.customReturnUrl] is present.
  ///[url] - to open 3DS, should be valid https url.
  Future<Result3ds> start3DsCheckout(String url) async{
    assert(url != null);
    assert(url.isNotEmpty);
    return _channel.invokeMapMethod<String, dynamic>('start3ds', url).then((value) => _parse3dsResult(value));
  }
}
