import 'package:get/get.dart';

class LoadingController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showLoading() {
    _isLoading = true;
    update();
  }

  void hideLoading() {
    _isLoading = false;
    update();
  }
}
