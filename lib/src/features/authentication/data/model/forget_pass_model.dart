class ForgetPassModel {
  late final String _statuscode;
  late final String _message;
  late final List<Data> _data;
  late final String _common;

  ForgetPassModel(
      {required String statusCode, required String message, required List<Data> data, required String common}) {
    _statuscode = statusCode;
    _message = message;
    _data = data;
    _common = common;
  }

  String get statuscode => _statuscode;
  set statuscode(String statuscode) => _statuscode = statuscode;
  String get message => _message;
  set message(String message) => _message = message;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;
  String get common => _common;
  set common(String common) => _common = common;

  ForgetPassModel.fromJson(Map<String, dynamic> json) {
    _statuscode = json['statuscode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
    _common = json['common'];
  }
}

class Data {
  late final String dataMessage;
  late final List<String> _dataUser;

  Data({required String dataMessage, required List<String> dataUser}) {
    dataMessage = dataMessage;
    _dataUser = dataUser;
  }
  List<String> get dataUser => _dataUser;
  set dataUser(List<String> dataUser) => _dataUser = dataUser;

  Data.fromJson(Map<String, dynamic> json) {
    dataMessage = json['data-Message'];
    _dataUser = json['data-User'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data-Message'] = dataMessage;
    data['data-User'] = _dataUser;
    return data;
  }
}

