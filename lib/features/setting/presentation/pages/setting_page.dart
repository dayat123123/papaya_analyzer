import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/misc/global_variables.dart';
import 'package:papayas_analyzer/shared/widgets/container/item_widget_container.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AppThemeCubit themeCubit = getAppThemeCubit;

  @override
  void initState() {
    super.initState();
  }

  void _onTapBackToLandingPage() {
    context.showAlertDialog(
      title: "Perhatian!",
      content: "Apakah kamu yakin ingin kembali ke halaman awal?",
      onPressed: () {
        getRouter.go(RoutePath.landingPath);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengaturan")),
      body: Padding(
        padding: AppPadding.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AppThemeCubit, AppThemeModel>(
              bloc: themeCubit,
              builder: (context, state) {
                return ContainerWithSubItem(
                  title: "Tampilan",
                  listWidget: [
                    ItemWidgetContainer(
                      trailing: Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: 0.7,
                        child: Switch(
                          value: themeCubit.isDarkMode,
                          onChanged: (value) => themeCubit.switchTheme(),
                        ),
                      ),
                      title: themeCubit.isDarkMode ? "Mode Dark" : "Mode Light",
                      icon: Icon(
                        themeCubit.isDarkMode ? Icons.dark_mode : Icons.light,
                      ),
                    ),
                  ],
                );
              },
            ),
            ContainerWithSubItem(
              withTitle: false,
              listWidget: [
                ItemWidgetContainer(
                  icon: Icon(Icons.logout),
                  title: "Kembali ke halaman awal",
                  onTap: _onTapBackToLandingPage,
                ),
              ],
            ),
            ContainerWithSubItem(
              withTitle: false,
              listWidget: [
                ItemWidgetContainer(
                  title: "Aplikasi",
                  subtitle:
                      "${GlobalVariables.applicationName} ${GlobalVariables.applicationVersion}",
                  subtitleTextStyle: context.textStyle.subtitle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
