import 'package:flutter/foundation.dart';
import '../../domain/repositories/product_repository.dart';
import '../../core/errors/failure.dart';
import 'product_state.dart';

class ProductViewModel extends ValueNotifier<ProductState> {
  final ProductRepository repository;

  ProductViewModel({required this.repository}) : super(ProductState());

  Future<void> loadProducts() async {
    value = value.copyWith(isLoading: true, error: null);

    try {
      final products = await repository.getProducts();
      value = value.copyWith(
        isLoading: false,
        products: products,
      );
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        error: e is Failure ? e.message : e.toString(),
      );
    }
  }
}
