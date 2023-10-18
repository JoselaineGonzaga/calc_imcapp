import 'package:calc_imcapp/models/imc.dart'; // Importe a classe IMC
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Hive e defina o diretório de armazenamento
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Registre o adapter da classe IMC
  Hive.registerAdapter(IMCAdapter() as TypeAdapter);

  // Abra a caixa do Hive para os dados do IMC
  await Hive.openBox<IMC>('imcBox');

  runApp(const MeuApp());
}

class IMCAdapter {}

class MeuApp extends StatelessWidget {
  const MeuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.green,
      ),
      home: const TelaIMC(),
    );
  }
}

class TelaIMC extends StatefulWidget {
  const TelaIMC({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
        title: const Text('Calculadora IMC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Informe os dados da pessoa:'),
            TextField(
              decoration: const InputDecoration(labelText: 'Nome'),
              onChanged: (value) {
                setState(() {
                  nome = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              onChanged: (value) {
                setState(() {
                  peso = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Altura (m)'),
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
                  _gravarIMC(nome, imc, resultado); // Grava no Hive
                });
              },
              child: const Text('Calcular IMC'),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<IMC>('imcBox').listenable(),
                builder: (context, Box<IMC> box, _) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final item = box.getAt(index);
                      return ListTile(
                        title: Text('Nome: ${item?.nome} - IMC: ${item?.imc}'),
                        subtitle: Text('Resultado: ${item?.resultado}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para gravar os dados do IMC no Hive
  _gravarIMC(String nome, double imc, String resultado) async {
    final imcBox = Hive.box<IMC>('imcBox');
    await imcBox.add(IMC(nome, imc, resultado));
  }

  calcularIMC(String nome, double peso, double altura) {}

  interpretarIMC(imc) {}
}
