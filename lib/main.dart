import 'package:flutter/material.dart';
import 'package:calc_imcapp/models/pessoa.dart';
import 'package:calc_imcapp/services/imc_calculator.dart';
import 'package:calc_imcapp/utils/imc_interpreter.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key})
      : super(key: key); // Adicionei o parâmetro nomeado 'key'.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      home: TelaIMC(key: UniqueKey()), // Adicionei um 'key' único.
    );
  }
}

class TelaIMC extends StatefulWidget {
  const TelaIMC({Key? key})
      : super(key: key); // Adicionei o parâmetro nomeado 'key'.

  @override
  _TelaIMCState createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  String nome = "";
  double peso = 0.0;
  double altura = 0.0;
  double imc = 0.0;
  String resultado = "";

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
                Pessoa pessoa = Pessoa(nome, peso, altura);
                imc = calcularIMC(pessoa);
                resultado = interpretarIMC(imc);

                // Atualize a interface com o resultado
                setState(() {});
              },
              child: Text('Calcular IMC'),
            ),
            Text('IMC de $nome: $imc'),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}
