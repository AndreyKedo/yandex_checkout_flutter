import 'package:flutter/foundation.dart';
import 'package:yandex_checkout_flutter/src/enums/currency.dart';

///Payment amount.
class Amount{
  ///Amount [Currency].
  final Currency currency;
  ///Amount value.
  final double value;

  const Amount({@required this.currency, @required this.value});

  Map<String, dynamic> get map => <String, dynamic>{
    'currency': currency.index,
    'value': value
  };
}