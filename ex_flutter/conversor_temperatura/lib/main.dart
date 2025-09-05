import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ConversorTemperaturaApp());
}

// Criar um MaterialColor personalizado para a cor desejada
const int _customPrimaryValue = 0xFF8CC7F7; // Cor: Color.fromARGB(255, 140, 199, 247)
const MaterialColor customPrimarySwatch = MaterialColor(
  _customPrimaryValue,
  <int, Color>{
    50: Color(0xFFE6F0FA), // Tons mais claros
    100: Color(0xFFD1E4F5),
    200: Color(0xFFB8D7F1),
    300: Color(0xFFA0CAEC),
    400: Color(0xFF91C0E9),
    500: Color(_customPrimaryValue), // Cor base
    600: Color(0xFF84BDF4),
    700: Color(0xFF79B6F1),
    800: Color(0xFF6FAFEE),
    900: Color(0xFF5DA2E9),
  },
);

class ConversorTemperaturaApp extends StatelessWidget {
  const ConversorTemperaturaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Temperatura',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch, 
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.blue[50],
      ),
      home: const ConversorTemperaturaScreen(),
    );
  }
}

class ConversorTemperaturaScreen extends StatefulWidget {
  const ConversorTemperaturaScreen({super.key});

  @override
  _ConversorTemperaturaScreenState createState() =>
      _ConversorTemperaturaScreenState();
}

class _ConversorTemperaturaScreenState extends State<ConversorTemperaturaScreen> {
  final TextEditingController _controller = TextEditingController();
  String _resultado = '';

  void _converterTemperatura() {
    String input = _controller.text;
    if (input.isNotEmpty) {
      try {
        double celsius = double.parse(input);
        double fahrenheit = (celsius * 9 / 5) + 32;
        setState(() {
          _resultado = '${celsius.toStringAsFixed(1)}°C = ${fahrenheit.toStringAsFixed(1)}°F';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Por favor, insira um número válido'),
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
          content: const Text('Insira uma temperatura'),
          backgroundColor: Colors.redAccent,
        ),
      );
      setState(() {
        _resultado = '';
      });
    }
  }

  void _limparCampo() {
    setState(() {
      _controller.clear();
      _resultado = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Temperatura'),
        backgroundColor: customPrimarySwatch[700], // Usar um tom mais escuro
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Converta Celsius para Fahrenheit',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customPrimarySwatch[900],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Temperatura em Celsius',
                labelStyle: TextStyle(color: customPrimarySwatch[700]),
                prefixIcon: Icon(Icons.thermostat, color: customPrimarySwatch[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
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
                  onPressed: _converterTemperatura,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Converter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customPrimarySwatch[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _limparCampo,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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