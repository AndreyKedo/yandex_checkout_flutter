import 'package:yandex_checkout/src/enums/payment_method.dart';

///[Result] sealed class. Extended classes [TokenizationResult], [CancelResult].
///[whenWithResult] handler result success either fail.
abstract class Result{
  R whenWithResult<R>(
      R Function(TokenizationResult result) success,
      R Function() cancel,
      R Function() error,
      ) {
    if (this is TokenizationResult)
      return success(this);
    else if(this is ErrorResult)
      return error();
    else
      return cancel();
  }
  TokenizationResult get data{
    assert(!(this is ErrorResult || this is CancelResult));
    return this as TokenizationResult;
  }
  bool get hasError => this is ErrorResult;
  bool get cancel => this is CancelResult;
  bool get hasData => this is TokenizationResult;
}

///Result for payment tokenization.
///[paymentMethodType] Type of selected payment method.
///[token] checkout result token.
class TokenizationResult extends Result{
  final PaymentMethodType paymentMethodType;
  final String token;

  TokenizationResult._(this.paymentMethodType, this.token);

  factory TokenizationResult.fromMap(Map<String, dynamic> map) => TokenizationResult._(
      PaymentMethodType.tryParse(map['payment_method']),
      map['token']
  );
}

class CancelResult extends Result {}

class ErrorResult extends Result {}