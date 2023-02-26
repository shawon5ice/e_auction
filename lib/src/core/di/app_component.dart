// import 'package:bdjobs_recruiter/src/features/login/data/source/login_service.dart';
// import 'package:bdjobs_recruiter/src/features/login/domain/repository/login_repository.dart';
// import 'package:bdjobs_recruiter/src/features/login/presentation/controller/login_controller.dart';
// import 'package:bdjobs_recruiter/src/features/more_options/data/source/more_options_service.dart';
// import 'package:bdjobs_recruiter/src/features/more_options/domain/repository/more_options_repository.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get_it/get_it.dart';
//
// import '../../features/dashboard/data/repository/dashboard_repository_impl.dart';
// import '../../features/dashboard/data/source/dashboard_service.dart';
// import '../../features/dashboard/domain/repository/dashboard_repository.dart';
// import '../../features/authentication/data/repository/forgot_pass_repository_impl.dart';
// import '../../features/authentication/data/source/forget_pass_service.dart';
// import '../../features/authentication/domain/repository/forgot_pass_repository.dart';
// import '../../features/authentication/presentation/controller/forgot_password_controller.dart';
// import '../../features/job_list/total_applications/data/repository/all_jobList_repository_impl.dart';
// import '../../features/job_list/total_applications/data/source/AllJobListService.dart';
// import '../../features/job_list/total_applications/domain/repository/all_joblist_repository.dart';
// import '../../features/login/data/repository/login_repository_impl.dart';
// import '../../features/more_options/data/repository/more_options_repository_impl.dart';
// import '../../features/more_options/presentation/controller/more_options_page_controller.dart';
// import '../../features/service_package/data/data_sources/service_package_local_data_source.dart';
// import '../../features/service_package/data/repositories/service_repository_impl.dart';
// import '../../features/service_package/domain/repositories/service_repository.dart';
// import '../../features/service_package/domain/use_cases/get_service_charge_by_key.dart';
// import '../../features/service_package/domain/use_cases/get_services_and_packages.dart';
// import '../../features/service_package/presentation/controllers/service_package_controller.dart';
// import '../../features/signup/data/repository/signup_repository_impl.dart';
// import '../../features/signup/data/source/signUpService.dart';
// import '../../features/signup/domain/repository/signUpRepository.dart';
// import '../data/source/dio_client.dart';
// import '../data/source/pref_manager.dart';
// import '../network/configuration.dart';
// import '../session/session_manager.dart';
// import '../use-cases/sign_out_user_usecase.dart';
// part 'service_package_dependency.dart';
//
// final locator = GetIt.instance;
//
// Future<void> init() async {
//   locator.registerFactory<Dio>(() => Dio(NetworkConfiguration.baseOptions)
//     ..interceptors.add(InterceptorsWrapper()));
//   locator.registerFactory<SignInController>(() => Get.put(SignInController()));
//   // locator.registerFactory<ForgotPasswordController>(() => Get.put(ForgotPasswordController()));
//   locator.registerFactory<DioClient>(() => DioClient(locator<Dio>()));
//   locator.registerFactory<SignInService>(() => SignInService());
//   locator.registerFactory<SignInRepository>(() => SignInRepositoryImpl(locator<SignInService>()));
//
//   locator.registerFactory<MoreOptionsService>(() => MoreOptionsService());
//   locator.registerFactory<MoreOptionsRepository>(() => MoreOptionsRepositoryImpl());
//   locator.registerFactory<ForgotPasswordService>(() => ForgotPasswordService());
//   locator.registerFactory<ForgotPasswordRepository>(() => ForgotPasswordRepositoryImpl(locator<ForgotPasswordService>()));
//   locator.registerSingletonAsync<SessionManager>(() async =>
//       SessionManager(PrefManager(await SharedPreferences.getInstance())));
//
//   locator.registerFactory<SignUpService>(() => SignUpService());
//   locator.registerFactory<SignUpRepository>(
//           () => SignUpRepositoryImpl(locator<SignUpService>()));
//
//   locator.registerFactory<DashboardService>(() => DashboardService());
//   locator.registerFactory<DashboardRepository>(
//           () => DashboardRepositoryImpl(locator<DashboardService>()));
//
//   locator.registerFactory<AllJobListService>(() => AllJobListService());
//   locator.registerFactory<AllJobListRepository>(
//           () => AllJobListRepositoryImpl(locator<AllJobListService>()));
//
//   servicePackageInit();
// }
//
