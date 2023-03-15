import 'package:dio/dio.dart';
import 'package:makeb/api/Endpoint.dart';
import 'package:makeb/api/server_error.dart';
import 'package:makeb/main.dart';
import 'package:makeb/ui/homeScreen/model/home_screen_model.dart';

class ApiProvider {
  static ApiProvider apiProvider = ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() {
    return apiProvider;
  }

  Future<HomeScreenModel> getDetail() async {
    try {
      Response res = await dio.get(
        Endpoint.GET_ROCKETS,
      );
      Map<String, dynamic> data = {"jscncodes": res.data};
      return HomeScreenModel.fromJson(data);
    } catch (error) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Please try again later!";
      }
      print("Exception occurred: $message stackTrace: $error");
      return HomeScreenModel(jscncodes: []);
    }
  }

  Future<Jscncode> getSpecificDetail(String id) async {
    try {
      Response res = await dio.get("${Endpoint.GET_ROCKETS}/$id");
      return Jscncode.fromRawJson(res.toString());
    } catch (error) {
      String message = "";
      if (error is DioError) {
        ServerError e = ServerError.withError(error: error);
        message = e.getErrorMessage();
      } else {
        message = "Please try again later!";
      }
      print("Exception occurred: $message stackTrace: $error");
      return Jscncode(id: "0");
    }
  }
}
