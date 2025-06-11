import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/misc/file_paths.dart';
import 'package:papayas_analyzer/shared/misc/global_variables.dart';
import 'package:papayas_analyzer/shared/widgets/card/card_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  final GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void _onTapMenu() {
    scafoldKey.currentState?.openDrawer();
  }

  void _onTapInfo() {
    scafoldKey.currentState?.closeDrawer();
    context.push(RoutePath.infoPath);
  }

  void _onTapHistory() {
    scafoldKey.currentState?.closeDrawer();
    context.push(RoutePath.historyPath);
  }

  void _onTapDetail() {
    context.push(RoutePath.detailsPath);
  }

  void _onTapDetect() {
    context.push(RoutePath.imagePickerPath);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = getAppThemeCubit.isDarkMode;
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: scafoldKey,
        drawer: Drawer(
          child: Padding(
            padding: AppPadding.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                BlocBuilder<AppThemeCubit, AppThemeModel>(
                  bloc: getAppThemeCubit,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getAppThemeCubit.isDarkMode
                              ? "Dark Mode"
                              : "Light Mode",
                        ),

                        Switch(
                          value: getAppThemeCubit.isDarkMode,
                          onChanged: (value) {
                            getAppThemeCubit.switchTheme();
                          },
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30),
                GestureDetector(onTap: _onTapInfo, child: Text("Info")),
                SizedBox(height: 30),
                GestureDetector(onTap: _onTapHistory, child: Text("History")),
              ],
            ),
          ),
        ),
        body: Scrollbar(
          controller: _scrollController,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: context.fullHeight * 0.25,
                    width: context.fullWidth,
                    decoration: BoxDecoration(
                      color: context.themeColors.appContainerBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      GlobalVariables.applicationName,
                      style: context.textStyle.appbarTitle,
                    ),
                  ),
                  Padding(
                    padding: AppPadding.horizontal.copyWith(
                      top: kToolbarHeight,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _onTapMenu,
                          child: Icon(Icons.menu),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              CardContainer(
                color: isDark ? null : context.themeColors.whiteColor,
                width: 250,
                height: 50,
                onTap: _onTapDetail,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info),
                    SizedBox(width: 15),
                    Text("Detail"),
                  ],
                ),
              ),
              SizedBox(height: 30),
              CardContainer(
                color: isDark ? null : context.themeColors.whiteColor,
                width: 250,
                height: 50,
                onTap: _onTapDetect,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_scanner_outlined),
                    SizedBox(width: 15),
                    Text("Detect"),
                  ],
                ),
              ),
              Spacer(),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Image.asset(
                  FilePaths.splashPng,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
