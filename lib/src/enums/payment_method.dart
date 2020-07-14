///Type of selected payment method. It has the following values [YANDEX_MONEY], [GOOGLE_PAY], [BANK_CARD], [SBERBANK].
class PaymentMethodType{
  final String index;

  const PaymentMethodType._(this.index);

  ///Payment method Yandex.Money.
  static const PaymentMethodType YANDEX_MONEY = const PaymentMethodType._('yandex');
  ///Payment method Google pay.
  static const PaymentMethodType GOOGLE_PAY = const PaymentMethodType._('google_pay');
  ///Payment method Bank card.
  static const PaymentMethodType BANK_CARD = const PaymentMethodType._('card');
  ///Payment method Sberbank.
  static const PaymentMethodType SBERBANK = const PaymentMethodType._('sberbank');

  static PaymentMethodType tryParse(String index){
    switch(index){
      case 'sberbank':
        return PaymentMethodType.SBERBANK;
      case 'card':
        return PaymentMethodType.BANK_CARD;
      case 'google_pay':
        return PaymentMethodType.GOOGLE_PAY;
      case 'yandex':
        return PaymentMethodType.YANDEX_MONEY;
      default:
        throw Exception('Parse PaymentMethodType exception');
    }
  }

  static const Set<PaymentMethodType> all = const <PaymentMethodType>{
    YANDEX_MONEY,
    GOOGLE_PAY,
    BANK_CARD,
    SBERBANK
  };

  @override
  String toString() => index;
}