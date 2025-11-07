import 'package:flutter/material.dart';
import 'package:flutter_application_18/widget/lista.dart';

class Datos extends StatefulWidget {
  const Datos({super.key});
  @override
  State<StatefulWidget> createState() => _DatosState();
}

class Item {
  final String producto;
  final String descripcion;
  final String precio;
  Item(this.producto, this.descripcion, this.precio);
}

class _DatosState extends State<Datos> {
  final _llave = GlobalKey<FormState>();
  TextEditingController pro = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController pre = TextEditingController();

  List<Item> items = [];

  //  Validación: primera letra mayúscula y las demás minúsculas
  String? _validaMayuscula(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un texto';
    }
    final exp = RegExp(r'^[A-Z][a-z]*(\s[A-Z][a-z]*)*$');
    if (!exp.hasMatch(value)) {
      return 'Cada palabra debe iniciar con mayúscula y las demás en minúscula';
    }
    return null;
  }

  //  Validación: solo letras y espacios
  String? _validaLetrasEspacios(String? value) {
    if (value == null || value.isEmpty) {
      return 'Escribe un texto';
    }
    final exp = RegExp(r'^[a-zA-Z\s]+$');
    if (!exp.hasMatch(value)) {
      return 'Solo se permiten letras y espacios';
    }
    return null;
  }

  //  Validación: número decimal
  String? _validaDecimal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un número';
    }
    final exp = RegExp(r'^[0-9]+([.,][0-9]+)?$');
    if (!exp.hasMatch(value)) {
      return 'Ingresa un número válido (ejemplo: 12.5 o 3,14)';
    }
    return null;
  }

  //  Método corregido para que no agregue si hay errores
  void _agregar() {
    if (!_llave.currentState!.validate()) {
      // Si hay errores, muestra un aviso y no agrega
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Escribe correctamentre todo')));
      return; // Detiene la ejecución
    }

    // Si pasa la validación, agrega el producto
    setState(() {
      String p = pro.text;
      String d = des.text;
      String pr = pre.text;

      items.add(Item(p, d, pr));

      // Limpia los campos
      pro.clear();
      des.clear();
      pre.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado correctamente')),
      );
    });
  }

  void _enviar() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Lista(items: items)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATOS'),
        backgroundColor: const Color.fromARGB(255, 132, 125, 201),
        actions: [
          IconButton(onPressed: _enviar, icon: Icon(Icons.import_contacts)),
        ],
      ),
      body: Form(
        key: _llave,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      controller: pro,
                      decoration: InputDecoration(
                        labelText: 'Escribe el producto',
                        border: OutlineInputBorder(),
                      ),
                      validator: _validaMayuscula,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: des,
                      decoration: InputDecoration(
                        labelText: 'Describe el producto',
                        border: OutlineInputBorder(),
                      ),
                      validator: _validaLetrasEspacios,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: pre,
                      decoration: InputDecoration(
                        labelText: 'Precio del producto',
                        border: OutlineInputBorder(),
                      ),
                      validator: _validaDecimal,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _agregar,
                        icon: Icon(Icons.add),
                        label: Text('AGREGAR'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
