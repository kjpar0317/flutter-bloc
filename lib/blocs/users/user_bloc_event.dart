part of 'user_bloc.dart';

@immutable
abstract class UserBlocEvent {
  const UserBlocEvent();
}

@immutable
class ChangeTextEvent extends UserBlocEvent {
  const ChangeTextEvent();
}
