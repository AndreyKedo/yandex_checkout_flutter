import 'package:flutter/foundation.dart';
import 'package:yandex_checkout_flutter/src/enums/currency.dart';

///Payment amount.
///[value] amount value
///[currency] amount [Currency]
class Amount{
  final Currency currency;
  final double value;

  const Amount({@required this.currency, @required this.value});

  Map<String, dynamic> get map => <String, dynamic>{
    'currency': currency.index,
    'value': value
  };
}