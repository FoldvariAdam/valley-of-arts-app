import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';

import 'core/themes/app_theme_factory.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeFactory.create(),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.deepPurple,
            flexibleSpace: const FlexibleSpaceBar(title: Text('Festival')),
          ),

          // ---- FIX HEADER ----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Ajánlott események',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // ---- "EVENT CARD" LISTA ----
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.event, size: 32),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Esemény #$index',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: 10),
          ),

          // ---- GRID HEADER ----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Támogatók',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // ---- "SPONSOR LOGO" GRID ----
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'LOGO ${index + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              );
            }, childCount: 6),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.6,
            ),
          ),

          // ---- FOOTER BUTTON ----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Összes esemény'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
