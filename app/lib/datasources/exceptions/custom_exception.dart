class CustomException implements Exception {
  final String message;
  final String _prefix;
  final int statusCode;

  CustomException([this.message, this._prefix, this.statusCode]);

  String toString() {
    return "$_prefix $message";
  }
}

class TimeOutFetchDataException extends CustomException {
  TimeOutFetchDataException([message])
      : super(message, "Timeout connection:", 504);
}

class SocketFetchException extends CustomException {
  SocketFetchException([message])
      : super(message, "No address associated with hostname:", 500);
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, "An error during fetch data: ", 500);
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Input request: ", 400);
}

class ResponseMessageException extends CustomException {
  ResponseMessageException([message]) : super(message, "", 400);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ", 401);
}
