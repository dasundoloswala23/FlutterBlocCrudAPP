// lib/screens/product_form.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloccurdapp/product.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'bloc/product_bloc.dart';





class ProductForm extends StatefulWidget {
  final Product? product;

  ProductForm({this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  final _uuid = Uuid();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.product?.name,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: widget.product?.price.toString(),
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final product = Product(
                      id: widget.product?.id ?? _uuid.v4(),
                      name: _name,
                      price: _price,
                    );
                    if (widget.product == null) {
                      BlocProvider.of<ProductBloc>(context).add(AddProduct(product));
                    } else {
                      BlocProvider.of<ProductBloc>(context).add(UpdateProduct(product));
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.product == null ? 'Add' : 'Update'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
