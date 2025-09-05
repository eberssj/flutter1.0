import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CalculadoraAreaApp());
}

// Criar um MaterialColor personalizado para o azul (#1976D2)
const int _customPrimaryValue = 0xFF1976D2;
const MaterialColor customPrimarySwatch = MaterialColor(
  _customPrimaryValue,
  <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(_customPrimaryValue),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  },
);

class CalculadoraAreaApp extends StatelessWidget {
  const CalculadoraAreaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Área de Retângulo',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.white, // Fundo branco
      ),
      home: const CalculadoraAreaScreen(),
    );
  }
}

class CalculadoraAreaScreen extends StatefulWidget {
  const CalculadoraAreaScreen({super.key});

  @override
  _CalculadoraAreaScreenState createState() => _CalculadoraAreaScreenState();
}

class _CalculadoraAreaScreenState extends State<CalculadoraAreaScreen> {
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = '';

  void _calcularArea() {
    String larguraInput = _larguraController.text;
    String alturaInput = _alturaController.text;

    if (larguraInput.isNotEmpty && alturaInput.isNotEmpty) {
      try {
        double largura = double.parse(larguraInput);
        double altura = double.parse(alturaInput);

        if (largura <= 0 || altura <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Largura e altura devem ser maiores que zero'),
              backgroundColor: Colors.redAccent,
            ),
          );
          setState(() {
            _resultado = '';
          });
          return;
        }

        double area = largura * altura;
        setState(() {
          _resultado = 'Área: ${area.toStringAsFixed(2)} m²';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Por favor, insira valores numéricos válidos'),
            backgroundColor: Colors.redAccent,
          ),
        );
        setState(() {
          _resultado = '';
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Preencha largura e altura'),
          backgroundColor: Colors.redAccent,
        ),
      );
      setState(() {
        _resultado = '';
      });
    }
  }

  void _limparCampos() {
    setState(() {
      _larguraController.clear();
      _alturaController.clear();
      _resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Área de Retângulo'),
        backgroundColor: customPrimarySwatch[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calcule a Área do Retângulo',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customPrimarySwatch[900],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _larguraController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Largura (m)',
                labelStyle: TextStyle(color: customPrimarySwatch[700]),
                prefixIcon: Icon(Icons.straighten, color: customPrimarySwatch[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: customPrimarySwatch[700]!, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                labelStyle: TextStyle(color: customPrimarySwatch[700]),
                prefixIcon: Icon(Icons.height, color: customPrimarySwatch[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: customPrimarySwatch[700]!, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _calcularArea,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customPrimarySwatch[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _limparCampos,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _resultado,
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: customPrimarySwatch[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}