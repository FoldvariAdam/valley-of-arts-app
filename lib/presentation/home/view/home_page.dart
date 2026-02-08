import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/home/blocs/home_bloc.dart';
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

    return BlocProvider(
      lazy: false,
      create: (context) => GetIt.instance.get<HomeBloc>()..add(HomeGetPinnedEventsEvent()),
      child: Scaffold(
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
      ),
    );
  }
}

