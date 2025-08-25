import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mmherbel/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mmherbel/core/network/dio_client.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

Future<void> initAuthInjection({required String baseUrl}) async {
  // ✅ Dio
  Dio dio = DioClient.create(baseUrl: baseUrl);

  // ✅ Retrofit API service
  final api = AuthApiService(dio, baseUrl: baseUrl);

  // ✅ DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api),
  );

  // ✅ Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // ✅ UseCase
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );

  // ✅ Bloc
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(sl()),
  );
}
