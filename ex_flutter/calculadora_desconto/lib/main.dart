import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CalculadoraDescontoApp());
}

const int _customPrimaryValue = 0xFF8B5E3C;
const MaterialColor customPrimarySwatch = MaterialColor(
  _customPrimaryValue,
  <int, Color>{
    50: Color(0xFFF5E8C7), 
    100: Color(0xFFE8D2A6),
    200: Color(0xFFDAB985),
    300: Color(0xFFCCA063),
    400: Color(0xFFB68A4A),
    500: Color(_customPrimaryValue),
    600: Color(0xFF805536),
    700: Color(0xFF744B30),
    800: Color(0xFF69412A),
    900: Color(0xFF533321),
  },
);

class CalculadoraDescontoApp extends StatelessWidget {
  const CalculadoraDescontoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Desconto',
      theme: ThemeData(
        primarySwatch: customPrimarySwatch,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF3E0), // Bege claro
      ),
      home: const CalculadoraDescontoScreen(),
    );
  }
}

class CalculadoraDescontoScreen extends StatefulWidget {
  const CalculadoraDescontoScreen({super.key});

  @override
  _CalculadoraDescontoScreenState createState() =>
      _CalculadoraDescontoScreenState();
}

class _CalculadoraDescontoScreenState extends State<CalculadoraDescontoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final TextEditingController _descontoController = TextEditingController();
  final List<Map<String, dynamic>> _produtos = [];

  void _calcularDesconto() {
    String precoInput = _precoController.text;
    String descontoInput = _descontoController.text;
    String nome = _nomeController.text.isEmpty ? 'Produto ${_produtos.length + 1}' : _nomeController.text;

    if (precoInput.isNotEmpty && descontoInput.isNotEmpty) {
      try {
        double preco = double.parse(precoInput);
        double desconto = double.parse(descontoInput);

        if (preco <= 0 || desconto < 0 || desconto > 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Preço deve ser positivo e desconto entre 0% e 100%'),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }

        double precoFinal = preco * (1 - desconto / 100);
        setState(() {
          _produtos.add({
            'nome': nome,
            'precoOriginal': preco,
            'desconto': desconto,
            'precoFinal': precoFinal,
          });
          _nomeController.clear();
          _precoController.clear();
          _descontoController.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Por favor, insira valores numéricos válidos'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Preencha preço e desconto'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _limparCampos() {
    setState(() {
      _nomeController.clear();
      _precoController.clear();
      _descontoController.clear();
      _produtos.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Desconto'),
        backgroundColor: customPrimarySwatch[700],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calcule o Desconto do Produto',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: customPrimarySwatch[900],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do Produto (opcional)',
                labelStyle: TextStyle(color: customPrimarySwatch[700]),
                prefixIcon: Icon(Icons.label, color: customPrimarySwatch[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _precoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Preço Original (R\$)',
                labelStyle: TextStyle(color: customPrimarySwatch[700]),
                prefixIcon: Icon(Icons.attach_money, color: customPrimarySwatch[700]),
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
            const SizedBox(height: 16),
            TextField(
              controller: _descontoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Desconto (%)',
                labelStyle: TextStyle(color: customPrimarySwatch[700]),
                prefixIcon: Icon(Icons.discount, color: customPrimarySwatch[700]),
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
                  onPressed: _calcularDesconto,
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
                  label: const Text('Limpar Tudo'),
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
            Expanded(
              child: _produtos.isEmpty
                  ? Center(
                      child: Text(
                        'Nenhum produto calculado',
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: customPrimarySwatch[900],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _produtos.length,
                      itemBuilder: (context, index) {
                        final produto = _produtos[index];
                        return Card(
                          color: Colors.white,
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              produto['nome'],
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: customPrimarySwatch[900],
                              ),
                            ),
                            subtitle: Text(
                              'Preço Original: R\$${produto['precoOriginal'].toStringAsFixed(2)}\n'
                              'Desconto: ${produto['desconto'].toStringAsFixed(1)}%\n'
                              'Preço Final: R\$${produto['precoFinal'].toStringAsFixed(2)}',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: customPrimarySwatch[800],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}