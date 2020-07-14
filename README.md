# YandexCheckout

Implementation Yandex Checkout SDK for Flutter.
Official documentation for [native lib (Android)](https://github.com/yandex-money/yandex-checkout-android-sdk)

Use official documentation for [settings Yandex.Login feature](https://github.com/yandex-money/yandex-checkout-android-sdk#%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-yandexloginsdk)

> **Plugin not supported for IOS!**
## Feature

* [Default tokenization](https://github.com/yandex-money/yandex-checkout-android-sdk#%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA-%D1%82%D0%BE%D0%BA%D0%B5%D0%BD%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8)
* [Testing tokenization](https://github.com/yandex-money/yandex-checkout-android-sdk#%D1%82%D0%B5%D1%81%D1%82%D0%BE%D0%B2%D1%8B%D0%B5-%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80%D1%8B-%D0%B8-%D0%BE%D1%82%D0%BB%D0%B0%D0%B4%D0%BA%D0%B0)
* [3Ds tokenization](https://github.com/yandex-money/yandex-checkout-android-sdk#3dsecure)

## Example

Demonstrated how use plugin features.

### Test checkout

```dart
void checkout() async{
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
       if(result.hasError){
          //If checkout process ended with error
       }
       else if(result.hasData){
         //Take TokenizationResult result.data
       }
       else{
          //If checkout process cancel
       }
}
```

### Default checkout

```dart
void checkout() async{
  final Result result = await YandexCheckout().startCheckout(
    PaymentParameters(
           amount: Amount(currency: Currency.RUB, value: 20.99),
           title: 'Anything',
           subTitle: 'Subtitle anything',
           clientApplicationKey: 'YOUR_TOKEN',
           shopId: 'YOUR_SHOP_ID')
  );
  result.whenWithResult<void>((result){
    //Success
  }, (){
    //Cancel
  }, (){
    //Error
  });
}
```

### 3Ds checkout

```dart
void checkout() async{
 final Result result = await YandexCheckout().start3DsCheckout('YOUR_3DS_URL');
 //Handle result...
}
```