import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taller_segundo_plano/core/utils/app_logger.dart';
import '../controller/isolate_controller.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({super.key});

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  final controller = IsolateController();
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _elapsedTimer;

  String status = 'Listo para ejecutar';
  String result = '';
  String elapsedLabel = '0.00 s';
  bool loading = false;

  String _formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    final hundredths = (duration.inMilliseconds / 10).round() % 100;
    return '$seconds.${hundredths.toString().padLeft(2, '0')} s';
  }

  void _startElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!mounted) return;
      setState(() {
        elapsedLabel = _formatDuration(_stopwatch.elapsed);
      });
    });
  }

  void _stopElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  Future<void> runTask() async {
    AppLogger.log('ANTES: iniciando tarea pesada en isolate');
    setState(() {
      status = 'Enviando tarea al isolate...';
      result = '';
      loading = true;
      elapsedLabel = '0.00 s';
    });

    _stopwatch.reset();
    _stopwatch.start();
    _startElapsedTimer();

    final res = await controller.runHeavyTask();

    _stopwatch.stop();
    _stopElapsedTimer();
    AppLogger.log(
      'DESPUÉS: tarea pesada completada en ${_stopwatch.elapsedMilliseconds} ms',
    );

    setState(() {
      elapsedLabel = _formatDuration(_stopwatch.elapsed);
      status = 'Tarea completada';
      result = 'Resultado: $res';
      loading = false;
    });
  }

  @override
  void dispose() {
    _stopElapsedTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tarea pesada con Isolate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(status, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'Duración: $elapsedLabel',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (loading)
                      const CircularProgressIndicator()
                    else
                      Text(
                        result.isNotEmpty
                            ? result
                            : 'Pulsa ejecutar para iniciar la tarea pesada en un isolate.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: loading ? null : runTask,
              icon: const Icon(Icons.memory),
              label: const Text('Ejecutar tarea pesada'),
            ),
            const SizedBox(height: 16),
            const Text(
              'En web se usa una simulación porque Flutter web no soporta Isolates nativos.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
