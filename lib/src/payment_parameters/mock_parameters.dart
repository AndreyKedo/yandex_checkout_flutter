import 'package:yandex_checkout_flutter/src/payment_parameters/amount.dart';

//{
//  "show_logs" : true,
//  "google_pay_test" : false,
//  "mock_config": {
//    "complete_with_error": false,
//    "payment_auth_passed": false,
//    "cards_count": 1,
//    "amount" : {
//        "value": 0.0,
//        "currency": "RUB"
//      }
//  }
//}

///Wrapper for test parameters.
class TestParameters{
  ///Shows mSDK logs in the logcat (all mSDK logs start with tag "Yandex.Checkout.SDK").
  final bool showLogs;
  ///Enables google pay test environment - all transactions made with. Google Pay will use [WalletConstants.ENVIRONMENT_TEST]. More at: https://developers.google.com/pay/api/android/guides/test-and-deploy/integration-checklist#about-the-test-environment.
  final bool googlePayTestEnvironment;
  ///Configuration for mock parameters. If this parameter is present, mSDK will work in offline test mode. Token created with this configuration can't be used for payments.
  final MockConfiguration mockConfiguration;

  TestParameters({
    this.showLogs = false,
    this.googlePayTestEnvironment = false,
    this.mockConfiguration = const MockConfiguration()});

  Map<String, dynamic> get map => <String, dynamic>{
    'show_logs' : showLogs,
    'google_pay_test' : googlePayTestEnvironment,
    'mock_config' : mockConfiguration.map
  };
}

///Mock configuration. This parameters can be used only in offline test mode
class MockConfiguration{
  ///Complete payment with error.
  final bool completeWithError;
  ///Get preauthorized user
  final bool paymentAuthPassed;
  ///Number of linked cards for authorized user
  final int linkedCardsCount;
  ///Fee, that will be shown on the contract
  final Amount serviceFee;

  const MockConfiguration({
    this.completeWithError = false,
    this.paymentAuthPassed = false,
    this.linkedCardsCount = 1,
    this.serviceFee});

  Map<String, dynamic> get map => <String, dynamic>{
    'complete_with_error' : completeWithError,
    'payment_auth_passed' : paymentAuthPassed,
    'cards_count' : linkedCardsCount,
    'amount' : serviceFee?.map ?? null //FIX
  };
}