import 'package:yandex_checkout_flutter/src/payment_parameters/payment_parameters.dart';

///Settings for Google Pay payment method. This class is one of the parameters of [PaymentParameters].
///It has the following values [AMEX], [DISCOVER], [JCB], [MASTERCARD], [VISA], [INTERAC], [OTHER].
///If no value is specified, the default set will be use.
class GooglePayParameters{
  final String index;

  const GooglePayParameters._(this.index);

  static const GooglePayParameters AMEX = const GooglePayParameters._('amex');
  static const GooglePayParameters DISCOVER = const GooglePayParameters._('discover');
  static const GooglePayParameters JCB = const GooglePayParameters._('jcb');
  static const GooglePayParameters MASTERCARD = const GooglePayParameters._('mastercard');
  static const GooglePayParameters VISA = const GooglePayParameters._('visa');
  static const GooglePayParameters INTERAC = const GooglePayParameters._('interac');
  static const GooglePayParameters OTHER = const GooglePayParameters._('other');

  static const Set<GooglePayParameters> all = const <GooglePayParameters>{
    AMEX,
    DISCOVER,
    JCB,
    VISA,
    MASTERCARD
  };

  @override
  String toString() => index;
}