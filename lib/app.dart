import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papayas_analyzer/core/router/app_navigator.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/injector.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getAppThemeCubit),
        BlocProvider(create: (context) => getHistoryBloc),
      ],
      child: BlocBuilder<AppThemeCubit, AppThemeModel>(
        builder: (context, themeState) {
          final systemOverlayStyle =
              themeState.themeData.appBarTheme.systemOverlayStyle ??
              SystemUiOverlayStyle.light;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemOverlayStyle,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: themeState.themeData,
              routerConfig: AppNavigator.router,
            ),
          );
        },
      ),
    );
  }
}
