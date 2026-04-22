import 'dart:isolate';
import 'package:taller_segundo_plano/features/isolate_task/data/isolate_service.dart';
import 'package:taller_segundo_plano/core/utils/app_logger.dart';

class IsolateController {
  Future<int> runHeavyTask() async {
    AppLogger.log('ANTES: preparando mensaje para isolate (hilo principal)');
    final receivePort = ReceivePort();

    await Isolate.spawn(IsolateService.heavyTask, receivePort.sendPort);
    AppLogger.log('DURANTE: isolate spawn completado, esperando resultado');

    final result = await receivePort.first as int;
    AppLogger.log('DESPUÉS: resultado recibido del isolate');

    receivePort.close();
    return result;
  }
}
