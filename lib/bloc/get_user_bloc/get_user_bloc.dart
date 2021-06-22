import 'package:belajar_bloc/bloc/get_user_bloc/get_user_event.dart';
import 'package:belajar_bloc/bloc/get_user_bloc/get_user_state.dart';
import 'package:belajar_bloc/model/res/res_list_user.dart';
import 'package:belajar_bloc/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserCubit extends Bloc<GetUserEvent, GetUserState> {
  GetUserCubit(GetUserState initialState) : super(initialState);

  UserRepo userRepo = UserRepo();
  List<ResListUser> list = [];

  @override
  Stream<GetUserState> mapEventToState(GetUserEvent event) async* {
    if (event is EventGetUser) {
      yield* getUser();
    } else if (event is EventLoadMore) {
      yield GetUserLoadingLoadMore(list);

      List<ResListUser> listNew = await userRepo.getUsers();
      list.addAll(listNew);

      if (list.isNotEmpty) {
        yield GetUserSuccess(list);
      } else {
        yield GetUserNull("Data tidak ada");
      }
    }
  }

  Stream<GetUserState> getUser() async* {
    yield GetUserLoading();

    list = await userRepo.getUsers();

    if (list.isNotEmpty) {
      yield GetUserSuccess(list);
    } else {
      yield GetUserNull("Data tidak ada");
    }
  }
}
