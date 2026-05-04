# Taller Segundo Plano

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Firebase App Distribution](https://img.shields.io/badge/Firebase-App%20Distribution-orange?logo=firebase)](https://firebase.google.com/docs/app-distribution)

> **Repositorio:** https://github.com/stevendz2002/talleres-flutter

Este proyecto es una pequeña aplicación Flutter que ilustra tres técnicas de programación asíncrona y de tareas pesadas:

- `Future` / `async` / `await`
- `Timer`
- `Isolate`

---

## Publicación vía Firebase App Distribution

### Flujo general

```
Código Flutter
    ↓
flutter build apk --release
    ↓
APK en build/app/outputs/flutter-apk/app-release.apk
    ↓
Firebase Console → App Distribution → Upload APK
    ↓
Asignar grupo QA_Clase + Release Notes
    ↓
Distribuir → Testers reciben correo de Firebase
    ↓
Tester instala Firebase App Tester (primera vez)
    ↓
App instalada en dispositivo Android físico
    ↓
Pruebas QA → Bitácora de incidencias (docs/qa/QA_LOG.md)
```

### Pasos resumidos para replicar

1. **Generar APK de release:**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk --release
   ```

2. **Subir a Firebase App Distribution:**
   - Ir a [Firebase Console](https://console.firebase.google.com/) → tu proyecto → **App Distribution**.
   - Hacer clic en **Upload** y seleccionar `build/app/outputs/flutter-apk/app-release.apk`.
   - Agregar Release Notes (ver `docs/firebase/RELEASE_NOTES.md`).
   - Asignar al grupo `QA_Clase`.
   - Hacer clic en **Distribute**.

3. **Testers:**
   - Los testers reciben un correo automático de Firebase.
   - Instalan **Firebase App Tester** y luego la app.

4. **Actualización incremental:**
   - Actualizar `version` en `pubspec.yaml` (ej: `1.0.0+1` → `1.0.1+2`).
   - Repetir desde el paso 1.

Para la guía completa, ver [`docs/firebase/FIREBASE_SETUP.md`](docs/firebase/FIREBASE_SETUP.md).

---

## Versionado

Este proyecto sigue el esquema de Flutter para Android:

```yaml
version: MAJOR.MINOR.PATCH+BUILD_NUMBER
```

| Campo          | Descripción                                           |
|----------------|-------------------------------------------------------|
| `MAJOR.MINOR.PATCH` | `versionName` visible al usuario (ej: `1.0.1`)  |
| `BUILD_NUMBER` | `versionCode` entero incremental (ej: `2`)            |

### Historial de versiones

| Versión | Build | Fecha      | Cambios principales                         |
|---------|-------|------------|---------------------------------------------|
| 1.0.0   | 1     | 2026-05-03 | Primera release — Firebase App Distribution |
| 1.0.1   | 2     | 2026-05-03 | Fix permiso INTERNET + documentación QA     |

### Formato de Release Notes

```
v{version} ({fecha})

Cambios:
- Descripción de cambio 1
- Descripción de cambio 2

Responsable: {nombre}
Credenciales de prueba: {si aplica}
```

---

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

---

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

---

## ¿Cuándo usar cada técnica?

- `Future` / `async` / `await`: cuando necesitas realizar operaciones asíncronas que no bloquean la UI, como llamadas de red, lectura de archivos o tareas de I/O.
- `Timer`: cuando necesitas ejecutar algo periódicamente, como un cronómetro, una cuenta regresiva o refrescar información cada cierto intervalo.
- `Isolate`: cuando tienes una operación intensiva en CPU que podría bloquear el hilo principal y causar jank, como cálculos matemáticos pesados o procesamiento de datos grandes.

---

## Flujo de la aplicación

```
Home
 ├── Async / Future
 │    ├── Inicio
 │    ├── Cargando (Future.delayed)
 │    ├── Éxito o Error
 │    └── Mostrar resultado en pantalla
 ├── Timer
 │    ├── Iniciar → Timer.periodic
 │    ├── Pausar → cancelar timer
 │    ├── Reanudar → reiniciar timer
 │    └── Reiniciar → poner en cero
 └── Isolate
      ├── Enviar tarea a Isolate.spawn
      ├── Calcular suma pesada
      ├── Recibir mensaje con SendPort
      └── Mostrar resultado final
```

---

## Ejecución

```bash
flutter pub get
flutter run
```

Para ejecutar en navegador:
```bash
flutter run -d chrome
```

---

## Estructura principal

- `lib/main.dart`: navega entre las pantallas.
- `lib/features/async_future`: implementación de la simulación de servicio.
- `lib/features/timer`: cronómetro con estado y botones.
- `lib/features/isolate_task`: tarea pesada con isolate.
- `lib/core/utils/app_logger.dart`: logger simple para trazar el orden de ejecución.
- `docs/firebase/FIREBASE_SETUP.md`: guía de configuración de Firebase App Distribution.
- `docs/firebase/RELEASE_NOTES.md`: notas de cada release distribuido.
- `docs/qa/QA_LOG.md`: bitácora de pruebas QA.

---

## Notas

- El proyecto está diseñado para ser un ejercicio didáctico.
- La separación por características (`features`) facilita entender qué hace cada parte.
- La simulación web del isolate permite validar el flujo incluso en Chrome/Edge.
