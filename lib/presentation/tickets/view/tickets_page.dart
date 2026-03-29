import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/presentation/shared/components/components.dart';
import 'package:valley_of_arts/presentation/tickets/tickets.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  String activeTab = 'festival';

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Padding(
      padding: EdgeInsets.all(appTheme.s1),
      child: Column(
        children: [
          const PageHeader(title: 'Jegyvásárlás', showBackButton: true),

          SizedBox(height: appTheme.s1),

          Container(
            margin: EdgeInsets.symmetric(horizontal: appTheme.s3),
            decoration: BoxDecoration(
              color: appTheme.componentBackgroundColor,
              borderRadius: appTheme.r2xl,
            ),
            child: Row(
              children: [
                _buildTab(
                  key: 'festival',
                  label: 'Fesztivál jegyek',
                  icon: Icons.confirmation_num,
                  appTheme: appTheme,
                ),
                _buildTab(
                  key: 'camping',
                  label: 'Kemping',
                  icon: Icons.location_city_sharp,
                  appTheme: appTheme,
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocProvider(
              create: (context) =>
                  GetIt.instance.get<TicketsBloc>()
                    ..add(const TicketsFetchEvent()),
              child: BlocBuilder<TicketsBloc, TicketsState>(
                builder: (context, state) {
                  if (state is TicketsLoadedState) {
                    final festivalTickets = state.festivalTickets;
                    final campingTickets = state.campingTickets;

                    final tickets = activeTab == 'festival'
                        ? festivalTickets
                        : campingTickets;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: ListView.builder(
                        key: ValueKey(activeTab),
                        padding: const EdgeInsets.all(16),
                        itemCount: tickets.length,
                        itemBuilder: (context, index) =>
                            TicketCard(ticket: tickets[index]),
                      ),
                    );
                  }

                  return const AppCircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String key,
    required String label,
    required IconData icon,
    required AppTheme appTheme,
  }) {
    final bool isActive = activeTab == key;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activeTab = key),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: appTheme.s1),
          decoration: BoxDecoration(
            color: isActive ? appTheme.selectedColor : Colors.transparent,
            borderRadius: appTheme.r2xl,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: appTheme.foregroundColor,
              ),

              SizedBox(width: appTheme.s0),

              Text(
                label,
                style: appTheme.bodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
