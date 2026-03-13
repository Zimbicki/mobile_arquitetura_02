import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_cache_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../../core/errors/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  final ProductCacheDatasource cacheDatasource;

  ProductRepositoryImpl({
    required this.remoteDatasource,
    required this.cacheDatasource,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      final productModels = await remoteDatasource.getProducts();
      cacheDatasource.save(productModels);
      return productModels;
    } catch (e) {
      final cachedData = cacheDatasource.get();
      if (cachedData != null && cachedData.isNotEmpty) {
        return cachedData;
      }
      throw Failure("Não foi possível carregar os produtos");
    }
  }
}

