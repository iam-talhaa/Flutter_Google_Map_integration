import 'package:flutter_google_map_integration/Data/Response/STATUS.dart';

class Apirespnse<T> {
  Status? _status;
  T? Data;

  String? message;

  Apirespnse([this.Data, this._status, this.message]);

  Apirespnse.loadinf() : _status = Status.Loading;
  Apirespnse.Completed() : _status = Status.Complted;
  Apirespnse.Error() : _status = Status.Error;

  String tostring() {
    return "Status :$_status";
  }
}
