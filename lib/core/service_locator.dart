import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void setup() {
    /// Register your services here
    // sl.registerLazySingleton<Database>(() => RestApiDatabase());
    // sl.registerLazySingleton<Database>(() => FirebaseDatabase());
    // sl.registerLazySingleton<Database>(() => HiveDatabase());
    // sl.registerLazySingleton<Database>(() => SQLDatabase());
    // sl.registerLazySingleton<Database>(() => SPDatabase());
    // sl.registerLazySingleton<Database>(() => AnyOtherDatabase());

    /// Register your repositories here
    // sl.registerLazySingleton<UserRepository>(() => UserRepository(db: sl<Database>()));
  }
}
