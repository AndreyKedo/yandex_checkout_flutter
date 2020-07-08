///There are three options for this setting:
///[ON] - always save payment method. User can select only from payment methods, that allow saving.
///On the contract screen user will see a message about saving his payment method.
///[OFF] - don't save payment method. User can select from all of the available payment methods.
///[SELECT] - user chooses to save payment method (user will have a switch to change
///selection, if payment method can be saved).

class SavePaymentMethod{
  final String index;

  const SavePaymentMethod._(this.index);

  static const SavePaymentMethod ON = const SavePaymentMethod._('ON');
  static const SavePaymentMethod OFF = const SavePaymentMethod._('OFF');
  static const SavePaymentMethod SELECT = const SavePaymentMethod._('SELECT');

  @override
  String toString() => index;
}