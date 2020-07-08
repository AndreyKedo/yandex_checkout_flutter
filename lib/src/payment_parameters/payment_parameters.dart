import 'package:flutter/foundation.dart';
import 'package:yandex_checkout_flutter/src/enums/google_pay_parameters.dart';
import 'package:yandex_checkout_flutter/src/enums/payment_method.dart';
import 'package:yandex_checkout_flutter/src/enums/save_payment_method.dart';
import 'package:yandex_checkout_flutter/src/payment_parameters/amount.dart';

///Wrapper for payment parameters.
///[amount] payment amount, see [Amount]. Available payment options can vary depending on amount.
///[title] name of the goods to be bought.
///[subtitle] description of the goods to be bought.
///[clientApplicationKey] merchant token from Yandex.Checkout.
///[shopId] shop id from Yandex.Checkout.
///[savePaymentMethod] setting for saving payment method (see [SavePaymentMethod]]).
///[paymentMethodTypes] (optional) set of permitted method types. Empty set or parameter absence means that all
///payment methods are allowed. See [PaymentMethodType].
///[gatewayId] (optional) your gateway id from Yandex.Money.
///[customReturnUrl] (optional) redirect url for custom 3ds. This parameter should be used only if you want to use
///your own 3ds activity.
///[userPhoneNumber] (optional) phone number of the user. It will be inserted into the form
///that is used by "Sberbank online" payment method. Format for this number is "+7XXXXXXXXXX".
///[googlePayParameters] (optional) settings for Google Pay (see [GooglePayParameters]).
//{
//  "amount":{
//    "value": 0.0,
//    "currency": "RUB"
//  },
//  "title": "Title",
//  "sub_title": "Subtitle",
//  "api_key": "API_KEY",
//  "shop_id": "SHOP_ID",
//  "save_pay_method": "ON|OFF|SELECT",
//  "payment_method": ["yandex", "google_pay", "card", "sberbank"],
//  "gateway_id": "id",
//  "custom_return_url": "URL",
//  "user_phone": "+xxxxxxxxxxx",
//  "google_pay_parameters": ["amex", "discover", "jcb", "mastercard", "visa", "interac", "other"]
//}
class PaymentParameters{
  final Amount amount;
  final String title;
  final String subTitle;
  final String clientApplicationKey;
  final String shopId;
  final SavePaymentMethod savePaymentMethod;
  final List<PaymentMethodType> paymentMethodTypes;
  final String gatewayId;
  final String customReturnUrl;
  final String userPhoneNumber;
  final List<GooglePayParameters> googlePayParameters;


  const PaymentParameters({
    @required this.amount,
    @required this.title,
    @required this.subTitle,
    @required this.clientApplicationKey,
    @required this.shopId,
    this.savePaymentMethod = SavePaymentMethod.OFF,
    this.paymentMethodTypes = PaymentMethodType.all,
    this.gatewayId,
    this.customReturnUrl,
    this.userPhoneNumber,
    this.googlePayParameters = GooglePayParameters.all});

  bool get isValid =>
      amount != null &&
      title != null &&
      subTitle != null &&
      clientApplicationKey != null &&
      shopId != null;

  Map<String, dynamic> get map => <String, dynamic>{
    'amount': amount.map,
    'title': title,
    'sub_title': subTitle,
    'api_key': clientApplicationKey,
    'shop_id': shopId,
    'user_phone': userPhoneNumber,
    'save_pay_method': savePaymentMethod.index,
    'gateway_id': gatewayId,
    'custom_return_url': customReturnUrl,
    'google_pay_parameters': googlePayParameters.map<String>((e) => e.index).toList(),
    'payment_method': paymentMethodTypes.map<String>((e) => e.index).toList()
  };
}
