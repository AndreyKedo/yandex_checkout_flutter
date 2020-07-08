///Currency for checkout.
///[RUB] - currency of Russian Federation.
///[USD] - currency of USA.
///[BYN] - currency of Republic Belarus.
///[UAH] - currency of Ukraine
//Full list https://www.currency-iso.org/dam/downloads/lists/list_one.xml
class Currency{
  final String index;

  const Currency._(this.index);

  ///Russian Ruble
  static const Currency RUB = const Currency._('RUB');
  ///US Dollar
  static const Currency USD = const Currency._('USD');
  ///Belarusian Ruble
  static const Currency BYN = const Currency._('BYN');
  ///Hryvnia
  static const Currency UAH = const Currency._('UAH');

  @override
  String toString() => index;
}