import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/pages/product_page.dart';
import 'presentation/viewmodels/product_viewmodel.dart';

void main() {
  // Configuração da Injeção de Dependências (Responsabilidade de um DI / Service Locator)
  final httpClient = http.Client();
  final datasource = ProductRemoteDatasourceImpl(client: httpClient);
  final repository = ProductRepositoryImpl(remoteDatasource: datasource);
  final viewModel = ProductViewModel(repository: repository);

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  final ProductViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Passa o ViewModel instanciado para a página 
      home: ProductPage(viewModel: viewModel),
    );
  }
}
