import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:suitmedia_competency_test/core/constant/constants.dart';
import 'package:suitmedia_competency_test/features/palindrome/domain/usecases/check_palindrome.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_bloc.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/data/data_sources/remote/reqres_user_api_service.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/data/repository/reqres_user_repository_impl.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/repository/reqres_user_repository.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/usecase/get_reqres_user_usercase.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/reqres_user_list_bloc.dart';
import 'package:suitmedia_competency_test/features/selected_user/presentation/bloc/selected_user_bloc.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = reqresBaseUrl;
    return dio;
  });

  sl.registerLazySingleton(() => ReqresUserApiService(sl()));
  // Repositories
  sl.registerLazySingleton<ReqresUserRepository>(
    () => ReqresUserRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => CheckPalindromeUseCase());
  sl.registerLazySingleton(() => GetReqresUserUsecase(sl()));

  sl.registerFactory(() => PalindromeBloc(checkPalindromeUseCase: sl()));
  sl.registerFactory(() => SelectedUserBloc());
  sl.registerFactory(() => ReqresUserBloc(sl()));
}
