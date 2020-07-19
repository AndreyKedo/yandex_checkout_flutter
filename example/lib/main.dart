import 'package:flutter/material.dart';
import 'package:yandex_checkout_flutter/yandex_checkout_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _data = '';

  void _pay() async {
    final PaymentParameters param = PaymentParameters(
        amount: Amount(currency: Currency.RUB, value: 20.99),
        title: 'Anything',
        subTitle: 'Subtitle anything',
        clientApplicationKey: 'test_token',
        paymentMethodTypes: {
          PaymentMethodType.SBERBANK,
          PaymentMethodType.BANK_CARD,
          PaymentMethodType.GOOGLE_PAY,
        },
        googlePayParameters: {
          GooglePayParameters.MASTERCARD,
          GooglePayParameters.VISA
        },
        shopId: '000000');
    final Result result = await YandexCheckout().startTestCheckout(param);
    if(result.hasError)
      setState(() => _data = 'Error');
    else if(result.hasData){
      final data = result.data;
      setState(() => _data = data.token);
    }
    else
      setState(() => _data = 'Checkout cancel');
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Yandex checkout example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Text(_data, softWrap: true),
            ),
            OutlineButton(
                child: const Text('Buy anything...'),
                onPressed: ()  => _pay()
            )
          ],
        ),
      ),
    ),
  );
}
