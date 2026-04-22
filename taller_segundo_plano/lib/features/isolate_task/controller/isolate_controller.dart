// features/isolate_task/controller/isolate_controller.dart
import 'isolate_controller_impl.dart'
    if (dart.library.html) 'isolate_controller_web.dart'
    as impl;

class IsolateController {
  final impl.IsolateController _impl = impl.IsolateController();

  Future<int> runHeavyTask() => _impl.runHeavyTask();
}
