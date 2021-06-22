import 'dart:convert';
import 'dart:developer';

import 'package:belajar_bloc/model/res/res_list_user.dart';
import 'package:belajar_bloc/network/api.dart';
import 'package:belajar_bloc/network/dio_handler.dart';
import 'package:dio/dio.dart';

class UserRepo {
  Future<List<ResListUser>> getUsers() async {
    List<ResListUser> users = [];

    try{
      Response response = await dio.get(Api.getUser);

      users = resListUserFromJson(jsonEncode(response.data));

    }catch(e){
      log(e.toString());
    }

    return users;
  }
}