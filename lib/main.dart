import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeb/api/Endpoint.dart';
import 'package:makeb/api/api_provider.dart';
import 'package:makeb/ui/splash/splash.dart';
import 'package:makeb/utility/color.dart';
BaseOptions baseOptions = BaseOptions(
  baseUrl: Endpoint.BASE_URL,
  receiveTimeout: 60000,
  sendTimeout: 60000,
  responseType: ResponseType.json,
  maxRedirects: 3,
);
Dio dio = Dio(baseOptions);
ApiProvider apiProvider = ApiProvider();

configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..progressColor = colorPrimary
    ..backgroundColor = colorPrimary
    ..indicatorColor = colorPrimary
    ..textColor = colorPrimary
    ..maskColor = colorPrimary
    ..userInteractions = false
    ..dismissOnTap = false;
}
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: colorPrimary,
  ));

  dio.interceptors.add(LogInterceptor(
      responseBody: true,
      responseHeader: false,
      requestBody: true,
      request: true,
      requestHeader: true,
      error: true,
      logPrint: (text) {
        log(text.toString());
      }));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rocket Expo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

