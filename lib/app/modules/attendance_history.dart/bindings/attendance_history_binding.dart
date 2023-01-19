import 'package:get/get.dart';

import '../controllers/attendance_history_controller.dart';

class AttendanceHistoryViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceHistoryController>(
      () => AttendanceHistoryController(),
    );
  }
}
