import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:makeb/main.dart';
import 'package:makeb/ui/homeScreen/bloc/home_screen_event.dart';
import 'package:makeb/ui/homeScreen/bloc/home_screen_state.dart';
import 'package:makeb/ui/homeScreen/model/home_screen_model.dart';
import 'package:makeb/utility/network_check.dart';
import 'package:makeb/utility/utility.dart';


class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(InitialState()) {
    on<GetHomeScreenEvent>(getUser);

  }

  Future<void> getUser(GetHomeScreenEvent event, Emitter<HomeScreenState> emit) async {

    emit( LoadingState());
    if (await Network.isConnected()) {
       //EasyLoading.show();
      HomeScreenModel response = await apiProvider.getDetail();
      // EasyLoading.dismiss();
      if (response.jscncodes!.first.id!.isNotEmpty) {
        log("message=>${response.jscncodes!.first.name}");

        emit(GetHomeScreenState(homeScreenModel: response));
      } else {
         EasyLoading.dismiss();
        emit(FailureState(message:""));
      }
    } else {
      Utility.showToast(msg: "please check your internet connection");
    }
  }
  }
