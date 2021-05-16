import 'package:flutter/material.dart';

import '../model/post_model.dart';
import '../model/user_model.dart';
import '../service/jsonplaceholder_service.dart';
import '../view/jsonplaceholder_view.dart';

abstract class JsonPlaceHolderViewModel extends State<JsonPlaceHolderView> {
  JsonPlaceHolderService _service;
  List<UserModel> users = [];
  List<PostModel> posts = [];
  bool isLoading = false;

  loadingNotify() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();

    _service = JsonPlaceHolderService();
  }

  getAllPosts() async {
    loadingNotify();
    posts = await _service.get<PostModel>(path: "posts", model: PostModel());

    loadingNotify();
  }

  getAllUsers() async {
    loadingNotify();
    users = await _service.get<UserModel>(path: "users", model: UserModel());
    loadingNotify();
  }
}
