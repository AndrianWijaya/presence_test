import 'package:get/get.dart';
import 'package:presence_test/app/modules/attendance_history.dart/bindings/attendance_history_binding.dart';
import 'package:presence_test/app/modules/attendance_history.dart/views/attendance_history_view.dart';

import '../modules/add_pegawai/bindings/add_pegawai_binding.dart';
import '../modules/add_pegawai/views/add_pegawai_view.dart';
import '../modules/detail_presensi/bindings/detail_presensi_binding.dart';
import '../modules/detail_presensi/views/detail_presensi_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ADD_PEGAWAI,
      page: () => const AddPegawaiView(),
      binding: AddPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENSI,
      page: () => DetailPresensiView(),
      binding: DetailPresensiBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_HISTORY,
      page: () => const AttendanceHistoryView(),
      binding: AttendanceHistoryViewBinding(),
    ),
  ];
}
