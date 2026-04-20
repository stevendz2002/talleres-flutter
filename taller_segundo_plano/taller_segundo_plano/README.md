# Taller Segundo Plano

Este proyecto es una peque�a aplicaci�n Flutter que ilustra tres t�cnicas de programaci�n as�ncrona y de tareas pesadas:

- `Future` / `async` / `await`
- `Timer`
- `Isolate`

## Pantallas y flujos

1. **Async / Future**
   - Consulta un servicio simulado con `Future.delayed`.
   - Muestra estados: `Cargando...`, `Éxito` y `Error`.
   - Calcula y muestra el tiempo de procesamiento en pantalla.
   - Permite forzar un error para demostrar manejo de excepciones.

2. **Timer**
   - Cronómetro con botones: `Iniciar`, `Pausar`, `Reanudar` y `Reiniciar`.
   - Actualiza cada 100 ms para ver el tiempo con precisión.
   - Muestra la última acción realizada (Iniciar, Pausar, Reanudar, Reiniciar).
   - Cancela el timer al cerrar la pantalla.

3. **Isolate**
   - Ejecuta una tarea CPU-bound en un isolate usando `Isolate.spawn`.
   - Envía el resultado por `SendPort`.
   - Mide y muestra el tiempo total de ejecución de la tarea.
   - En Flutter web se usa una simulación porque los isolates nativos no son compatibles.

## Requisitos cubiertos

- `Future` / `async` / `await`:
  - El servicio simulado usa `Future.delayed` por 3 segundos.
  - La UI no se bloquea mientras espera.
  - Se muestra el estado actual más una opción para forzar error.
  - Se mide y muestra el tiempo de procesamiento en pantalla.

- `Timer`:
  - El cronómetro tiene controles de inicio, pausa, reanudar y reiniciar.
  - Actualiza el tiempo cada 100 ms.
  - Muestra la última acción realizada con la hora actual del marcador.
  - Se cancelan los recursos en `dispose()`.

- `Isolate`:
  - La tarea de suma grande se ejecuta en un isolate.
  - El resultado llega por mensajes y se presenta en pantalla.
  - Se calcula y muestra la duración total de la tarea pesada.

## �Cu�ndo usar cada t�cnica?

- `Future` / `async` / `await`: cuando necesitas realizar operaciones as�ncronas que no bloquean la UI, como llamadas de red, lectura de archivos o tareas de I/O.
- `Timer`: cuando necesitas ejecutar algo peri�dicamente, como un cron�metro, una cuenta regresiva o refrescar informaci�n cada cierto intervalo.
- `Isolate`: cuando tienes una operaci�n intensiva en CPU que podr�a bloquear el hilo principal y causar jank, como c�lculos matem�ticos pesados o procesamiento de datos grandes.

## Flujo de la aplicaci�n

```
Home
 +- Async / Future
 �    +- Inicio
 �    +- Cargando (Future.delayed)
 �    +- �xito o Error
 �    +- Mostrar resultado en pantalla
 +- Timer
 �    +- Iniciar -> Timer.periodic
 �    +- Pausar -> cancelar timer
 �    +- Reanudar -> reiniciar timer
 �    +- Reiniciar -> poner en cero
 +- Isolate
      +- Enviar tarea a Isolate.spawn
      +- Calcular suma pesada
      +- Recibir mensaje con SendPort
      +- Mostrar resultado final
```

## Ejecuci�n

```bash
flutter pub get
flutter run -d edge
```

## Estructura principal

- `lib/main.dart`: navega entre las pantallas.
- `lib/features/async_future`: implementaci�n de la simulaci�n de servicio.
- `lib/features/timer`: cron�metro con estado y botones.
- `lib/features/isolate_task`: tarea pesada con isolate.
- `lib/core/utils/app_logger.dart`: logger simple para trazar el orden de ejecuci�n.

## Notas

- El proyecto est� dise�ado para ser un ejercicio did�ctico.
- La separaci�n por caracter�sticas (`features`) facilita entender qu� hace cada parte.
- La simulaci�n web del isolate permite validar el flujo incluso en Edge.
