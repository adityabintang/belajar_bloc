import 'package:belajar_bloc/model/res/res_list_user.dart';

abstract class GetUserState{}

class GetUserLoading extends GetUserState {}

class GetUserInitial extends GetUserState {}

class GetUserLoadingLoadMore extends GetUserState {
  final List<ResListUser> userslist;

  GetUserLoadingLoadMore(this.userslist);
}


class GetUserSuccess extends GetUserState {
  final List<ResListUser> users;

  GetUserSuccess(this.users);
}

class GetUserError extends GetUserState {}

class GetUserNull extends GetUserState {
  final String message;

  GetUserNull(this.message);
}
