

import 'package:belajar_bloc/bloc/get_user_cubit/get_user_cubit.dart';

import 'package:belajar_bloc/bloc/get_user_cubit/get_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserCubitPage extends StatefulWidget {
  @override
  _ListUserCubitPageState createState() => _ListUserCubitPageState();
}

class _ListUserCubitPageState extends State<ListUserCubitPage> {
  final ScrollController _controller = ScrollController();
  GetUserCubit? cubit;

  GetUserState? currentState;


  @override
  void initState() {
    _controller.addListener(() {
      if(_controller.offset >= _controller.position.maxScrollExtent){
        loadMore();
      }
    });
    super.initState();
  }

  void loadMore(){
    if(currentState is GetUserSuccess){
      cubit?.getLoadMore();
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetUserCubit(GetUserInitial()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("List User"),
        ),
        body: SingleChildScrollView(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          child: BlocBuilder<GetUserCubit, GetUserState>(
            builder: (BuildContext context, GetUserState state) {
              cubit = context.read<GetUserCubit>();

              currentState = state;

              if (state is GetUserInitial) {
                cubit?.getUser();
              } else if (state is GetUserLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetUserNull) {
                return Center(child: Text(state.message),);
              } else if (state is GetUserError) {
                return Center(child: Text("Errpr"));
              } else if (state is GetUserSuccess) {
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: state.users.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.users[index].name ?? ""),
                          ),
                        );
                      },
                    ),
                    MaterialButton(onPressed: (){
                      loadMore();
                    }, child: Text("Load More"),)
                  ],
                );

              }else if (state is GetUserLoadingLoadMore) {
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: state.userslist.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.userslist[index].name ?? ""),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(),),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
