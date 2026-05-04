# 🔥 Guía de configuración — Firebase App Distribution

## Requisitos previos

- Cuenta de Google con acceso a [Firebase Console](https://console.firebase.google.com/)
- Flutter SDK instalado y funcionando
- Android Studio o CLI de Flutter operativa

---

## 1. Crear/Abrir Proyecto en Firebase Console

1. Ir a [https://console.firebase.google.com/](https://console.firebase.google.com/)
2. Crear un nuevo proyecto o seleccionar el existente.
3. Aceptar los términos y completar la configuración inicial.

---

## 2. Registrar la App Android

1. En la pantalla principal del proyecto, hacer clic en **"Agregar app"** → seleccionar **Android**.
2. Ingresar el `applicationId` de la app:
   ```
   com.example.taller_segundo_plano
   ```
   > Este valor se encuentra en `android/app/build.gradle.kts` bajo `applicationId`.

3. (Opcional) Ingresar el alias de la app: `Taller Segundo Plano`.
4. Descargar el archivo `google-services.json` y colocarlo en `android/app/`.
5. Seguir las instrucciones de configuración de Gradle que Firebase indica.

---

## 3. Configurar App Distribution

### 3.1 Crear grupo de testers

1. En la consola de Firebase, ir al menú lateral → **App Distribution**.
2. Hacer clic en la pestaña **Testers & Groups**.
3. Hacer clic en **"Create Group"**.
4. Nombre del grupo: `QA_Clase`.
5. Agregar el correo del tester: `dduran@uceva.edu.co`.
6. Confirmar y guardar el grupo.

### 3.2 Subir el APK

1. Ir a la pestaña **Releases** en App Distribution.
2. Hacer clic en **"Upload"** y seleccionar el archivo:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```
3. En el campo **Release notes**, pegar las notas de la release (ver `docs/firebase/RELEASE_NOTES.md`).
4. En **Testers and groups**, seleccionar el grupo `QA_Clase`.
5. Hacer clic en **"Distribute"**.

### 3.3 Enlace de instalación

Después de distribuir, Firebase genera un enlace de instalación que puede compartirse directamente con los testers. Copiar ese enlace para incluirlo en la documentación de entrega.

---

## 4. Flujo completo de distribución

```
Código Flutter
    ↓
flutter build apk --release
    ↓
APK generado en build/app/outputs/flutter-apk/app-release.apk
    ↓
Firebase Console → App Distribution → Upload APK
    ↓
Asignar grupo QA_Clase + Release Notes
    ↓
Distribuir → Testers reciben correo de Firebase
    ↓
Tester instala Firebase App Tester (si aplica)
    ↓
App instalada en dispositivo físico Android
    ↓
Pruebas QA → Bitácora de incidencias
```

---

## 5. Actualización incremental (1.0.0 → 1.0.1)

Para distribuir una actualización:

1. Actualizar la versión en `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2
   ```
2. Generar el nuevo APK:
   ```bash
   flutter build apk --release
   ```
3. Repetir el proceso de subida en Firebase App Distribution.
4. Los testers recibirán una notificación automática con la nueva versión disponible.

---

## 6. Comandos útiles

```bash
# Generar APK de release
flutter build apk --release

# Verificar la versión actual
flutter --version

# Limpiar build anterior
flutter clean

# Obtener dependencias
flutter pub get
```

---

## Referencias

- [Firebase App Distribution - Documentación oficial](https://firebase.google.com/docs/app-distribution)
- [Versionado en Flutter / Android](https://flutter.dev/docs/deployment/android)
- [applicationId en Android](https://developer.android.com/studio/build/application-id)
