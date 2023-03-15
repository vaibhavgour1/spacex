import 'package:equatable/equatable.dart';
import 'package:makeb/ui/homeScreen/model/home_screen_model.dart';

class HomeScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends HomeScreenState {
  InitialState();
  @override
  List<Object?> get props =>[];
}

class LoadingState extends HomeScreenState {
  LoadingState();
  @override
  List<Object?> get props =>[];
}

class GetHomeScreenState extends HomeScreenState {
  final HomeScreenModel homeScreenModel;
  GetHomeScreenState({required this.homeScreenModel});
  @override
  List<Object?> get props => [homeScreenModel];
}

class FailureState extends HomeScreenState {
  final String message;
  FailureState({required this.message});
  @override
  List<Object?> get props => [message];
}
