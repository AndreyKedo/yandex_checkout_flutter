///There are three options for this setting. It has the following values [ON], [OFF], [SELECT].
class SavePaymentMethod{
  final String index;

  const SavePaymentMethod._(this.index);

  ///Always save payment method. User can select only from payment methods, that allow saving. On the contract screen user will see a message about saving his payment method.
  static const SavePaymentMethod ON = const SavePaymentMethod._('ON');
  ///Don't save payment method. User can select from all of the available payment methods.
  static const SavePaymentMethod OFF = const SavePaymentMethod._('OFF');
  ///User chooses to save payment method (user will have a switch to change selection, if payment method can be saved).
  static const SavePaymentMethod SELECT = const SavePaymentMethod._('SELECT');

  @override
  String toString() => index;
}