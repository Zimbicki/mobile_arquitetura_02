import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../../core/errors/failure.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final http.Client client;

  ProductRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Failure('Erro ao carregar os produtos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw Failure('Erro de conexão ao buscar produtos: $e');
    }
  }
}
