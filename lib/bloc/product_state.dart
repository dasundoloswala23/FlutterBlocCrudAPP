part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}







class ProductLoadSuccess extends ProductState {
  final List<Product> products;

  ProductLoadSuccess(this.products);
}

class ProductOperationFailure extends ProductState {}
