import 'package:get_it/get_it.dart';
import 'package:movies_list_app/layers/data/datasource/api_service.dart';
import 'package:movies_list_app/layers/data/repositories/api_repository_impl.dart';
import 'package:movies_list_app/layers/domain/repositories/api_repository.dart';


final locator = GetIt.instance;

Future<void> registerDependencies()async{
  locator.registerSingleton<ApiService>(
    ApiService(
      
    ),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(apiService: locator<ApiService>()),
  );
}