import 'package:flutter/material.dart';
import 'datos.dart';

class Lista extends StatefulWidget {
  final List<Item> items;
  const Lista({super.key, required this.items});
  @override
  State<StatefulWidget> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  //  Función para calcular la suma total de los precios
  void _mostrarTotal() {
    double total = 0.0;
    for (var item in widget.items) {
      total += double.tryParse(item.precio.replaceAll(',', '.')) ?? 0.0;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'El total de los productos es: \$${total.toStringAsFixed(2)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de productos'),
        backgroundColor: const Color.fromARGB(255, 117, 97, 178),
      ),
      body: items.isEmpty
          ? Center(
              child: Text('Lista Vacia', style: TextStyle(color: Colors.red)),
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    // ✅ Lista de productos
                    Expanded(
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
                    SizedBox(height: 10),
                    // Botón para sumar precios
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _mostrarTotal,
                        icon: Icon(Icons.calculate),
                        label: Text('Calcular total'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            234,
                            234,
                            236,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
