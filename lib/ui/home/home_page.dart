

import 'package:belajar_bloc/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:belajar_bloc/bloc/get_user_bloc/get_user_state.dart';
import 'package:belajar_bloc/ui/list_user/list_user.dart';
import 'package:belajar_bloc/ui/list_user_cubit/list_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              child: Text("List User Bloc"),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ListUserPage()));
              },
            ),
            MaterialButton(
              child: Text("List User Cubit"),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ListUserCubitPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
