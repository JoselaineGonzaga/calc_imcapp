import 'package:flutter/material.dart';
import 'package:calc_imcapp/models/imc.dart';
import 'package:calc_imcapp/services/imc_calculator.dart';
import 'package:calc_imcapp/utils/imc_interpreter.dart';

class TelaIMC extends StatefulWidget {
  const TelaIMC({Key? key}) : super(key: key);

  @override
  _TelaIMCState createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  List<IMC> imcList = [];
  String nome = "";
  double peso = 0.0;
  double altura = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Informe os dados da pessoa:'),
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              onChanged: (value) {
                setState(() {
                  peso = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Altura (m)'),
              onChanged: (value) {
                setState(() {
                  altura = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                final imc = calcularIMC(nome, peso, altura);
                final resultado = interpretarIMC(imc);

                setState(() {
                  imcList.add(IMC(nome, imc, resultado));
                });
              },
              child: Text('Calcular IMC'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: imcList.length,
                itemBuilder: (context, index) {
                  final item = imcList[index];
                  return ListTile(
                    title: Text('Nome: ${item.nome} - IMC: ${item.imc}'),
                    subtitle: Text('Resultado: ${item.resultado}'),
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
