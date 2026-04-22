// features/async_future/data/fake_service.dart

import 'package:taller_segundo_plano/core/utils/app_logger.dart';

class FakeService {
  Future<String> fetchData({bool simulateError = false}) async {
    AppLogger.log('DURANTE: llamada al servicio');

    await Future.delayed(const Duration(seconds: 3));

    if (simulateError) {
      AppLogger.log('DESPUÉS: error en servicio');
      throw Exception('Error simulado del servicio');
    }

    AppLogger.log('DESPUÉS: datos recibidos');

    return 'Datos cargados correctamente';
  }
}
