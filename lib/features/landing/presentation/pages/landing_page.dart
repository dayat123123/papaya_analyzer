import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papayas_analyzer/core/router/route_path.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/features/landing/presentation/widgets/carousel_widget_list.dart';
import 'package:papayas_analyzer/injector.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/misc/global_variables.dart';
import 'package:papayas_analyzer/shared/widgets/card/card_container.dart';
import 'package:papayas_analyzer/shared/widgets/caruosel/custom_carousel.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AppThemeCubit _appThemeCubit = getAppThemeCubit;
  final List<Widget> _listScreen = CarouselWidgetList.listWidget;

  @override
  void initState() {
    super.initState();
  }

  void _onTapGetStarted() {
    getRouter.go(RoutePath.homePath);
  }

  void _onSwitchMode() {
    _appThemeCubit.switchTheme();
    context.showToast(
      context: context,
      status: ToastStatus.success,
      position: ToastPosition.top,
      title: "Perubahan berhasil!",
      subtitle: "Tema kamu sudah berubah",
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomCarousel(
            animateView: true,
            durationAnimateinseconds: 10,
            listwidget: _listScreen,
            positionedIndicatorTop: 75,
            positionedIndicatorRight: 30,
          ),
          Positioned(top: 65, left: 30, child: _switchThemeButton()),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Padding(
                    padding: AppPadding.horizontal,
                    child: Text(
                      GlobalVariables.applicationName,
                      textAlign: TextAlign.center,
                      style: context.textStyle.largeTitle.copyWith(
                        color: context.themeColors.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: AppPadding.horizontal,
                    child: Text(
                      GlobalVariables.applicationDesc,
                      textAlign: TextAlign.center,
                      style: context.textStyle.subtitle.copyWith(
                        color: context.themeColors.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  _bottomButtonWidget(
                    'Mulai',
                    _onTapGetStarted,
                    context.themeColors.primaryColor,
                    context.themeColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtonWidget(
    String label,
    VoidCallback onTap,
    Color buttonColor,
    Color textColor,
  ) {
    return CardContainer(
      height: 50,
      width: context.fullWidth * 0.9,
      color: buttonColor,
      onTap: onTap,
      child: Text(
        label,
        style: context.textStyle.title.copyWith(color: textColor),
      ),
    );
  }

  Widget _switchThemeButton() {
    return BlocBuilder<AppThemeCubit, AppThemeModel>(
      bloc: _appThemeCubit,
      builder: (context, state) {
        return CardContainer(
          height: 30,
          onTap: _onSwitchMode,
          borderRadius: AppBorderRadius.largeNumber,
          child: switch (_appThemeCubit.isDarkMode) {
            true => Row(
              spacing: 2,
              children: [Icon(Icons.dark_mode), Text("Dark")],
            ),
            false => Row(
              spacing: 2,
              children: [Icon(Icons.light_mode), Text("Light")],
            ),
          },
        );
      },
    );
  }
}
