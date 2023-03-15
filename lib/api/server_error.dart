import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:makeb/utility/utility.dart';



class ServerError implements Exception {
  int? _errorCode = 200;
  String _errorMessage = "";

  ServerError.withError({required DioError? error}) {
    _handleError(error!);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) async {
    _errorCode = error.response!.statusCode!;
    print(error);
    print(error.message);
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "request  was  cancelled " ;
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = "connection  timeout " ;
        break;
      case DioErrorType.other:
        _errorMessage = "connection  failed  due  to  internet  connection ";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        if (error.response!.statusCode == 401||error.response!.statusCode == 403) {
          print("come here-->");

          _errorMessage = "Unauthorized";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 404) {
          print("come here-->");
          _errorMessage = "Request not found. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 202) {
          print("come here-->");
          _errorMessage = "Network congestion error. Please check your internet connection.";
          Utility.showToast(msg: _errorMessage);
        }

        if (error.response!.statusCode == 429) {
          print("come here-->");
          _errorMessage = "Network congestion error.. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 500) {
          print("come here-->");
          _errorMessage = "Something went wrong. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 502) {
          print("come here-->");
          _errorMessage = "Network congestion error.. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 503) {
          print("come here-->");
          _errorMessage = "The server is currently unavailable. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        if (error.response!.statusCode == 504) {
          print("come here-->");
          _errorMessage = "Gateway timeout. Please try again after some time.";
          Utility.showToast(msg: _errorMessage);
        }
        else {
          _errorMessage = "Internal server Error";
        }

        break;

      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    return _errorMessage;
  }


}
class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError,String message) {
    log("=====$message");
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}

