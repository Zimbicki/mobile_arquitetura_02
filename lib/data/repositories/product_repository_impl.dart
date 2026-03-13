import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../../core/errors/failure.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;

  // Mecanismo de Cache Local Simples (Em memória)
  List<Product> _localCache = [];

  ProductRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final productModels = await remoteDatasource.getProducts();
      // Atualiza o cache local se o carregamento na API for um sucesso
      _localCache = productModels;
      return productModels;
    } catch (e) {
      // TRATAMENTO DE CACHE: Se não houver internet mas temos dados em cache, retorna os dados!
      if (_localCache.isNotEmpty) {
        return _localCache;
      }
      
      // Se não tiver cache guardado, lança o erro para a tela avisar o usuário
      if (e is Failure) {
        rethrow;
      }
      throw Failure('Erro desconhecido no repositório: $e');
    }
  }
}
