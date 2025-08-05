import 'package:flutter/material.dart';

class Appexception implements Exception {
  final _message;
  final _prefix;

  Appexception([this._message, this._prefix]);

  String tostring() {
    return 'Message :$_message  Prefix : $_prefix';
  }
}

class FetechDataException extends Appexception {
  FetechDataException([String? message])
    : super(message, 'Error Occur During Communication');
}

class unAuthorizedAcces extends Appexception {
  unAuthorizedAcces([String? message]) : super(message, 'Invalid Request');
}



