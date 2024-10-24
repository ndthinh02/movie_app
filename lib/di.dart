import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/home/data/data_source_remote/home_service.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';
import 'package:movie_app/features/home/domain/usecase/home_usecase.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';

import 'features/home/data/repositories/home_impl.dart';

final getIt = GetIt.instance;

void setUp() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerFactory(() => HomeService(getIt()));
  getIt.registerFactory<HomeRepo>(() => HomeImpl(getIt()));
  getIt.registerFactory<HomeUseCase>(() => HomeUseCase(getIt()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
}
