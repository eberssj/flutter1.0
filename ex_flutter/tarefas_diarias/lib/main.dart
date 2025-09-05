import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TarefasDiariasApp());
}

class TarefasDiariasApp extends StatelessWidget {
  const TarefasDiariasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas Diárias 📋',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const TarefasDiariasPage(),
    );
  }
}

enum Prioridade { baixa, media, alta }

class Tarefa {
  String nome;
  String descricao;
  bool concluida;
  Prioridade prioridade;

  Tarefa(this.nome, this.descricao, {this.concluida = false, this.prioridade = Prioridade.baixa});
}

class TarefasDiariasPage extends StatefulWidget {
  const TarefasDiariasPage({super.key});

  @override
  State<TarefasDiariasPage> createState() => _TarefasDiariasPageState();
}

class _TarefasDiariasPageState extends State<TarefasDiariasPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final List<Tarefa> _tarefas = [];
  Prioridade _prioridadeSelecionada = Prioridade.baixa;

  // Adiciona uma nova tarefa à lista
  void _adicionarTarefa() {
    if (_nomeController.text.isNotEmpty && _descricaoController.text.isNotEmpty) {
      setState(() {
        _tarefas.add(Tarefa(
          _nomeController.text,
          _descricaoController.text,
          prioridade: _prioridadeSelecionada,
        ));
        _nomeController.clear();
        _descricaoController.clear();
        _prioridadeSelecionada = Prioridade.baixa;
      });
    }
  }

  // Alterna o estado do checkbox
  void _toggleConcluida(int index) {
    setState(() {
      _tarefas[index].concluida = !_tarefas[index].concluida;
    });
  }

  // Remove uma tarefa da lista
  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tarefas Diárias 📅',
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo para nome da tarefa
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da Tarefa ✨',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            // Campo para descrição
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição 📝',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            // Seleção de prioridade
            Text('Prioridade 🌟', style: GoogleFonts.roboto(fontSize: 16)),
            Row(
              children: [
                Radio<Prioridade>(
                  value: Prioridade.baixa,
                  groupValue: _prioridadeSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _prioridadeSelecionada = value!;
                    });
                  },
                ),
                const Text('Baixa 🟢'),
                Radio<Prioridade>(
                  value: Prioridade.media,
                  groupValue: _prioridadeSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _prioridadeSelecionada = value!;
                    });
                  },
                ),
                const Text('Média 🟡'),
                Radio<Prioridade>(
                  value: Prioridade.alta,
                  groupValue: _prioridadeSelecionada,
                  onChanged: (value) {
                    setState(() {
                      _prioridadeSelecionada = value!;
                    });
                  },
                ),
                const Text('Alta 🔴'),
              ],
            ),
            const SizedBox(height: 12),
            // Botão para adicionar tarefa
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: const Text('Adicionar Tarefa 🚀'),
            ),
            const SizedBox(height: 16),
            // Lista de tarefas
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _tarefas[index].concluida,
                      onChanged: (value) => _toggleConcluida(index),
                    ),
                    title: Text(
                      _tarefas[index].nome,
                      style: TextStyle(
                        decoration: _tarefas[index].concluida
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(_tarefas[index].descricao),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _tarefas[index].prioridade == Prioridade.baixa
                              ? '🟢 Baixa'
                              : _tarefas[index].prioridade == Prioridade.media
                                  ? '🟡 Média'
                                  : '🔴 Alta',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removerTarefa(index),
                        ),
                      ],
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