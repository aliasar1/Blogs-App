import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  void setIsLogin(bool status) {
    final box = GetStorage();
    box.write('isLogin', status);
  }

  bool? getIsLogin() {
    final box = GetStorage();
    return box.read('isLogin');
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove('isLogin');
  }
}
