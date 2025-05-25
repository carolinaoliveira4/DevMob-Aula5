import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CronometroPage(),
    );
  }
}

class CronometroPage extends StatefulWidget {
  const CronometroPage({super.key});

  @override
  State<CronometroPage> createState() => _CronometroPageState();
}

class _CronometroPageState extends State<CronometroPage> {
  late Timer _timer;
  int _segundos = 0;
  int _tempoRegistrado = 0;
  bool _isRunning = false;

  String get tempoDecorrido => _formatarTempo(_segundos);
  String get tempoRegistrado => _formatarTempo(_tempoRegistrado);

  void _iniciar() {
    if (!_isRunning) {
      setState(() {
        _tempoRegistrado = _segundos;
        _isRunning = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _segundos++;
        });
      });
    }
  }

  void _parar() {
    if (_isRunning) {
      _timer.cancel();
    }
    setState(() {
      _isRunning = false;
      _segundos = 0;
      _tempoRegistrado = 0;
    });
  }

  String _formatarTempo(int segundos) {
    final minutos = segundos ~/ 60;
    final segundosRestantes = segundos % 60;
    final minutosStr = minutos.toString().padLeft(2, '0');
    final segundosStr = segundosRestantes.toString().padLeft(2, '0');
    return '$minutosStr:$segundosStr';
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronômetro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              'Tempo atual: $tempoDecorrido',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Tempo registrado: $tempoRegistrado',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _iniciar,
                  child: const Text('Iniciar'),
                ),
                ElevatedButton(
                  onPressed: _parar,
                  child: const Text('Parar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
