import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/home/blocs/home_bloc.dart';
import 'package:valley_of_arts/presentation/home/widgets/widgets.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetIt.instance.get<HomeBloc>()..add(const HomeStarted()),
      child: const _HomePageInner(),
    );
  }
}

class _HomePageInner extends StatefulWidget {
  const _HomePageInner();

  @override
  State<_HomePageInner> createState() => _HomePageInnerState();
}

class _HomePageInnerState extends State<_HomePageInner> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      if (offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        context.read<HomeBloc>().add(
          const HomeLoadMoreCurrentProgramsRequested(),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: HomeHeader(
                background: appTheme.backgroundColor,
                onTicketTap: () {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: appTheme.s2)),

            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (prev, curr) =>
                  prev.popularPrograms != curr.popularPrograms ||
                  prev.loadingPopular != curr.loadingPopular,
              builder: (context, state) {
                final popularPrograms = state.popularPrograms;
                if (state.loadingPopular) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 250,
                      child: AppCircularProgressIndicator(),
                    ),
                  );
                }

                if (popularPrograms != null && popularPrograms.isNotEmpty) {
                  return SliverToBoxAdapter(
                    child: PopularEventsCarousel(programs: popularPrograms),
                  );
                }

                return SliverToBoxAdapter(child: Container());
              },
            ),

            SliverToBoxAdapter(child: SizedBox(height: appTheme.s5)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appTheme.s2),
                child: Column(
                  children: [
                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (prev, curr) =>
                      prev.favoritesLength != curr.favoritesLength ||
                          prev.loadingFavorites != curr.loadingFavorites,
                      builder: (context, state) {
                        return const FavoritesCard();
                      },
                    ),

                    SizedBox(height: appTheme.s5),

                    BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (prev, curr) =>
                      prev.currentPrograms != curr.currentPrograms ||
                          prev.loadingCurrent != curr.loadingCurrent,
                      builder: (context, state) {
                        return UpcomingPrograms(
                          programs: state.currentPrograms ?? [],
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

        Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          left: 0,
          right: 0,
          child: Center(
            child: ScrollToTopButton(
              visible: _showScrollToTop,
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutCubic,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
