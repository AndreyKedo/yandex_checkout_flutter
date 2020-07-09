import 'package:yandex_checkout_flutter/src/enums/payment_method.dart';

///Is sealed class. Extended classes [TokenizationResult], [CancelResult].
abstract class Result{
  ///Handler result success either fail. [R] return type from callback.
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
  ///Result of successful tokenization is of type [TokenizationResult].
  ///If data not exist it is throw assert.
  TokenizationResult get data{
    assert(!(this is ErrorResult || this is CancelResult));
    return this as TokenizationResult;
  }
  ///Return true if result has error.
  bool get hasError => this is ErrorResult;
  ///Return true if tokenization process is cancel.
  bool get cancel => this is CancelResult;
  ///Return true if tokenization process ended success.
  bool get hasData => this is TokenizationResult;
}

///Result for payment tokenization.
class TokenizationResult extends Result{
  ///Type of selected payment method.
  final PaymentMethodType paymentMethodType;
  ///Checkout result token.
  final String token;

  TokenizationResult._(this.paymentMethodType, this.token);

  factory TokenizationResult.fromMap(Map<String, dynamic> map) => TokenizationResult._(
      PaymentMethodType.tryParse(map['payment_method']),
      map['token']
  );
}
///Cancel tokenization
class CancelResult extends Result {}

///Tokenization ended with error.
class ErrorResult extends Result {}