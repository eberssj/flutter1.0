import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ListaDeComprasApp());
}

class ListaDeComprasApp extends StatelessWidget {
  const ListaDeComprasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras 🛒',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const ListaDeComprasPage(),
    );
  }
}

class ItemCompra {
  String nome;
  bool comprado;

  ItemCompra(this.nome, {this.comprado = false});
}

class ListaDeComprasPage extends StatefulWidget {
  const ListaDeComprasPage({super.key});

  @override
  State<ListaDeComprasPage> createState() => _ListaDeComprasPageState();
}

class _ListaDeComprasPageState extends State<ListaDeComprasPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ItemCompra> _itens = [];

  // Adiciona um novo item à lista
  void _adicionarItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _itens.add(ItemCompra(_controller.text));
        _controller.clear();
      });
    }
  }

  // Alterna o estado do checkbox
  void _toggleComprado(int index) {
    setState(() {
      _itens[index].comprado = !_itens[index].comprado;
    });
  }

  // Remove um item da lista
  void _removerItem(int index) {
    setState(() {
      _itens.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Compras 🛍️',
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo para adicionar itens
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Adicionar item 🌟',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _adicionarItem(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _adicionarItem,
                  child: const Text('Add 🛒'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Lista de itens
            Expanded(
              child: ListView.builder(
                itemCount: _itens.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _itens[index].comprado,
                      onChanged: (value) => _toggleComprado(index),
                    ),
                    title: Text(
                      _itens[index].nome,
                      style: TextStyle(
                        decoration: _itens[index].comprado
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removerItem(index),
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