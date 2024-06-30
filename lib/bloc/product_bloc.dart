import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../product.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> _products = [];
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      emit(ProductLoadSuccess(List.from(_products)));
    });
    on<AddProduct>((event, emit) {
      _products.add(event.product);
      emit(ProductLoadSuccess(List.from(_products)));
    });
    on<UpdateProduct>((event, emit) {
      final index = _products.indexWhere((p) => p.id == event.product.id);
      if (index != -1) {
        _products[index] = event.product;
        emit(ProductLoadSuccess(List.from(_products)));
      }
    });

    on<DeleteProduct>((event, emit) {
      _products.removeWhere((p) => p.id == event.id);
      emit(ProductLoadSuccess(List.from(_products)));
    });
  }


}
