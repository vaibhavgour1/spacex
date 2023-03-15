import 'package:equatable/equatable.dart';

class DetailScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDetailScreenEvent extends DetailScreenEvent {
String id;
GetDetailScreenEvent({required this.id});
  @override
  List<Object> get props => [id];
}
