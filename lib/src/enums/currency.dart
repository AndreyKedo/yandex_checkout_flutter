///Currency for checkout. It has the following values [RUB], [USD], [BYN], [UAH].
//Full list https://www.currency-iso.org/dam/downloads/lists/list_one.xml
class Currency{
  final String index;

  const Currency._(this.index);

  ///Currency of Russian Federation.
  static const Currency RUB = const Currency._('RUB');
  ///Currency of USA.
  static const Currency USD = const Currency._('USD');
  ///Currency of Republic Belarus.
  static const Currency BYN = const Currency._('BYN');
  ///Currency of Ukraine
  static const Currency UAH = const Currency._('UAH');

  @override
  String toString() => index;
}