import 'dart:convert';
import 'dart:io';

import 'package:generic_http_model_basic/model/base_model.dart';

abstract class IBaseService {
  Future<dynamic> get<T extends IBaseModel>({String path, IBaseModel model});
}
