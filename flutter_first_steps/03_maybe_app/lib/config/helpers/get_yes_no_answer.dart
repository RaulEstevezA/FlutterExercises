import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:maybe_app/domain/entities/message.dart';
import 'package:maybe_app/infrastructure/models/yes_no_model.dart';

class GetYesNoAnswer {
  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');

    final data = response.data;
    final jsonMap = data is String
        ? Map<String, dynamic>.from(jsonDecode(data))
        : Map<String, dynamic>.from(data);

    final yesNoModel = YesNoModel.fromJsonMap(jsonMap);

    return Message(
      text: yesNoModel.answer,
      fromWho: FromWho.hers,
      imageUrl: yesNoModel.image,
    );
  }
}
