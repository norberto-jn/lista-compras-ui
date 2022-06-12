import 'package:flutter/material.dart';
import 'package:lista_tarefas_flutter_floor/itemmanager.dart';

import 'ItemModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lista de Compras'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  CardItem(ItemModel item) {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                  value: item.checked,
                  onChanged: (bool? isCheck) => {
                        setState(() {
                          ItemManager().update(item.id!, isCheck!);
                        })
                      }),
              Text(item.nome)
            ],
          ),
          IconButton(
            color: Colors.red,
            onPressed: () => {
              setState(() {
                ItemManager().delete(item.id!);
              })
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: ItemManager().findAll(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final item = snapshot.data[index];
                return CardItem(item);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _controller.text = "",
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Adicione o item'),
              content: TextField(
                controller: _controller,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => {
                    setState(() => {
                          ItemManager()
                              .create(ItemModel(_controller.text, false, null)),
                        }),
                    Navigator.pop(context, 'Cancel'),
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
