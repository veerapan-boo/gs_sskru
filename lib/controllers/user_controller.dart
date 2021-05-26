import 'package:animate_icons/animate_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController {
  // final _user = UserModel.obs;

  // get getUser => _user;

  // setUser(UserModel usermodel) {
  //   _user.value = usermodel;
  // }
}

class UserModel {
  String name = '';
  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
  }
}
