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

class _AgendamentoEventoTelaState extends State<AgendamentoEventoTela> {
  static final DateTime _dataPadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao = TimeOfDay(hour: 19, minute: 0);

  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;

  @override
  void initState() {
    super.initState();
    _resetarValores();
  }

  void _resetarValores() {
    _dataSelecionada = _dataPadrao;
    _horarioSelecionado = _horarioPadrao;
  }

  void _salvarFormulario() {
    debugPrint('=== RESUMO DO AGENDAMENTO ===');
    debugPrint('Data: ${_formatarData(_dataSelecionada)}');
    debugPrint('Horario: ${_horarioSelecionado.format(context)}');
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
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
