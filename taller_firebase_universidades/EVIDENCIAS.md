# Evidencias del Taller 3: Integración con Firebase

## Descripción Técnica

### Arquitectura
El módulo sigue una arquitectura basada en capas:
- **Capa de Presentación**: `UniversidadListScreen` (UI con Flutter)
- **Capa de Servicio**: `UniversidadService` (interactúa con Firestore)
- **Capa de Modelo**: `Universidad` (entidad de datos)

### Estado
Se utiliza `StreamBuilder` para mantener la UI sincronizada en tiempo real con la colección `universidades` de Firestore. Los cambios en la base de datos se reflejan automáticamente en la aplicación.

### Validaciones
Se implementaron validaciones en el formulario de creación/edición:
1. Campos requeridos: nit, nombre, dirección, teléfono y página web
2. Validación de URL: La página web debe comenzar con `http://` o `https://`

## Funcionalidades Implementadas

✅ Conexión con Firebase (mediante `firebase_core` y `cloud_firestore`)
✅ Colección `universidades` en Firestore con los campos solicitados
✅ Operaciones CRUD completas:
   - Crear (formulario de ingreso)
   - Listar (stream en tiempo real)
   - Actualizar (botón de edición en cada elemento)
   - Eliminar (botón de eliminación con confirmación)
✅ Vista de evidencia con datos sincronizados en tiempo real
✅ Validación básica de campos (no vacíos y URL válida)

## Estructura de Datos en Firestore

Colección: `universidades`
Documento ejemplo:
```json
{
  "nit": "890.123.456-7",
  "nombre": "UCEVA",
  "direccion": "Cra 27A #48-144, Tuluá - Valle",
  "telefono": "+57 602 2242202",
  "pagina_web": "https://www.uceva.edu.co"
}
```

## Instrucciones para Ejecutar

1. Asegúrese de tener configurado Firebase en el proyecto (archivos `google-services.json` y `GoogleService-Info.plist`)
2. Ejecute `flutter pub get` para instalar dependencias
3. Ejecute `flutter run` para lanzar la aplicación

## Próximos Pasos para el Pull Request

1. La rama `feature/taller_firebase_universidades` contiene todo el desarrollo
2. Hacer pull request desde `feature/taller_firebase_universidades` → `dev`
3. Incluir este documento de evidencias en el repositorio