import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBloc() : super(const UserBlocState.empty()) {
    on<UserBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
