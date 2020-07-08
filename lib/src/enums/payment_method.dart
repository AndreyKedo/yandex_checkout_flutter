///Type of selected payment method.
///[YANDEX_MONEY] - payment method Yandex.Money.
///[GOOGLE_PAY] -  payment method Google pay.
///[BANK_CARD] - payment method Bank card.
///[SBERBANK] - payment method Sberbank/

class PaymentMethodType{
  final String index;

  const PaymentMethodType._(this.index);
  
  static const PaymentMethodType YANDEX_MONEY = const PaymentMethodType._('yandex');
  static const PaymentMethodType GOOGLE_PAY = const PaymentMethodType._('google_pay');
  static const PaymentMethodType BANK_CARD = const PaymentMethodType._('card');
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

  static const List<PaymentMethodType> all = const <PaymentMethodType>[
    YANDEX_MONEY,
    GOOGLE_PAY,
    BANK_CARD,
    SBERBANK
  ];

  @override
  String toString() => index;
}