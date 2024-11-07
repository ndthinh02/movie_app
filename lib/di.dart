import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/auth/data/data_source/auth_service.dart';
import 'package:movie_app/features/auth/data/repository/auth_impl.dart';
import 'package:movie_app/features/auth/domain/repository/signin_repo.dart';
import 'package:movie_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/features/detail/data/data_source/detail_service.dart';
import 'package:movie_app/features/detail/data/repositories/detail_impl.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repo.dart';
import 'package:movie_app/features/detail/domain/usecases/detail_usecase.dart';
import 'package:movie_app/features/detail/presentation/bloc/detail_bloc.dart';
import 'package:movie_app/features/favorite/data/repository/favorite_impl.dart';
import 'package:movie_app/features/favorite/domain/repository/favorite_repository.dart';
import 'package:movie_app/features/favorite/domain/use_case/favorite_usecase.dart';
import 'package:movie_app/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:movie_app/features/home/data/data_source_remote/home_service.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';
import 'package:movie_app/features/home/domain/usecase/home_usecase.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/more/data/data_source/more_service.dart';
import 'package:movie_app/features/more/data/repo/more_repo_impl.dart';
import 'package:movie_app/features/more/domain/repo/more_repo.dart';
import 'package:movie_app/features/more/domain/use_case/more_use_case.dart';
import 'package:movie_app/features/more/presentation/bloc/more_bloc.dart';
import 'package:movie_app/features/search/data/data_source/search_service.dart';
import 'package:movie_app/features/search/domain/repositories/search_repo.dart';
import 'package:movie_app/features/search/domain/usecases/search_usecase.dart';
import 'package:movie_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:movie_app/features/setting/data/data_source/user_service.dart';
import 'package:movie_app/features/setting/data/repository/user_repository_impl.dart';
import 'package:movie_app/features/setting/domain/repository/user_repository.dart';
import 'package:movie_app/features/setting/domain/usecase/user_use_case.dart';
import 'package:movie_app/features/setting/presentation/bloc/setting_bloc.dart';

import 'features/home/data/repositories/home_impl.dart';
import 'features/search/data/repositories/search_impl.dart';

final getIt = GetIt.instance;

void setUp() {
  //event bus
  getIt.registerSingleton<EventBus>(EventBus());
  //home
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerFactory(() => HomeService(getIt()));
  getIt.registerFactory<HomeRepo>(() => HomeImpl(getIt()));
  getIt.registerFactory<HomeUseCase>(() => HomeUseCase(getIt()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
//detail
  getIt.registerFactory(() => DetailService(getIt()));
  getIt.registerFactory<DetailRepo>(() => DetailImpl(getIt()));
  getIt.registerFactory<DetailUseCase>(() => DetailUseCase(getIt()));
  getIt.registerFactory<DetailBloc>(() => DetailBloc(getIt()));
//search
  getIt.registerFactory(() => SearchService(getIt()));
  getIt.registerFactory<SearchRepo>(() => SearchImpl(getIt()));
  getIt.registerFactory<SearchUseCase>(() => SearchUseCase(getIt()));
  getIt.registerFactory<SearchBloc>(() => SearchBloc(getIt()));

  //auth
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerFactory<AuthService>(() => AuthService(getIt()));
  getIt.registerFactory<AuthRepo>(() => AuthImpl(getIt()));
  getIt.registerFactory<AuthUseCase>(() => AuthUseCase(getIt()));
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt()));
  //fav
  // getIt.registerFactory<AuthService>(() => AuthService(getIt()));
  getIt.registerFactory<FavoriteRepository>(() => FavoriteImpl());
  getIt.registerFactory<FavoriteUseCase>(() => FavoriteUseCase(getIt()));
  getIt.registerFactory<FavoriteBloc>(() => FavoriteBloc(getIt()));
  //setting

  getIt.registerFactory<UserService>(() => UserService());
  getIt.registerFactory<UserRepository>(() => UserRepositoryImpl(getIt()));
  getIt.registerFactory<UserUseCase>(() => UserUseCase(getIt()));
  getIt.registerFactory<SettingBloc>(() => SettingBloc(getIt()));
// more
  getIt.registerFactory<MoreService>(() => MoreService(getIt()));
  getIt.registerFactory<MoreRepo>(() => MoreRepoImpl(getIt()));
  getIt.registerFactory<MoreUseCase>(() => MoreUseCase(getIt()));
  getIt.registerFactory<MoreBloc>(() => MoreBloc(getIt()));
}
