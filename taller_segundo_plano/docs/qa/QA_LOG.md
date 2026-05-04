# 📝 Bitácora de QA — Taller Segundo Plano

**Proyecto:** Taller Segundo Plano — Flutter  
**Responsable QA:** Steven Daza  
**Canal de distribución:** Firebase App Distribution — Grupo `QA_Clase`  
**Tester externo:** dduran@uceva.edu.co  

---

## Registro v1.0.0 (Build 1)

| Campo       | Detalle                          |
|-------------|----------------------------------|
| Versión     | 1.0.0+1                          |
| Fecha       | 2026-05-03                       |
| APK         | app-release.apk                  |
| Distribuido | ✅ Sí — Grupo QA_Clase           |
| Dispositivo | Android físico (versión 12+)     |

### Cambios en esta versión

- Primer release de la aplicación Taller Segundo Plano.
- Funcionalidades: Future/async, Timer y Isolate.

### Pruebas realizadas

| ID  | Caso de prueba                              | Resultado | Observación                                 |
|-----|---------------------------------------------|-----------|---------------------------------------------|
| TC1 | Iniciar pantalla Async/Future               | ✅ PASS   | Carga en ~3s como se esperaba               |
| TC2 | Forzar error en Async/Future                | ✅ PASS   | Muestra mensaje de error correctamente      |
| TC3 | Tiempo de procesamiento visible             | ✅ PASS   | Mostrado en ms al completar                 |
| TC4 | Iniciar cronómetro en Timer                 | ✅ PASS   | Actualiza cada 100ms                        |
| TC5 | Pausar y reanudar cronómetro                | ✅ PASS   | Estado conservado correctamente             |
| TC6 | Reiniciar cronómetro a 00:00.0              | ✅ PASS   | Regresa a cero                              |
| TC7 | Ejecutar tarea en Isolate                   | ✅ PASS   | Resultado mostrado sin bloquear la UI       |
| TC8 | Tiempo de ejecución Isolate visible         | ✅ PASS   | Duración total mostrada en pantalla         |
| TC9 | Navegación entre pantallas fluida           | ✅ PASS   | Sin jank ni crashes                         |

### Incidencias encontradas

| ID  | Descripción                                         | Severidad | Estado    | Resolución                              |
|-----|-----------------------------------------------------|-----------|-----------|------------------------------------------|
| I01 | Permiso INTERNET no declarado en AndroidManifest    | Media     | ✅ Resuelta | Agregado en feat(android) commit        |

### Estado general de pruebas

✅ **APROBADO** — La versión 1.0.0 está lista para distribución al grupo QA_Clase.

---

## Registro v1.0.1 (Build 2)

| Campo       | Detalle                          |
|-------------|----------------------------------|
| Versión     | 1.0.1+2                          |
| Fecha       | 2026-05-03                       |
| APK         | app-release.apk                  |
| Distribuido | ✅ Sí — Grupo QA_Clase           |
| Dispositivo | Android físico (versión 12+)     |

### Cambios en esta versión

- Corrección: permiso `INTERNET` agregado al `AndroidManifest.xml`.
- Versión actualizada de `1.0.0+1` a `1.0.1+2`.
- Documentación de Firebase App Distribution integrada.
- Bitácora QA añadida al repositorio.

### Pruebas realizadas

| ID   | Caso de prueba                                  | Resultado | Observación                               |
|------|-------------------------------------------------|-----------|-------------------------------------------|
| TC10 | Regresión completa de TC1–TC9                   | ✅ PASS   | Todos los casos anteriores siguen OK      |
| TC11 | Permiso INTERNET presente en el manifiesto      | ✅ PASS   | Verificado con `aapt dump permissions`    |
| TC12 | Versión visible: 1.0.1 en About / pantalla app  | ✅ PASS   | versionName correcto                      |
| TC13 | Tester recibe notificación de actualización     | ✅ PASS   | Correo de Firebase App Distribution OK   |

### Incidencias encontradas

Ninguna incidencia nueva en esta versión.

### Estado general de pruebas

✅ **APROBADO** — La versión 1.0.1 pasa todos los casos de prueba. Lista para entrega final.

---

## Resumen de flujo QA

```
v1.0.0 subida a Firebase App Distribution
    → Tester dduran@uceva.edu.co recibe correo de invitación
    → Instala Firebase App Tester en dispositivo Android
    → Instala Taller Segundo Plano v1.0.0
    → Ejecuta pruebas TC1-TC9
    → Incidencia I01: falta permiso INTERNET → resuelta en feature branch
    ↓
v1.0.1 subida con corrección y bump de versión
    → Tester recibe notificación de nueva versión
    → Instala actualización automáticamente
    → Ejecuta regresión TC10-TC13
    → Sin nuevas incidencias
    → Aprobado para entrega
```
