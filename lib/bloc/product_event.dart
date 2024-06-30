part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}
class AddProduct extends ProductEvent {
  final Product product;

  AddProduct(this.product);
}

class UpdateProduct extends ProductEvent {
  final Product product;

  UpdateProduct(this.product);
}

class DeleteProduct extends ProductEvent {
  final String id;

  DeleteProduct(this.id);
}

class LoadProducts extends ProductEvent {}
