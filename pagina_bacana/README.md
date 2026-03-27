# Página Bacana - Taller Flutter (Tema Anime)

## Descripción del Taller

Esta aplicación Flutter demuestra el uso de widgets básicos, manejo de estado con `setState()`, y organización visual con layouts como Column, Padding y SizedBox. La aplicación incluye una pantalla principal con título dinámico en la AppBar, texto centrado con el nombre del estudiante, imágenes (network y asset), un botón que alterna el título y muestra un SnackBar, y varios widgets adicionales como Container, ListView y GridView. Todo ambientado en un tema anime con colores rosas y azules, y elementos relacionados con anime.

## Pasos para Ejecutar

1. Asegúrate de tener Flutter instalado en tu sistema.
2. Clona o descarga este proyecto.
3. Navega al directorio del proyecto: `cd pagina_bacana`
4. Ejecuta `flutter pub get` para instalar las dependencias.
5. Asegúrate de que el archivo `assets/flutter-logo.png` esté presente (agrega una imagen de logo de Flutter o anime).
6. Ejecuta `flutter run` para iniciar la aplicación en un emulador o dispositivo conectado.

## Evidencias

### Código con setState()
El código utiliza `setState()` en el método `_toggleTitle()` para actualizar el título de la AppBar y mostrar un SnackBar.

### Capturas de Pantalla

1. **Estado inicial de la app**: Muestra "¡Hola, Otaku!" en la AppBar, el nombre del estudiante Sakura Haruno, las imágenes y los widgets adicionales con tema anime.
2. **Estado tras presionar el botón**: Título cambiado a "¡Título Cambiado a Anime!" y SnackBar visible con "¡Tema actualizado!".
3. **Funcionamiento de los widgets adicionales**:
   - Container: Con bordes rosas y fondo rosa claro, estilo anime.
   - ListView: Lista de elementos relacionados con anime (Personaje Favorito, Anime Preferido, etc.).
   - GridView: Cuadrícula con géneros de anime (Shonen, Shoujo, Mecha, Slice of Life).

## Datos del Estudiante

- **Nombre completo**: Sakura Haruno
- **Código**: 123456789
