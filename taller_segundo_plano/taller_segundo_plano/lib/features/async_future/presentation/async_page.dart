import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taller_segundo_plano/core/utils/app_logger.dart';
import '../controller/async_controller.dart';

class AsyncPage extends StatefulWidget {
  const AsyncPage({super.key});

  @override
  State<AsyncPage> createState() => _AsyncPageState();
}

class _AsyncPageState extends State<AsyncPage> {
  final controller = AsyncController();
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  bool loading = false;
  bool simulateError = false;

  String result = "";
  String error = "";
  String elapsed = "0.00 s";

  // 🔹 FORMATEO TIEMPO
  String _format(Duration d) {
    final s = d.inSeconds;
    final ms = (d.inMilliseconds / 10).round() % 100;
    return "$s.${ms.toString().padLeft(2, '0')} s";
  }

  // 🔹 TIMER UI
  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!mounted) return;

      setState(() {
        elapsed = _format(_stopwatch.elapsed);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // 🔥 FUNCIÓN PRINCIPAL CORREGIDA
  Future<void> getData() async {
    AppLogger.log('ANTES: inicio de la llamada');

    setState(() {
      loading = true;
      result = "";
      error = "";
      elapsed = "0.00 s";
    });

    _stopwatch
      ..reset()
      ..start();

    _startTimer();

    try {
      final data = await controller.loadData(simulateError: simulateError);

      final time = _stopwatch.elapsedMilliseconds;

      AppLogger.log('DESPUÉS: async completado en $time ms');

      setState(() {
        result = data;
      });
    } catch (e) {
      final time = _stopwatch.elapsedMilliseconds;

      AppLogger.log('DESPUÉS: error en async ($time ms)');

      setState(() {
        error = "Error cargando datos";
      });
    } finally {
      _stopwatch.stop();
      _stopTimer();

      setState(() {
        loading = false;
        elapsed = _format(_stopwatch.elapsed);
      });
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async Future")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📌 Estado
            if (loading)
              const Text("Cargando...", style: TextStyle(color: Colors.blue))
            else if (result.isNotEmpty)
              Text(
                "Éxito: $result",
                style: const TextStyle(color: Colors.green),
              )
            else if (error.isNotEmpty)
              Text("Error: $error", style: const TextStyle(color: Colors.red))
            else
              const Text("Presiona el botón para iniciar"),

            const SizedBox(height: 20),

            // ⏱️ TIEMPO
            Text("Tiempo: $elapsed", style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            // ⚠️ ERROR SWITCH
            SwitchListTile(
              title: const Text("Simular error"),
              value: simulateError,
              onChanged: loading
                  ? null
                  : (v) => setState(() => simulateError = v),
            ),

            const SizedBox(height: 20),

            // 🚀 BOTÓN
            ElevatedButton(
              onPressed: loading ? null : getData,
              child: const Text("Cargar datos"),
            ),
          ],
        ),
      ),
    );
  }
}
