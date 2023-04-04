import 'package:flutter/material.dart';

typedef OnLoadNextListener = void Function();

class PaginationController extends ScrollController {
  PaginationController(OnLoadNextListener listener) {
    addListener(() {
      if (position.maxScrollExtent == position.pixels) {
        listener();
      }
    });
  }
}
