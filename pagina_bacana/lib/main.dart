import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double gridImageSize = 130;
  String titulo = "Hola, Flutter";

  void cambiarTitulo() {
    setState(() {
      titulo = titulo == "Hola, Flutter"
          ? "¡Título cambiado!"
          : "Hola, Flutter";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Título actualizado",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  final List<Map<String, String>> planetas = [
    {"nombre": "Mercurio", "img": "assets/mercurio.png"},
    {"nombre": "Marte", "img": "assets/marte.png"},
    {"nombre": "Júpiter", "img": "assets/jupiter.png"},
    {"nombre": "Saturno", "img": "assets/saturno.png"},
  ];

  final List<Map<String, dynamic>> elementos = [
    {"icon": Icons.star, "texto": "Elemento 1"},
    {"icon": Icons.star_border, "texto": "Elemento 2"},
    {"icon": Icons.star_half, "texto": "Elemento 3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(titulo), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Edward Steven Loaiza Díaz\n230231046 \nBienvenido a mi página bacana",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              _buildImageRow(),
              const SizedBox(height: 24),
              _buildChangeTitleButton(),
              const SizedBox(height: 24),
              _buildHorizontalListView(),
              const SizedBox(height: 24),
              _buildPlanetsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildImageContainer(
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg",
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          borderColor: const Color.fromARGB(132, 0, 0, 0),
        ),
        const SizedBox(width: 20),
        _buildImageContainer(
          child: Image.asset(
            "assets/planet.png",
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          borderColor: const Color.fromARGB(132, 0, 0, 0),
        ),
      ],
    );
  }

  Widget _buildImageContainer({
    required Widget child,
    required Color borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(12), child: child),
    );
  }

  Widget _buildChangeTitleButton() {
    return ElevatedButton(
      onPressed: cambiarTitulo,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Text("Cambiar título"),
    );
  }

  Widget _buildHorizontalListView() {
    return SizedBox(
      height: 100,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: elementos.length,
          itemBuilder: (context, index) {
            final item = elementos[index];
            return Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orangeAccent, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item["icon"], color: Colors.orangeAccent),
                  const SizedBox(height: 6),
                  Text(
                    item["texto"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlanetsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: planetas.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final planeta = planetas[index];
        return Center(
          child: Container(
            width: gridImageSize,
            height: gridImageSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(132, 0, 0, 0),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade900,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  planeta["img"]!,
                  width: gridImageSize,
                  height: gridImageSize,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.black54,
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    planeta["nombre"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
