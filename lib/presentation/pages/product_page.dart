import 'package:flutter/material.dart';
import '../viewmodels/product_viewmodel.dart';
import '../viewmodels/product_state.dart';
import 'product_details_page.dart';

class ProductPage extends StatefulWidget {
  final ProductViewModel viewModel;

  const ProductPage({super.key, required this.viewModel});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos da Fake Store'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<ProductState>(
        valueListenable: widget.viewModel,
        builder: (context, state, child) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state.products.isEmpty) {
            return const Center(child: Text('Nenhum produto disponível.'));
          }

          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                ),
                title: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'U\$ ${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product: product),
                    ),
                  );
                },              );
            },
          );
        },
      ),
      // Adicionando um FAB para testarmos o re-carregamento!
      floatingActionButton: FloatingActionButton(
        onPressed: widget.viewModel.loadProducts,
        tooltip: 'Recarregar dados',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
