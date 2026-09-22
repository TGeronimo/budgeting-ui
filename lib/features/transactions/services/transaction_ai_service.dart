import 'dart:io';

import 'package:dio/dio.dart';

class TransactionAiService {

  final Dio dio;

  TransactionAiService(this.dio);

  Future<File> processAudio(File audioFile) async {
    throw UnimplementedError;

    // TODO transformar audioFile em MultipartFile
    // TODO criar um FormData contendo 'file'
    // TODO criar logs para registrar 'Arquivo recebido', 'Multipart criado', 'FormData criado'

  }

}