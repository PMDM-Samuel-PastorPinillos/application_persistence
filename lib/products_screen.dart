import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Product {
  int? id;
  String name;
  int stock;
  double price;

  Product({this.id, required this.name, required this.stock, required this.price});
}

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Future<Database> _getDatabase() async {
    final path = join(await getDatabasesPath(), 'products.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, stock INTEGER, price REAL)',
      );
    });
  }

  Future<void> _insertProduct() async {
    final database = await _getDatabase();
    await database.insert('products', {
      'name': _nameController.text,
      'stock': int.parse(_stockController.text),
      'price': double.parse(_priceController.text),
    });
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final database = await _getDatabase();
    final products = await database.query('products');
    setState(() {
      _products = products.map((e) => Product(
        id: e['id'] as int,
        name: e['name'] as String,
        stock: e['stock'] as int,
        price: e['price'] as double,
      )).toList();
    });
  }


  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nombre')),
            TextField(controller: _stockController, decoration: InputDecoration(labelText: 'Stock')),
            TextField(controller: _priceController, decoration: InputDecoration(labelText: 'Precio')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _insertProduct,
              child: Text('Agregar Producto'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_products[index].name),
                    subtitle: Text('Stock: ${_products[index].stock}, Precio: ${_products[index].price}'),
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