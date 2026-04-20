import 'package:taller_segundo_plano/core/utils/app_logger.dart';

class IsolateController {
  Future<int> runHeavyTask() async {
    AppLogger.log(
      'Simulación web: se ejecuta tarea pesada en el hilo principal',
    );
    await Future.delayed(const Duration(seconds: 2));
    AppLogger.log('Simulación web: tarea pesada completada');
    return 123456;
  }
}
