import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgendamentoEventoTela(),
    ),
  );
}

class AgendamentoEventoTela extends StatefulWidget {
  const AgendamentoEventoTela({super.key});

  @override
  State<AgendamentoEventoTela> createState() => _AgendamentoEventoTelaState();
}

enum Visibilidade { publico, privado, apenasConvidados }

class _AgendamentoEventoTelaState extends State<AgendamentoEventoTela> {
  static final DateTime _dataPadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao = TimeOfDay(hour: 19, minute: 0);
  static const String _tipoEventoPadrao = 'Aniversario';
  static const double _quantidadeConvidadosPadrao = 50;
  static const Visibilidade _visibilidadePadrao = Visibilidade.privado;
  static const Map<String, bool> _servicosPadrao = {
    'Buffet': false,
    'Fotografia': false,
    'Decoracao': false,
    'DJ': false,
  };
  static const List<String> _tagsPadrao = [
    'Vegetariano',
    'Sem Gluten',
    'Sem Lactose',
    'Vegano',
  ];

  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  late String _tipoEventoSelecionado;
  late double _quantidadeConvidados;
  late Visibilidade _visibilidadeSelecionada;
  late Map<String, bool> _servicosSelecionados;
  late List<String> _tagsSelecionadas;

  @override
  void initState() {
    super.initState();
    _resetarValores();
  }

  void _resetarValores() {
    _dataSelecionada = _dataPadrao;
    _horarioSelecionado = _horarioPadrao;
    _tipoEventoSelecionado = _tipoEventoPadrao;
    _quantidadeConvidados = _quantidadeConvidadosPadrao;
    _visibilidadeSelecionada = _visibilidadePadrao;
    _servicosSelecionados = Map<String, bool>.from(_servicosPadrao);
    _tagsSelecionadas = <String>[];
  }

  void _salvarFormulario() {
    debugPrint('=== RESUMO DO AGENDAMENTO ===');
    debugPrint('Data: ${_formatarData(_dataSelecionada)}');
    debugPrint('Horario: ${_horarioSelecionado.format(context)}');
    debugPrint('Tipo de evento: $_tipoEventoSelecionado');
    debugPrint('Quantidade de convidados: ${_quantidadeConvidados.round()}');
    debugPrint('Visibilidade: ${_visibilidadeSelecionada.name}');
    debugPrint('Servicos adicionais: $_servicosSelecionados');
    debugPrint('Restricoes alimentares: $_tagsSelecionadas');
  }

  Future<void> _selecionarData() async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (dataEscolhida != null) {
      setState(() {
        _dataSelecionada = dataEscolhida;
      });
    }
  }

  Future<void> _selecionarHora() async {
    final TimeOfDay? horaEscolhida = await showTimePicker(
      context: context,
      initialTime: _horarioSelecionado,
    );

    if (horaEscolhida != null) {
      setState(() {
        _horarioSelecionado = horaEscolhida;
      });
    }
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Evento Social'),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data e Horario',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _selecionarData,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_formatarData(_dataSelecionada)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _selecionarHora,
                    icon: const Icon(Icons.access_time),
                    label: Text(_horarioSelecionado.format(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Tipo de Evento',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tipoEventoSelecionado,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(
                  value: 'Aniversario',
                  child: Text('Aniversario'),
                ),
                DropdownMenuItem(value: 'Casamento', child: Text('Casamento')),
                DropdownMenuItem(
                  value: 'Corporativo',
                  child: Text('Corporativo'),
                ),
                DropdownMenuItem(value: 'Outro', child: Text('Outro')),
              ],
              onChanged: (String? novoValor) {
                if (novoValor != null) {
                  setState(() {
                    _tipoEventoSelecionado = novoValor;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantidade de Convidados',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${_quantidadeConvidados.round()} pessoas'),
              ],
            ),
            Slider(
              value: _quantidadeConvidados,
              min: 10,
              max: 500,
              divisions: 49,
              label: _quantidadeConvidados.round().toString(),
              onChanged: (double novoValor) {
                setState(() {
                  _quantidadeConvidados = novoValor;
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Visibilidade do Evento',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioGroup<Visibilidade>(
              groupValue: _visibilidadeSelecionada,
              onChanged: (Visibilidade? novaVisibilidade) {
                if (novaVisibilidade != null) {
                  setState(() {
                    _visibilidadeSelecionada = novaVisibilidade;
                  });
                }
              },
              child: const Column(
                children: [
                  RadioListTile<Visibilidade>(
                    title: Text('Publico'),
                    value: Visibilidade.publico,
                  ),
                  RadioListTile<Visibilidade>(
                    title: Text('Privado'),
                    value: Visibilidade.privado,
                  ),
                  RadioListTile<Visibilidade>(
                    title: Text('Apenas Convidados'),
                    value: Visibilidade.apenasConvidados,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Servicos Adicionais',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ..._servicosSelecionados.keys.map(
              (String servico) => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(servico),
                value: _servicosSelecionados[servico],
                controlAffinity: ListTileControlAffinity.trailing,
                onChanged: (bool? selecionado) {
                  setState(() {
                    _servicosSelecionados[servico] = selecionado ?? false;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Restricoes Alimentares (Tags)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tagsPadrao.map((String tag) {
                return FilterChip(
                  label: Text(tag),
                  selected: _tagsSelecionadas.contains(tag),
                  onSelected: (bool selecionada) {
                    setState(() {
                      if (selecionada) {
                        _tagsSelecionadas.add(tag);
                      } else {
                        _tagsSelecionadas.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
