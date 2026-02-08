import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/home/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HomeHeader(
                  background: appTheme.backgroundColor,
                  onTicketTap: () {},
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Blokk belépő (fade + slide up)
              /*SSliverToBoxAdapter(
                child: PopularEventsCarousel(),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              SliverToBoxAdapter(
                child: FavoritesLink(),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Blokk belépő (fade + slide up)
              SliverToBoxAdapter(
                child: OngoingEvents(),
              ),*/

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ],
      ),
    );
  }
}

