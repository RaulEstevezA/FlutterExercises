import 'package:dio/dio.dart';
import 'package:maybe_app/domain/entities/message.dart';

class GetYesNoAnswer {

  final _dio = Dio();

  Future <Message> getAnswer() async {
    final response = await _dio.get('https://yes-no-wtf.vercel.app/');

    throw UnimplementedError();
  }
}