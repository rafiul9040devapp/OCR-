import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ocr_medical_department/api_setup/auth_api_service.dart';
import 'package:ocr_medical_department/api_setup/constants.dart';
import 'package:ocr_medical_department/api_setup/preferences/token_storage.dart';
import 'package:ocr_medical_department/api_setup/preferences/user_id_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  sl.registerLazySingleton<TokenStorage>(
      () => TokenStorage(sl<SharedPreferences>()));
  sl.registerLazySingleton<UserIdStorage>(
      () => UserIdStorage(sl<SharedPreferences>()));

  sl.registerLazySingleton<AuthApiService>(
      () => AuthApiService(sl<Dio>(), sl<TokenStorage>(), sl<UserIdStorage>()));

  // sl.registerSingleton<NewsApiService>(NewsApiService(sl<Dio>()));
  //
  // sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl<NewsApiService>()));
  //
  // sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl<ArticleRepository>()));
  //
  // sl.registerFactory<RemoteArticlesBloc>(()=> RemoteArticlesBloc(sl<GetArticleUseCase>()));
}
