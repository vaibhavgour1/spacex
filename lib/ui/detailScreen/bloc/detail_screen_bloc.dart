
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:makeb/main.dart';
import 'package:makeb/ui/detailScreen/bloc/detail_screen_event.dart';
import 'package:makeb/ui/detailScreen/bloc/detail_screen_state.dart';
import 'package:makeb/ui/homeScreen/model/home_screen_model.dart';
import 'package:makeb/utility/network_check.dart';
import 'package:makeb/utility/utility.dart';




class DetailScreenBloc extends Bloc<DetailScreenEvent, DetailScreenState> {
  DetailScreenBloc() : super(InitialState()) {
    on<GetDetailScreenEvent>(getUser);

  }

  Future<void> getUser(GetDetailScreenEvent event, Emitter<DetailScreenState> emit) async {

    emit( LoadingState());
    if (await Network.isConnected()) {
       //EasyLoading.show();
      Jscncode response = await apiProvider.getSpecificDetail(event.id);
      // EasyLoading.dismiss();
      if (response.id!.isNotEmpty) {
        emit(GetDetailScreenState(detailScreenModel: response));
      } else {
         EasyLoading.dismiss();
        emit(FailureState(message:""));
      }
    } else {
      Utility.showToast(msg: "please check your internet connection");
    }
  }
  }
