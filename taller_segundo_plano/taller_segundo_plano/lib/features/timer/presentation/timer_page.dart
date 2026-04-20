import 'package:flutter/material.dart';
import '../controller/timer_controller.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final controller = TimerController();
  String actionLabel = 'Presiona Iniciar para comenzar el cronómetro.';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void refresh() => setState(() {});

  void _updateAction(String label) {
    setState(() {
      actionLabel = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cronómetro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    controller.formattedTime,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              actionLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: controller.running
                      ? null
                      : () {
                          controller.start(refresh);
                          _updateAction(
                            'Iniciado a ${controller.formattedTime}',
                          );
                        },
                  child: const Text('Iniciar'),
                ),
                ElevatedButton(
                  onPressed: controller.running
                      ? () {
                          controller.pause(refresh);
                          _updateAction(
                            'Pausado a ${controller.formattedTime}',
                          );
                        }
                      : null,
                  child: const Text('Pausar'),
                ),
                ElevatedButton(
                  onPressed: controller.paused
                      ? () {
                          controller.resume(refresh);
                          _updateAction(
                            'Reanudado a ${controller.formattedTime}',
                          );
                        }
                      : null,
                  child: const Text('Reanudar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                  ),
                  onPressed: () {
                    controller.reset(refresh);
                    _updateAction('Reiniciado');
                  },
                  child: const Text('Reiniciar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              controller.running
                  ? 'Estado: En ejecución'
                  : controller.paused
                  ? 'Estado: Pausado'
                  : 'Estado: Detenido',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
