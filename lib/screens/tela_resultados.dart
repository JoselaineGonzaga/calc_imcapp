// tela_resultados.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:calc_imcapp/models/imc.dart';

class TelaResultados extends StatelessWidget {
  const TelaResultados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados IMC'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Hive.openBox<IMC>('imcBox'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final imcBox = Hive.box<IMC>('imcBox');
                  final imcList = imcBox.values.toList();

                  return ListView.builder(
                    itemCount: imcList.length,
                    itemBuilder: (context, index) {
                      final item = imcList[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text('Nome: ${item.nome}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('IMC: ${item.imc.toStringAsFixed(2)}'),
                              Text('Resultado: ${item.resultado}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Hive.box<IMC>('imcBox').clear();
            },
            child: const Text('Limpar Dados'),
          ),
        ],
      ),
    );
  }
}
