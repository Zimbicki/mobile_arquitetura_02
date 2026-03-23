import 'package:flutter/material.dart';
import '../../presentation/viewmodels/product_viewmodel.dart';
import 'product_page.dart';

class HomePage extends StatelessWidget {
  final ProductViewModel viewModel;

  const HomePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store, size: 100, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              'Bem-vindo à Fake Store!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(viewModel: viewModel),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Ver Produtos', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
