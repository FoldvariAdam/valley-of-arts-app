import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:valley_of_arts/core/core.dart';
import 'package:valley_of_arts/generated/locale_keys.g.dart';
import 'package:valley_of_arts/presentation/settings/widgets/widgets.dart';
import 'package:valley_of_arts/shared/shared.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'hu';

  bool positionEnabled = true;
  bool notificationsEnabled = true;
  bool snailBusTracking = false;

  double snailBusRefreshMin = 5;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: EdgeInsets.all(appTheme.s2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  title: LocaleKeys.Settings_Title.tr(),
                  subtitle: LocaleKeys.Settings_SubTitle.tr(),
                ),

                Entrance(
                  fromY: 20,
                  delayMs: 0,
                  child: SectionTitle(
                    icon: Icons.language,
                    title: LocaleKeys.Settings_Language_Title.tr(),
                  ),
                ),

                SizedBox(height: appTheme.s1),

                Entrance(
                  fromY: 20,
                  delayMs: 0,
                  child: _Card(
                    child: SingleSelectList<String>(
                      items: ['hu', 'en'],
                      selected: selectedLanguage,
                      onSelected: (val) =>
                          setState(() => selectedLanguage = val),
                      itemBuilder: (val, isSelected) {
                        switch (val) {
                          case 'hu':
                            return SelectableRow(
                              leading: Text(
                                '🇭🇺',
                                style: appTheme.mediumHeadLine,
                              ),
                              title: LocaleKeys.Settings_Language_Hu.tr(),
                              isSelected: isSelected,
                            );
                          case 'en':
                            return SelectableRow(
                              leading: Text(
                                '🇬🇧',
                                style: appTheme.mediumHeadLine,
                              ),
                              title: LocaleKeys.Settings_Language_En.tr(),
                              isSelected: isSelected,
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),

                SizedBox(height: appTheme.s4),

                Entrance(
                  fromY: 20,
                  delayMs: 200,
                  child: SectionTitle(
                    icon: Icons.place,
                    title: LocaleKeys.Settings_General_Title.tr(),
                  ),
                ),

                SizedBox(height: appTheme.s2),

                Entrance(
                  fromY: 20,
                  delayMs: 200,
                  child: _Card(
                    child: Column(
                      children: [
                        LabeledSwitch(
                          title:
                              LocaleKeys.Settings_General_Position_Title.tr(),
                          subtitle: LocaleKeys
                              .Settings_General_Position_Subtitle.tr(),
                          value: positionEnabled,
                          onChanged: (v) => setState(() => positionEnabled = v),
                        ),
                        const AppDivider(),
                        LabeledSwitch(
                          title: LocaleKeys
                              .Settings_General_Notifications_Title.tr(),
                          subtitle: LocaleKeys
                              .Settings_General_Notifications_Subtitle.tr(),
                          value: notificationsEnabled,
                          onChanged: (v) =>
                              setState(() => notificationsEnabled = v),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: appTheme.s4),

                Entrance(
                  fromY: 20,
                  delayMs: 400,
                  child: SectionTitle(
                    icon: Icons.directions_bus,
                    title: LocaleKeys.Settings_SnailBus_Title.tr(),
                  ),
                ),

                SizedBox(height: appTheme.s2),

                Entrance(
                  fromY: 20,
                  delayMs: 400,
                  child: _Card(
                    child: Column(
                      children: [
                        LabeledSwitch(
                          title:
                              LocaleKeys.Settings_SnailBus_Tracking_Title.tr(),
                          subtitle: LocaleKeys
                              .Settings_SnailBus_Tracking_SubTitle.tr(),
                          value: snailBusTracking,
                          onChanged: (v) =>
                              setState(() => snailBusTracking = v),
                        ),

                        const AppDivider(),

                        Padding(
                          padding: EdgeInsets.all(appTheme.s2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          LocaleKeys
                                              .Settings_SnailBus_Refresh_Title.tr(),
                                          style: appTheme.bodyText,
                                        ),

                                        SizedBox(height: appTheme.s0),

                                        Text(
                                          LocaleKeys
                                              .Settings_SnailBus_Refresh_SubTitle.tr(),
                                          style: appTheme.descriptionText,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${snailBusRefreshMin.round()} ${LocaleKeys.Settings_SnailBus_Minute.tr()}',
                                      style: appTheme.bodyText,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: appTheme.s1),

                              Slider(
                                value: snailBusRefreshMin,
                                min: 1,
                                max: 60,
                                divisions: 59,
                                onChanged: (v) =>
                                    setState(() => snailBusRefreshMin = v),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '1 ${LocaleKeys.Settings_SnailBus_Minute.tr()}',
                                    style: appTheme.bodyText,
                                  ),
                                  Text(
                                    '60 ${LocaleKeys.Settings_SnailBus_Minute.tr()}',
                                    style: appTheme.bodyText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: appTheme.s4),

                Entrance(
                  fromY: 20,
                  delayMs: 600,
                  child: SectionTitle(
                    icon: Icons.info_outline,
                    title: LocaleKeys.Settings_Information_Title.tr(),
                  ),
                ),

                SizedBox(height: appTheme.s2),

                Entrance(
                  fromY: 20,
                  delayMs: 600,
                  child: _Card(
                    child: Column(
                      children: [
                        ChevronRow(
                          title: LocaleKeys.Settings_Information_Rules.tr(),
                          onTap: () {},
                        ),
                        const AppDivider(),
                        ChevronRow(
                          title: LocaleKeys.Settings_Information_FAQ.tr(),
                          onTap: () {},
                        ),
                        const AppDivider(),
                        ChevronRow(
                          title: LocaleKeys.Settings_Information_Contact.tr(),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: Text(
                    'Művészetek Völgye App v1.0.0',
                    style: appTheme.bodyText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Container(
      decoration: BoxDecoration(
        color: appTheme.cardBackgroundColor,
        borderRadius: appTheme.r2xl,
        border: Border.all(color: appTheme.borderColor, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
