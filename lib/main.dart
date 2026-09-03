import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgendamentoEventoTela(),
    ),
  );
}

enum Visibilidade { publico, privado, convidados }

class AgendamentoEventoTela extends StatefulWidget {
  const AgendamentoEventoTela({super.key});

  @override
  State<AgendamentoEventoTela> createState() => _AgendamentoEventoTelaState();
}

class _AgendamentoEventoTelaState extends State<AgendamentoEventoTela> {
  static final DateTime _dataPadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao = TimeOfDay(hour: 19, minute: 0);
  static const String _tipoPadrao = 'Aniversario';
  static const double _convidadosPadrao = 50;
  static const Visibilidade _visibilidadePadrao = Visibilidade.privado;
  static const Map<String, bool> _servicosPadrao = {
    'Buffet': false,
    'Fotografo': false,
    'Decoracao': false,
    'DJ': false,
  };
  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  late String _tipoEventoSelecionado;
  late double _quantidadeConvidados;
  late Visibilidade _visibilidadeSelecionada;
  late Map<String, bool> _servicosSelecionados;

  @override
  void initState() {
    super.initState();
    _resetarValores();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _resetarValores() {
    setState(() {
      _dataSelecionada = _dataPadrao;
      _horarioSelecionado = _horarioPadrao;
      _tipoEventoSelecionado = _tipoPadrao;
      _quantidadeConvidados = _convidadosPadrao;
      _visibilidadeSelecionada = _visibilidadePadrao;
      _servicosSelecionados = Map<String, bool>.from(_servicosPadrao);
    });
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (data != null) {
      setState(() => _dataSelecionada = data);
    }
  }

  Future<void> _selecionarHorario() async {
    final horario = await showTimePicker(
      context: context,
      initialTime: _horarioSelecionado,
    );
    if (horario != null) {
      setState(() => _horarioSelecionado = horario);
    }
  }

  void _salvarFormulario() {
    debugPrint('Data: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}');
    debugPrint('Horario: ${_horarioSelecionado.format(context)}');
    debugPrint('Tipo de evento: $_tipoEventoSelecionado');
    debugPrint('Quantidade de convidados: ${_quantidadeConvidados.round()}');
    debugPrint('Visibilidade: $_visibilidadeSelecionada');
    debugPrint('Servicos adicionais: $_servicosSelecionados');
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Evento Social'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data e horario',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
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
                    onPressed: _selecionarHorario,
                    icon: const Icon(Icons.access_time),
                    label: Text(_horarioSelecionado.format(context)),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              'Tipo de evento',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tipoEventoSelecionado,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: ['Aniversario', 'Casamento', 'Corporativo', 'Outro']
                  .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
                  .toList(),
              onChanged: (novoValor) {
                if (novoValor != null) {
                  setState(() => _tipoEventoSelecionado = novoValor);
                }
              },
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantidade de convidados', style: Theme.of(context).textTheme.titleMedium),
                Text('${_quantidadeConvidados.round()} pessoas', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: _quantidadeConvidados,
              min: 10,
              max: 500,
              divisions: 49,
              label: _quantidadeConvidados.round().toString(),
              onChanged: (novoValor) => setState(() => _quantidadeConvidados = novoValor),
            ),
            const Divider(height: 32),
            Text('Visibilidade do evento', style: Theme.of(context).textTheme.titleMedium),
            RadioGroup<Visibilidade>(
              groupValue: _visibilidadeSelecionada,
              onChanged: (valor) {
                if (valor != null) {
                  setState(() => _visibilidadeSelecionada = valor);
                }
              },
              child: Column(
                children: const [
                  RadioListTile(value: Visibilidade.publico, title: Text('Publico')),
                  RadioListTile(value: Visibilidade.privado, title: Text('Privado')),
                  RadioListTile(value: Visibilidade.convidados, title: Text('Apenas convidados')),
                ],
              ),
            ),
            const Divider(height: 32),
            Text('Servicos adicionais', style: Theme.of(context).textTheme.titleMedium),
            ..._servicosSelecionados.keys.map(
              (servico) => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(servico),
                value: _servicosSelecionados[servico],
                onChanged: (marcado) => setState(() => _servicosSelecionados[servico] = marcado ?? false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
