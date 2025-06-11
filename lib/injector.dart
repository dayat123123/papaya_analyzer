import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:papayas_analyzer/core/local_storage/local_storage.dart';
import 'package:papayas_analyzer/core/router/app_navigator.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/features/history/presentation/bloc/history_bloc.dart';
import 'package:papayas_analyzer/main.dart';

GoRouter get getRouter => injector.get<GoRouter>();
AppThemeCubit get getAppThemeCubit => injector.get<AppThemeCubit>();
Tensorflow get getTensorflow => injector.get<Tensorflow>();
LocalStorage get getLocalStorage => injector.get<LocalStorage>();
HistoryBloc get getHistoryBloc => injector.get<HistoryBloc>();

Future<void> initializeApp() async {
  await _initDependency();
  await initializeDateFormatting('en', null);
  await getTensorflow.loadTFLiteModel();
}

Future<void> _initDependency() async {
  //**ROUTER (GoRouter) */
  injector.registerSingleton<LocalStorage>(LocalStorage());
  injector.registerSingleton<GoRouter>(AppNavigator.router);
  injector.registerSingleton<AppThemeCubit>(AppThemeCubit(getLocalStorage));
  injector.registerSingleton<Tensorflow>(Tensorflow(getLocalStorage));
  injector.registerLazySingleton<HistoryBloc>(() => HistoryBloc(getTensorflow));
}
