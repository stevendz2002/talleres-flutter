# 📋 Release Notes — Firebase App Distribution

## v1.0.1 (Build 2) — 2026-05-03

**Responsable:** Steven   
**Fecha de distribución:** 2026-05-03  
**Canal:** QA_Clase  

### Cambios incluidos

- ✅ Corrección del permiso `INTERNET` en `AndroidManifest.xml`
- ✅ Versión actualizada de `1.0.0+1` → `1.0.1+2`
- ✅ Documentación de flujo App Distribution integrada al README
- ✅ Bitácora QA añadida al repositorio (`docs/qa/QA_LOG.md`)

### Credenciales de prueba

> Esta aplicación no requiere autenticación. Es una app de demostración de técnicas asíncronas en Flutter.

### Instrucciones de instalación

1. Abrir el correo enviado por Firebase App Distribution desde `noreply@firebase.com`.
2. Hacer clic en **"Download the latest build"**.
3. Si es la primera vez: instalar la app **Firebase App Tester** cuando se solicite.
4. Aceptar los permisos y confirmar la instalación.
5. Abrir la app **Taller Segundo Plano** desde el launcher del dispositivo.

### Funcionalidades a probar en QA

- [ ] Pantalla `Async / Future`: pulsar **Iniciar** y verificar que carga 3s y muestra resultado.
- [ ] Pulsar **Forzar Error** y confirmar que aparece mensaje de error.
- [ ] Pantalla `Timer`: iniciar, pausar, reanudar y reiniciar el cronómetro.
- [ ] Pantalla `Isolate`: ejecutar la tarea pesada y verificar resultado correcto.

### Notas adicionales

- APK generado con: `flutter build apk --release`
- Firmado con keystore de debug (para entorno de QA)

---

## v1.0.0 (Build 1) — 2026-05-03

**Responsable:** Steven Daza  
**Fecha de distribución:** 2026-05-03  
**Canal:** QA_Clase  

### Cambios incluidos

- 🚀 Primera release de distribución vía Firebase App Distribution
- 📱 APK de release generado y subido
- 👥 Tester `dduran@uceva.edu.co` agregado al grupo `QA_Clase`

### Funcionalidades

- Demostración de `Future` / `async` / `await` con servicio simulado
- Cronómetro interactivo usando `Timer.periodic`
- Cálculo pesado ejecutado en `Isolate` separado del hilo principal

### Notas adicionales

- Primera distribución del proyecto
- APK generado con: `flutter build apk --release`
- Firmado con keystore de debug (para entorno de QA)
