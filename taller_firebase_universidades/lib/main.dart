import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taller_firebase_universidades/models/universidad.dart';
import 'package:taller_firebase_universidades/services/universidad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universidades Firebase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const UniversidadListScreen(),
    );
  }
}

class UniversidadListScreen extends StatelessWidget {
  const UniversidadListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades'),
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: UniversidadService().getUniversidades(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay universidades aún',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final universidades = snapshot.data!;

          return ListView.builder(
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final universidad = universidades[index];
              return ListTile(
                title: Text(universidad.nombre),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NIT: ${universidad.nit}'),
                    Text('Dirección: ${universidad.direccion}'),
                    Text('Teléfono: ${universidad.telefono}'),
                    Text('Web: ${universidad.paginaWeb}'),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUniversidadForm(context),
        tooltip: 'Agregar Universidad',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddUniversidadForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nitController = TextEditingController();
    final nombreController = TextEditingController();
    final direccionController = TextEditingController();
    final telefonoController = TextEditingController();
    final paginaWebController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Universidad'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nitController,
                  decoration: const InputDecoration(labelText: 'NIT'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el NIT';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: direccionController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la dirección';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el teléfono';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: paginaWebController,
                  decoration: const InputDecoration(labelText: 'Página Web'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la página web';
                    }
                    // Basic URL validation
                    if (!value.startsWith('http://') && !value.startsWith('https://')) {
                      return 'La URL debe comenzar con http:// o https://';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final universidad = Universidad(
                  nit: nitController.text.trim(),
                  nombre: nombreController.text.trim(),
                  direccion: direccionController.text.trim(),
                  telefono: telefonoController.text.trim(),
                  paginaWeb: paginaWebController.text.trim(),
                );

                UniversidadService().createUniversidad(universidad).then(
                  (_) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Universidad creada exitosamente')),
                    );
                  },
                  onError: (error) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al crear universidad: $error')),
                    );
                  },
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
