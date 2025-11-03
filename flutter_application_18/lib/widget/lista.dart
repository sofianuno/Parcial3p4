import 'package:flutter/material.dart';
import 'datos.dart';

class Lista extends StatefulWidget {
  final List<Item> items;
  const Lista({super.key, required this.items});
  @override
  State<StatefulWidget> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de productos'),
        backgroundColor: const Color.fromARGB(255, 169, 63, 130),
      ),
      body: items.isEmpty
          ? Center(
              child: Text('Lista Vacia', style: TextStyle(color: Colors.red)),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(Icons.production_quantity_limits),
                        title: Text(item.producto),
                        subtitle: Column(
                          children: [
                            Text(item.descripcion),
                            Text('Precio: ${item.precio}'),
                          ],
                        ),
                        trailing: IconButton(
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              //print('Eliminar $index');
                              items.removeAt(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
