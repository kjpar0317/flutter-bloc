part of 'user_bloc.dart';

class UserBlocState extends Equatable {
  final String id;
  final String name;
  final String password;
  final String role;

  const UserBlocState.empty()
      : id = '',
        name = '',
        password = '',
        role = '';

  const UserBlocState({
    required this.id,
    required this.name,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [id, name, password, role];
}
