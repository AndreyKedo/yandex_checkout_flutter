
///Is sealed class for 3Ds. Extended classes [Success], [Cancel], [Error].
abstract class Result3ds{

  R whenWithResult<R>(
      {
        R Function() success,
        R Function() cancel,
        R Function() error,
      }
      ) {
    if (this is Success)
      return success();
    else if(this is Cancel)
      return cancel();
    return error();
  }

  bool get hasError => this is Error;
  bool get isCancel => this is Cancel;
  bool get isSuccess => this is Success;
}
///3Ds ended success
class Success extends Result3ds{}
///3Ds cancel
class Cancel extends Result3ds{}
///3Ds completed with error
class Error extends Result3ds{}