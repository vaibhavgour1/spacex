import 'package:equatable/equatable.dart';
import 'package:makeb/ui/homeScreen/model/home_screen_model.dart';



class DetailScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends DetailScreenState {
  InitialState();
  @override
  List<Object?> get props =>[];
}

class LoadingState extends DetailScreenState {
  LoadingState();
  @override
  List<Object?> get props =>[];
}

class GetDetailScreenState extends DetailScreenState {
  final Jscncode detailScreenModel;
  GetDetailScreenState({required this.detailScreenModel});
  @override
  List<Object?> get props => [detailScreenModel];
}

class FailureState extends DetailScreenState {
  final String message;
  FailureState({required this.message});
  @override
  List<Object?> get props => [message];
}
