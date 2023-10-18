// tela_configuracoes.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TelaConfiguracoesState createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  TextEditingController alturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Informe sua altura:'),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Altura (m)'),
            ),
            ElevatedButton(
              onPressed: () {
                _salvarAltura();
              },
              child: const Text('Salvar Altura'),
            ),
          ],
        ),
      ),
    );
  }

  _salvarAltura() async {
    final altura = double.parse(alturaController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('altura', altura);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
