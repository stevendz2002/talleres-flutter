// features/async_future/controller/async_controller.dart

import 'package:taller_segundo_plano/features/async_future/data/fake_service.dart';
import 'package:taller_segundo_plano/core/utils/app_logger.dart';

class AsyncController {
  final service = FakeService();

  Future<String> loadData({bool simulateError = false}) async {
    AppLogger.log('DURANTE: ejecutando async/await');

    final result = await service.fetchData(simulateError: simulateError);

    return result;
  }
}
