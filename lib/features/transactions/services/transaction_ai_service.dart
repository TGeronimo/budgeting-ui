import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class TransactionAiService {

  final Dio _dio;
  Directory? _tempDirectory;
  String? _receivedFilePath;

  TransactionAiService({
    Dio? dio
  }) : _dio = dio ?? Dio();

  Future<File> processAudio(File audioFile) async {
    if (await audioFile.exists()) {
      debugPrint('Arquivo recebido do caminho ${audioFile.path}');
    } else {
      debugPrint('Arquivo não encontrado');
    }

    MultipartFile file = await MultipartFile.fromFile(
        audioFile.path,
        filename: 'transaction.wav');
    debugPrint('${file.filename} MultipartFile criado');

    FormData formData = FormData.fromMap({
      'file': file
    });
    debugPrint('FormData criado');
    
    try {
      debugPrint('Enviando arquivo ${audioFile.path}');
      final response = await _dio.post(
        '/transactions/ai',
        data: formData,
        options: Options(responseType: ResponseType.bytes)
      );
      debugPrint('${response.statusCode}');
      debugPrint('Recebidos ${response.data.length} bytes');

      _tempDirectory = await getTemporaryDirectory();
      final tempDirPath = _tempDirectory!.path;
      _receivedFilePath = '$tempDirPath/transaction-response.mp3';


      File responseAudio = File(_receivedFilePath!);
      await responseAudio.writeAsBytes(response.data);

      if(!responseAudio.existsSync()) {
        throw Exception('Arquivo não encontrado em ${responseAudio.path}');
      }

      debugPrint(
        'MP3 salvo em: ${responseAudio.path}',
      );
      debugPrint(
        'Tamanho MP3: ${await responseAudio.length()} bytes',
      );

      return responseAudio;

    } on DioException catch (e) {
      debugPrint('Type: ${e.type}');
      debugPrint('Message: ${e.message}');
      debugPrint('Status: ${e.response?.statusCode}');
      debugPrint('Data: ${e.response?.data}');

      debugPrint('ERROR: ${e.error}');
      throw Exception('Erro na comunicação com backend ${e.message}');

    }

  }

}